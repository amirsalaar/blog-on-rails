class UsersController < ApplicationController
    before_action :find_user, only: [:edit, :update]

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

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def find_user
        @user = User.find(params[:id])
    end
end
