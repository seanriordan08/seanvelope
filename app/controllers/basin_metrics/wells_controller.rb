class BasinMetrics::WellsController < ApplicationController

  def index
    @wells = BasinMetrics::Well.all
    @wells = @wells.map(&:attributes).to_json.html_safe

    @test = "the test"
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def new
    @well = BasinMetrics::Well.new
  end

end
