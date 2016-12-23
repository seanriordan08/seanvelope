class BasinMetrics::DashboardController < ApplicationController

  def index
    @cutomers = Customer.all
  end
end
