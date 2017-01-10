class BasinMetrics::WellsController < ApplicationController

  before_action :get_wells
  before_action :set_est_schedule_attributes, only: [:update]

  DATETIME_FIELDS = %w(work_start work_duration)

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
    well_params[:name] = well_params[:name].strip.downcase.parameterize.underscore
    @well = BasinMetrics::Well.new(well_params)

    if @well.save
      get_wells
      flash.now[:success] = 'Well created'
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

  def show
    @well = BasinMetrics::Well.find(well_params[:id])
    @well = @well.attributes.to_json.html_safe

    respond_to do |format|
      format.js { render 'show', layout: false }
    end
  end

  def update
    well_params[:name] = clean_name_param(well_params[:name]) if well_params[:name].present?
    @well = BasinMetrics::Well.find(well_params[:id])

    if @well.update(well_params)
      get_wells
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    else
      flash.now[:error] = @well.errors.full_messages.first
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    end
  end

  def destroy
    @well = BasinMetrics::Well.find(well_params[:id])

    if @well.destroy
      get_wells
      flash.now[:success] = 'Well deleted'
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    else
      flash.now[:error] = @well.errors.full_messages.first
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    end
  end

  private

  def well_params
    if params[:basin_metrics_well]
      params.require(:basin_metrics_well).permit!
    else
      params.permit(:id, :name, :number, :est_schedule_range, :est_start, :actual_start, :est_end, :completed, :pump_down_ring, :cemented, :customer_id, :district_id, :comments, :percent_complete)
    end
  end

  def get_wells
    @wells = current_user.company.wells
    @wells = @wells.map(&:attributes).to_json.html_safe
  end

  def set_est_schedule_attributes
    return if well_params[:est_schedule_range].blank?

    est_sch_range = params[:est_schedule_range]

    if est_sch_range.present?
      params.merge!(parseEstDateRange(est_sch_range))
      params.delete('est_schedule_range')
    end
  end

  def parseEstDateRange(sch_range)
    ranges = sch_range.split(' to ')
    {est_start: ranges.first, est_end: ranges.last}
  end


end
