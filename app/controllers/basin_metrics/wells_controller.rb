class BasinMetrics::WellsController < ApplicationController

  def index
    @wells = BasinMetrics::Well.all

    @test = "the test"
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def new
    @well = BasinMetrics::Well.new
  end

end
