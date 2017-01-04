module DistrictHelper

  def get_district_well_counts
    x_label = 'District'
    y_label = 'Well Count'
    district_well_count = BasinMetrics::District.connection.select_all("SELECT districts.name, COUNT(wells.name) as well_name FROM `districts` LEFT JOIN `wells` ON `wells`.`district_id` = `districts`.`id` GROUP BY `districts`.`name` ORDER BY `districts`.`name` ASC")
    array = district_well_count.rows.collect{|row| row[1]}
    {array: array, x_label: x_label, y_label: y_label}
  end

end
