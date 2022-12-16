class V1::UsersController < ApplicationController

    # Lists all the users present in the current database (users table)
    def index
        @users = User.all
        render json: @users, status: :ok
    end

    # Creates a new User instance
    def create
        @user = User.new(user_params)
        @user.save
        render json: @user, status: :created
    end

    # Removes a user instance from the users table by specifying the id
    def destroy
        @user = User.where(id: params[:id]).first
        if @user.destroy
            head(:ok)
        else
            head(:unprocessable_entity)
        end
    end

    private

    # Extracts the parameters for creating the user instance.
    # Required parameters include the name, username, email and password digest.
    def user_params
        params.require(:contact).permit(:name, :username, :email, :password_digest)
    end
    
end
