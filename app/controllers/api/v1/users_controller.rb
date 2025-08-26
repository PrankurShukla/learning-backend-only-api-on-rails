class Api::V1::UsersController < ApplicationController
    skip_before_action :authorize_request, only: [:create]

    def create
        user = User.new(user_params)
        if user.save
            render json: { id: user.id, email: user.email }, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
