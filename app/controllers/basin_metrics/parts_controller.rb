class BasinMetrics::PartsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_parts

  PARTS_LIST_TITLE = 'INVENTORY'

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
    part_params[:name] = part_params[:name].strip.downcase.parameterize.underscore
    @part = BasinMetrics::Part.new(part_params)

    if @part.save
      get_parts
      flash.now[:success] = 'Part created'
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    else
      flash.now[:error] = @part.errors.full_messages.first
      respond_to do |format|
        format.js { render 'new', layout: false }
      end
    end
  end

  def update
    part_params[:name] = clean_name_param(part_params[:name])
    @part = BasinMetrics::Part.find(part_params[:id])

    if @part.update(part_params)
      get_parts
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    else
      flash.now[:error] = @part.errors.full_messages.first
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    end
  end

  def destroy
    @part = BasinMetrics::Part.find(part_params[:id])

    if @part.destroy
      get_parts
      flash.now[:success] = 'Part deleted'
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    else
      flash.now[:error] = @part.errors.full_messages.first
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    end
  end

  private

  def part_params
    if params[:basin_metrics_part]
      params.require(:basin_metrics_part).permit(:name, :type, :number, :size, :order, :quantity, :revenue, :date_sold, :district_id)
    else
      params.permit(:id, :name, :type, :number, :size, :order, :quantity, :revenue, :date_sold, :district_id)
    end
  end

  def get_parts
    @parts = current_user.reload.company.parts
    @parts = @parts.map(&:attributes).to_json.html_safe
  end

end
