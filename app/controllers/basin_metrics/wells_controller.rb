class BasinMetrics::WellsController < ApplicationController

  def index
    @wells = BasinMetrics::Well.all
    if @wells.present?
      respond_to do |format|
        format.js { render 'basin_metrics/wells/index', layout: false, locals: { wells: @wells } }
      end
    else
      # binding.pry
      render js: "alert('No Wells Added')"
    end
  end

  def new
    @well = BasinMetrics::Well.new
  end

end
