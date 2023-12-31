class Api::AuthenticationController < ApplicationController
  def login
    @user = User.find_by_email(params[:user][:email])
    if @user&.authenticate(params[:user][:password])
      token = create_token(@user.id)
      render json: {user: {name: @user.name, email: @user.email, token: token, header: request.headers[:authorization]}}
    else
      render status: :unauthorized
    end
  end
end
