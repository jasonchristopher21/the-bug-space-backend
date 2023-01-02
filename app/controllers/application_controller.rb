class ApplicationController < ActionController::API

    include JwtToken

    before_action :authenticate_user
    attr_reader :current_user

    private

    # Authenticates a user by the Authorization header of the HTTP request.
    # 
    # If the user is not found in the record, or if the token in the Authorization
    # header cannot be decoded, a reply containing the error message and an
    # UNAUTHORIZED status will be rendered.
    def authenticate_user
    
        header = request.headers['Authorization']

        begin
            @decoded = JwtToken.decode(header)
            @current_user = User.find(@decoded[:user_id])

        rescue ActiveRecord::RecordNotFound => e
            render json: { errors: e.message }, status: :unauthorized

        rescue JWT::DecodeError => e
            render json: { errors: e.message }, status: :unauthorized

        end

    end

end