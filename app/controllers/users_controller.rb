class UsersController < ApplicationController

    def create
        @user = User.create(user_params)

        if @user.valid?
            token =encode_token( { user_id: @user.id })
            render json: { token: token}, status: :ok
        else
            render json: { error: "Unable to log in with provided credentials"}, status: :unprocessable_entity
        end 
    end

    def auth
        @user = User.find_by(email: user_params[:email])

        if @user && @user.authenticate(user_params[:password])
            token =encode_token( { user_id: @user.id })
            render json: { token: token}, status: :ok
        else
            render json: { error: "Unable to log in with provided credentials"}, status: :unprocessable_entity
        end

    end

    private

    def user_params
        params.permit(:email, :password)
    end

end
