class BasinMetrics::MapsController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.js { render layout: false }
    end
  end

end
