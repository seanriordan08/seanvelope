class BasinMetrics::DashboardController < ApplicationController

  def index
    @cutomers = BasinMetrics::Customer.all
  end
end
