module DistrictHelper

  COLOR_PRESENT = '#298889'
  COLOR_PRESENT_HOVER = '#33A8AA'
  COLOR_ABSENT = '#243038'
  COLOR_ABSENT_HOVER = '#2D3D47'

  def get_district_headings
    base_headings = BasinMetrics::District.first
    base_headings = base_headings.attribute_names
    omission = %w(id)

    omission.each do |omit_value|
      base_headings.delete_at(base_headings.index(omit_value))
    end

    base_headings.unshift('')
    base_headings
  end

  def get_district_well_counts
    x_label = 'District'
    y_label = 'Well Count'
    district_well_count = BasinMetrics::District.connection.select_all("SELECT districts.name, COUNT(wells.name) as well_name FROM `districts` LEFT JOIN `wells` ON `wells`.`district_id` = `districts`.`id` GROUP BY `districts`.`name` ORDER BY `districts`.`name` ASC")
    array = district_well_count.rows.collect{|row| row[1]}
    {array: array, x_label: x_label, y_label: y_label}
  end

  def get_district_customers(district_id)
    district = BasinMetrics::District.find(district_id)
    all_customers = BasinMetrics::Customer.all.map(&:name)
    district_customers = district.customers.order(:name).uniq.map(&:name)
    district_customers_colored = all_customers.map{|c| district_customers.include?(c) ? COLOR_PRESENT : COLOR_ABSENT}
    district_customers_data = district_customers_colored.collect{1}
    district_customers_hovered = district_customers_colored.collect{|c| (c == COLOR_PRESENT) ? COLOR_PRESENT_HOVER : COLOR_ABSENT_HOVER}
    {labels: all_customers, data: district_customers_data, colors: district_customers_colored, hovers: district_customers_hovered}
  end

end
