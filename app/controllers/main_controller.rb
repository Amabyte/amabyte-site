class MainController < ApplicationController
  def index
  end

  def contact_us
    if params[:name].present? && params[:from].present? && params[:message].present?
      render json: {message: "Thank you for contacting us. We'll get back to you soon!"}
    else
      render json: {error: "Required parameter missing."}, status: :not_acceptable
    end
  end
end