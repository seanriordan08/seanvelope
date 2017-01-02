class BasinMetrics::DistrictsController < ApplicationController

  before_action :get_districts

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
    @district = BasinMetrics::District.new(district_params)

    if @district.save
      get_districts
      flash.now[:success] = 'District created'
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    else
      flash.now[:error] = @district.errors.full_messages.first
      respond_to do |format|
        format.js { render 'new', layout: false }
      end
    end
  end

  def update
    @district = BasinMetrics::District.find(district_params[:id])

    if @district.update(district_params)
      get_districts
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    else
      flash.now[:error] = @district.errors.full_messages.first
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    end
  end

  def destroy
    @district = BasinMetrics::District.find(district_params[:id])

    if @district.destroy
      get_districts
      flash.now[:success] = 'District deleted'
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    else
      flash.now[:error] = @district.errors.full_messages.first
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    end
  end


  private

  def district_params
    if params[:basin_metrics_district]
      params.require(:basin_metrics_district).permit(:name)
    else
      params.permit(:id, :name)
    end
  end

  def get_districts
    @districts = BasinMetrics::District.all
    @districts = @districts.map(&:attributes).to_json.html_safe
  end
end
