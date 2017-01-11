module WellsHelper

  def format_date(time)
    DateTime.parse(time).strftime('%b %d, %Y')
  end

  def get_customers_options
    customer_ids = current_user.company.customers.order(:name).map(&:id)
    customer_names = current_user.company.customers.order(:name).map(&:name)

    build_options(customer_ids, customer_names)
  end

  def get_customer_well_counts
    well_x_label = 'Customer'
    well_y_label = 'Well Count'
    customers = BasinMetrics::Customer.all.order(:name)
    well_count_array = customers.collect do |c|
      current_user.company.wells.where(customer_id: c).size
    end
    {array: well_count_array, x_label: well_x_label, y_label: well_y_label}
  end

  def get_districts_options
    district_ids = current_user.company.districts.order(:name).map(&:id)
    district_names = current_user.company.districts.order(:name).map(&:name)

    build_options(district_ids, district_names)
  end

  def get_background_colors
    customer_count = BasinMetrics::Customer.all.order(:name).collect(&:name).size
    background_colors = []
    customer_count.times {background_colors << 'rgba(75, 192, 192, 0.2)'}
    background_colors
    # [ 'rgba(255, 99, 132, 0.2)', 'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)', 'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)', 'rgba(255, 159, 64, 0.2)']
  end

  def get_border_colors
    customer_count = BasinMetrics::Customer.all.order(:name).collect(&:name).size
    border_colors = []
    customer_count.times {border_colors << 'rgba(75, 192, 192, 1)'}
    border_colors
    # ['rgba(255,99,132,1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)', 'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)', 'rgba(255, 159, 64, 1)']
  end

  def get_monthly_wells_completed
    get_completion_revenue_quantities('completed')
  end

  private

  def build_options(ids, names)
    options = []
    ids.each_with_index do |id, index|
      options << [names[index], id]
    end
    options
  end

  def get_completion_revenue_quantities(target_attribute)
    current_year = Time.zone.now.strftime('%Y').to_i
    last_year = Time.zone.now.last_year.strftime('%Y').to_i
    well_x_label = "#{last_year} to #{current_year}"
    well_y_label = 'Quantity'
    completions_by_month = []
    revenues_by_month = []
    [last_year,current_year].each do |y|
      (1..12).each do |m|
        first_day = Date.civil(y, m, 1).to_datetime.utc
        last_day = Date.civil(y, m, -1).to_datetime.utc
        completions = current_user.company.wells.where("#{target_attribute}": first_day..last_day)
        revenues = current_user.company.wells.where("#{target_attribute}": first_day..last_day, revenue: 0..Float::INFINITY).map(&:revenue)
        completions_by_month << completions.size
        revenues_by_month << revenues.sum
      end
    end
    revenues_by_month.map!{|r| r/1000}
    {completion_array: completions_by_month, revenue_array: revenues_by_month, x_label: well_x_label, y_label: well_y_label}
  end

end
