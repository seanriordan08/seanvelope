class BasinMetrics::WellsController < ApplicationController

  def index
    @wells = BasinMetrics::Well.all
    @wells = @wells.map(&:attributes).to_json.html_safe

    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def new
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def create
    binding.pry
    @well = BasinMetrics::Well.create(name: params[:name], number: params[:number])
  end

end
