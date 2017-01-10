class BasinMetrics::CustomersController < ApplicationController

  before_action :get_customers

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
    params[:basin_metrics_customer][:name] = params[:basin_metrics_customer][:name].strip.downcase.parameterize.underscore
    params[:basin_metrics_customer].merge!(company_id: "#{current_user.company.id}")
    @customer = BasinMetrics::Customer.new(customer_params)

    if @customer.save
      get_customers
      flash.now[:success] = 'Customer created'
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    else
      flash.now[:error] = @customer.errors.full_messages.first
      respond_to do |format|
        format.js { render 'new', layout: false }
      end
    end
  end

  def update
    customer_params[:name] = clean_name_param(customer_params[:name])
    @customer = BasinMetrics::Customer.find(customer_params[:id])

    if @customer.update(customer_params)
      get_customers
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    else
      flash.now[:error] = @customer.errors.full_messages.first
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    end
  end

  def destroy
    @customer = BasinMetrics::Customer.find(customer_params[:id])

    if @customer.destroy
      get_customers
      flash.now[:success] = 'Customer deleted'
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    else
      flash.now[:error] = @customer.errors.full_messages.first
      respond_to do |format|
        format.js { render 'index', layout: false }
      end
    end
  end


  private

  def customer_params
    if params[:basin_metrics_customer]
      params.require(:basin_metrics_customer).permit(:name, :company_id)
    else
      params.permit(:id, :name, :company_id)
    end
  end

  def get_customers
    @customers = current_user.reload.company.customers
    @customers = @customers.map(&:attributes).to_json.html_safe
  end

end