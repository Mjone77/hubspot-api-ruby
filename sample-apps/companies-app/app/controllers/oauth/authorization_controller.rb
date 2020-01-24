module Oauth
  class AuthorizationController < ApplicationController
    skip_before_action :require_login

    def authorize
      url = Services::Authorization::GetAuthorizationUri.new(request: request).call
      redirect_to url
    end

    def callback
      session[:tokens] = Services::Authorization::Tokens::Generate.new(
        code: params[:code],
        request: request
      ).call
      Services::Authorization::AuthorizeHubspot.new(tokens: session[:tokens]).call
      redirect_to '/companies'
    end

    def login;end
  end
end
