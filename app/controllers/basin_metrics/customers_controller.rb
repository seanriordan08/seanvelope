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

  private

  def get_customers
    @customers = BasinMetrics::Customer.all
    @customers = @customers.map(&:attributes).to_json.html_safe
  end
end
