class BasinMetrics::ReservationsController < ApplicationController
  before_action :authenticate_user!

  def create
    binding.pry
    part_id = BasinMetrics::Part.where(type: params['inventory_value']).first.id
    @reservation = BasinMetrics::Reservation.new(well_id: params[:id], part_id: part_id, quantity: params['qty_value'].to_i)
    if @reservation.save
      get_wells
      flash.now[:success] = 'Inventory reserved'
      respond_to do |format|
        format.js { render '/wells/index', layout: false }
      end
    else
      flash.now[:error] = 'Inventory reservation failed'
      respond_to do |format|
        format.js { render '/wells/index', layout: false }
      end
    end
  end

  private

  def reservation_params
    if params[:basin_metrics_well]
      params.require(:basin_metrics_well).permit!
    else
      params.permit(:id, :name, :number, :est_schedule_range, :est_start, :actual_start, :est_end, :completed, :revenue, :pump_down_ring, :cemented, :customer_id, :district_id, :comments, :percent_complete)
    end
  end

  def get_wells
    @wells = current_user.reload.company.wells
    @wells = @wells.map(&:attributes).to_json.html_safe
  end

end
