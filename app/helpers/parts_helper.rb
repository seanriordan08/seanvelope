module PartsHelper

  def get_well(id)
    BasinMetrics::Well.find(id)
  end

  def get_parts_options
    well_ids = BasinMetrics::Well.all.map(&:id)
    well_numbers = BasinMetrics::Well.all.map(&:number)
    wells_build_options(well_ids, well_numbers)
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
