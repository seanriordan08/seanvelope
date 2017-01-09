module PartsHelper

  def get_part_headings
    base_headings = BasinMetrics::Part.first
    base_headings = base_headings.attribute_names
    omission = %w(id created_at updated_at)

    base_headings.insert(1, 'customer')
    omission.each do |omit_value|
      base_headings.delete_at(base_headings.index(omit_value))
    end

    base_headings
  end

  def get_part_customer_name(part_id)
    well_id = BasinMetrics::Part.where(id: part_id).first.well_id
    customer_id = BasinMetrics::Well.where(id: well_id).first.customer_id
    BasinMetrics::Customer.find(customer_id).name.titleize
  end

  def get_well(id)
    BasinMetrics::Well.where(id: id).first
  end

  def get_parts_options
    well_ids = BasinMetrics::Well.all.map(&:id)
    well_numbers = BasinMetrics::Well.all.map(&:number)
    wells_build_options(well_ids, well_numbers)
  end

  def get_monthly_plugs_sold
    get_plug_quantities('date_sold')
  end

  def select_options_tag(name='',select_options={},options={})
    #set selected from value
    selected = ''
    unless options[:value].blank?
      selected = options[:value]
      options.delete(:value)
    end
    select_tag(name,options_for_select(select_options,selected),options)
  end

  private

  def get_plug_quantities(target_attribute)
    current_year = Time.zone.now.strftime('%Y').to_i
    well_x_label = "Month of #{current_year}"
    well_y_label = 'Quantity'
    quantity_by_month = []
    (1..12).each do |m|
      first_day = Date.civil(current_year, m, 1).to_datetime.utc
      last_day = Date.civil(current_year, m, -1).to_datetime.utc
      plugs = BasinMetrics::Part.where(name: 'plug', "#{target_attribute}": first_day..last_day)
      quantity = plugs.collect(&:quantity)
      quantity_by_month << quantity.sum
    end
    {array: quantity_by_month, x_label: well_x_label, y_label: well_y_label}
  end

  def wells_build_options(ids, numbers)
    options = [['well number', '']]
    ids.each_with_index do |part_id, index|
      options << [numbers[index], part_id]
    end
    options
  end

end
