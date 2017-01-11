# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Add companies
BasinMetrics::Company.create_with(name:'test_company').find_or_create_by!(name:'test_company')

# Add users
first_names = %w(example jim bob tom sally)
last_names = %w(example_last_name smith johnson reynolds shears)
raise "First names must all have last names!" unless (first_names.size == last_names.size)

first_names.each_with_index do |first_name, index|
  user_role = (index == 0) ? 'admin' : 'guest'
  User.create_with(
    first_name: first_name,
    last_name: last_names[index],
    email: "#{first_name}@example.com",
    password: 'password',
    role: user_role,
    company_id: BasinMetrics::Company.all.first.id
  ).find_or_create_by!(email: "#{first_name}@example.com")
end

# Add customers
customer_names = %w(slawson oxy spotted_hawk oasis wpx whiting qep stat_oil)
customer_names.each do |n|
  BasinMetrics::Customer.create_with(
    name: n,
    company_id: BasinMetrics::Company.all.first.id
  ).find_or_create_by!(name: "#{n}")
end

# Add districts
district_names = %w(williston rock_springs vernal farmington longmont casper powell riverton)
district_names.each do |name|
  BasinMetrics::District.create_with(
    name: name,
    company_id: BasinMetrics::Company.all.first.id
  ).find_or_create_by!(name: "#{name}")
end

# Add wells
well_names = %w(iron_bank golden saetz_fed nordeng ames cheryl stenjhem still_water ninefold federal breck)
100.times do
  actual_date = (DateTime.now - (rand(10..340).days))
  complete_date = actual_date + 5.days
  BasinMetrics::Well.create!(
    name: well_names[rand(0..9)],
    number: "#{rand(10..90)}-#{rand(345..789)}-#{rand(100..200)}",
    customer_id: rand(1..customer_names.size),
    district_id: rand(1..district_names.size),
    actual_start: actual_date,
    completed: complete_date,
    revenue: rand(1000..3000)
  )
end

# Add parts
part_numbers = %w(1234 5678 9876 6543 8076 2837 8374 9374 6996 3636 9797 4545)
part_types = %w(8k_trufrak 10k_trufrac 12k_fracshield)
part_revenue = %w(500 1000 1500)
part_numbers.each do |number|
  BasinMetrics::Part.create_with(
    name: 'plug',
    type: part_types[rand(0..2)],
    number: part_numbers[rand(0..2)],
    size: '4.5',
    quantity: rand(2..70),
    order: SecureRandom.hex(6),
    revenue: part_revenue[rand(0..2)],
    date_sold: (DateTime.now + (rand(1..340).days)),
    district_id: rand(1..district_names.size)
  ).find_or_create_by!(number: "#{number}")
end