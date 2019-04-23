class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:edit, :update, :change_password, :update_password]
    before_action :find_user, only: [:edit, :update, :change_password, :update_password]
    before_action :authorize!, only: [:edit,:update,:change_password, :update_password]

    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            render :new
        end
    end
    
    def edit
        
    end
    
    def update
        if @user.update user_params
            flash[:success] = "Your information updated successfully!"
            redirect_to root_path
        else
            flash[:danger] = "Resolve the following errors!"
            render :edit
        end
    end

    def change_password
        
    end
    
    def update_password
        if @user.authenticate(params[:current_password])
            if params[:new_password] == params[:current_password]
                flash[:danger] = "New password cannot be the same as your old password!"
                render :change_password
            else
                check_update_password
            end
        else
            flash[:danger] = "Your current password is invalid!"
            render :change_password
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def find_user
        @user = User.find(params[:id])
    end

    def check_update_password
        if params[:new_password] == params[:new_password_confirmation]
            if @user.update(password: params[:new_password])
                flash[:success] = "Your password updated!"
                redirect_to edit_user_path(@user)
            else
                render :change_password
            end  
        else
            flash[:danger] = "Password confirmation does not match to your new password!"
            render :change_password
        end
    end

    def authorize!
        unless can?(:crud, @user)
            head :unauthorized
        end
    end
end
