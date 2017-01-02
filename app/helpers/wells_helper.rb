module WellsHelper

  def get_customers_options
    customer_ids = BasinMetrics::Customer.all.map(&:id)
    customer_names = BasinMetrics::Customer.all.map(&:name)

    build_options(customer_ids, customer_names)
  end

  def get_customer_well_counts
    customers = BasinMetrics::Customer.all
    well_count = customers.collect do |c|
      BasinMetrics::Well.where(customer_id: c).size
    end
  end

  def get_districts_options
    district_ids = BasinMetrics::District.all.map(&:id)
    district_names = BasinMetrics::District.all.map(&:name)

    build_options(district_ids, district_names)
  end

  def get_background_colors
    customer_count = BasinMetrics::Customer.all.collect(&:name).size
    background_colors = []
    customer_count.times {background_colors << 'rgba(75, 192, 192, 0.2)'}
    background_colors
    # [ 'rgba(255, 99, 132, 0.2)', 'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)', 'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)', 'rgba(255, 159, 64, 0.2)']
  end

  def get_border_colors
    customer_count = BasinMetrics::Customer.all.collect(&:name).size
    border_colors = []
    customer_count.times {border_colors << 'rgba(75, 192, 192, 1)'}
    border_colors
    # ['rgba(255,99,132,1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)', 'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)', 'rgba(255, 159, 64, 1)']
  end

  private

  def build_options(ids, names)
    options = []
    ids.each_with_index do |id, index|
      options << [names[index], id]
    end
    options
  end
end
