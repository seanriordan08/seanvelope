class BasinMetrics::DashboardController < ApplicationController

  before_action :authenticate_user!

  def index
    @customers = current_user.company.customers
    @districts = current_user.company.districts
  end

end
