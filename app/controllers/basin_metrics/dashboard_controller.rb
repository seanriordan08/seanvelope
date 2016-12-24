class BasinMetrics::DashboardController < ApplicationController

  before_action :authenticate_user!

  def index
    @customers = BasinMetrics::Customer.all
  end
end
