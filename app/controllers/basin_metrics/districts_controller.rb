class BasinMetrics::DistrictsController < ApplicationController
  before_action :authenticate_user!
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
    params[:basin_metrics_district][:name] = params[:basin_metrics_district][:name].strip.downcase.parameterize.underscore
    params[:basin_metrics_district].merge!(company_id: "#{current_user.company.id}")
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
      params.require(:basin_metrics_district).permit(:name, :company_id)
    else
      params.permit(:id, :name, :company_id)
    end
  end

  def get_districts
    @districts = current_user.reload.company.districts
    @districts = @districts.map(&:attributes).to_json.html_safe
  end
end
