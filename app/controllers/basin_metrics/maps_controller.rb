class BasinMetrics::MapsController < ApplicationController

  def index
    respond_to do |format|
      format.js { render layout: false }
    end
  end

end
