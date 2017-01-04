class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    basin_metrics_dashboard_path
  end

  def clean_name_param(name_param)
    return if name_param.blank?
    name_param.strip.downcase.parameterize.underscore
  end

end
