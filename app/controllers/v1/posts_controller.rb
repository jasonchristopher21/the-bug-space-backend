class V1::PostsController < ApplicationController

    before_action :find_post, only: [:show, :update, :destroy]

    # GET /v1/posts
    def index
        @posts = Post.all
        render json: @posts, status: :ok
    end

    # POST /v1/posts
    def create
        @post = Post.new(post_params)
        if @post.save
            render json: @post, status: :created
        else
            render json: { errors: @post.errors.full_messages }, status: 503
        end
    end

    # PUT /v1/posts/:id
    def update
        unless @post.update(post_params)
            render json: { errors: @post.errors.full_messages }, status: 503
        end
    end

    # GET /v1/posts/:id
    def show
        render json: @post, status: :ok
    end

    # DELETE /v1/posts/:id
    def destroy
        if @post.destroy
            head(:ok)
        else
            head(:unprocessable_entity)
        end
    end

    private

    # Extracts the parameters for creating the post instance.
    # Required parameters include the title, body, upvotes and the current user id
    def post_params
        params.permit(:title, :body, :upvotes, :user_id)
    end

    # Finds the user instance by the specified user id.
    def find_post
        @post = Post.find(params[:id])
    end
    
end
