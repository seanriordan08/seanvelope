# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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
    role: user_role
  ).find_or_create_by!(email: "#{first_name}@example.com")
end

# Add customers
customer_names = %w(slawson oxy spotted_hawk oasis wpx whiting qep stat_oil)
customer_names.each do |n|
  BasinMetrics::Customer.create_with(
    name: n
  ).find_or_create_by!(name: "#{n}")
end

# Add districts
customer_names = %w(williston rock_springs vernal farmington longmont casper powell riverton)
customer_names.each do |n|
  BasinMetrics::District.create_with(
    name: n
  ).find_or_create_by!(name: "#{n}")
end