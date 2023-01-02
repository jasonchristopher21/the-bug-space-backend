class V1::UsersController < ApplicationController

    skip_before_action :authenticate_user, only: [:create]
    before_action :find_user, only: [:show, :update, :destroy]

    # Lists all the users present in the current database (users table)
    # 
    # GET /v1/users
    def index
        @users = User.all
        render json: @users, status: :ok
    end

    # Creates a new User instance
    # 
    # POST /v1/users
    def create
        @user = User.new(user_params)
        if @user.save
            render json: @user, status: :created
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # Updates a user instance
    # 
    # PUT /v1/users/:id
    def update
        unless @user.update(user_params)
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # Shows the details of a user, specified by the params required in #user_params
    # 
    # GET /v1/users/:id
    def show
        render json: @user, status: :ok
    end

    # Removes a user instance from the users table by specifying the id
    # 
    # Returns an OK status if the user can be removed from the table, else
    # returns an UNPROCESSABLE_ENTITY status
    # 
    # DELETE /v1/users/:id
    def destroy
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
        params.permit(:name, :username, :email, :password)
    end

    # Finds the user instance by the specified user id.
    def find_user
        @user = User.find(params[:id])
    end
    
end
