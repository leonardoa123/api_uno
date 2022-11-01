class UsersController < ApplicationController

    def create
        @user = User.create(user_params)

        if @user.valid?
            token =encode_token( { ussur_id: @user.id })

            render json: { user: @user, token: token}, status: :ok
        else
            render joson: { error: "Invalid user or password"}, status: unprocesable_entity
        end
    end


    private

    def user_params
        params.permit(:email, :password)
    end

end
