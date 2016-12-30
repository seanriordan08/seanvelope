module PartsHelper

  def get_well(id)
    BasinMetrics::Well.find(id)
  end

  def get_parts_options
    well_ids = BasinMetrics::Well.all.map(&:id)
    well_numbers = BasinMetrics::Well.all.map(&:number)
    wells_build_options(well_ids, well_numbers)
  end

  def get_monthly_plug_quantities
    quantity_by_month = []
    (1..12).each do |m|
      first_day = Date.civil(2016, m, 1).to_datetime.utc
      last_day = Date.civil(2016, m, -1).to_datetime.utc
      plugs = BasinMetrics::Part.where(name: 'plug', date_sold: first_day..last_day)
      quantity = plugs.collect(&:quantity)
      quantity_by_month << quantity.sum
    end
    quantity_by_month
  end

  private

  def wells_build_options(ids, numbers)
    options = [['well number', '']]
    ids.each_with_index do |part_id, index|
      options << [numbers[index], part_id]
    end
    options
  end

end
