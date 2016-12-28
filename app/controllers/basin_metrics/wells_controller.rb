class BasinMetrics::WellsController < ApplicationController

  before_action :get_wells

  def index

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
    @well = BasinMetrics::Well.new(well_params)

    if @well.save
      get_wells
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    else
      flash.now[:error] = @well.errors.full_messages.first
      respond_to do |format|
        format.js { render 'new', layout: false }
      end
    end


  end

  private

  def well_params
    params.require(:basin_metrics_well).permit(:name, :number, :pump_running, :cemented, :customer_id, :district_id)
  end

  def get_wells
    @wells = BasinMetrics::Well.all
    @wells = @wells.map(&:attributes).to_json.html_safe
  end

end
