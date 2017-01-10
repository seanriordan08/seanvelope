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
    district_params[:name] = district_params[:name].strip.downcase.parameterize.underscore
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

  def show
    @district = BasinMetrics::District.find(district_params[:id])
    @district = @district.attributes.to_json.html_safe

    respond_to do |format|
      format.js { render 'show', layout: false }
    end
  end

  def update
    district_params[:name] = clean_name_param(district_params[:name])
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
    @districts = current_user.reload.company.districts
    @districts = @districts.map(&:attributes).to_json.html_safe
  end
end
