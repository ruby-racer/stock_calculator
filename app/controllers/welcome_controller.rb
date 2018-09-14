class WelcomeController < ApplicationController
  def home
    redirect_to stocks_path unless current_user.nil?
  end
end
