# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# If running seed file after the first default data creation please comment the following lines
# where we remove any records on 'verticals', 'categories' and 'courses' tables.
Vertical.destroy_all
Category.destroy_all
Course.destroy_all


if Vertical.count.zero? && Category.count.zero? && Course.count.zero?
  ActiveRecord::Base.connection.reset_pk_sequence!('verticals')
  ActiveRecord::Base.connection.reset_pk_sequence!('categories')
  ActiveRecord::Base.connection.reset_pk_sequence!('courses')

  verticals = JSON.parse(File.read(Rails.root.join('db/data/json/verticals.json')))
  verticals.each do |vertical|
    Vertical.create(
      name: vertical['Name']
    )
  end
  puts "Default verticals created: verticals count: #{Vertical.count}"

  categories = JSON.parse(File.read(Rails.root.join('db/data/json/categories.json')))
  categories.each do |category|
    Category.create(
      name: category['Name'],
      state: category['State'] == 'active' ? 0 : 1,
      vertical: Vertical.find(category['Verticals'])
    )
  end
  puts "Default categories created: categories count: #{Category.count}"

  courses = JSON.parse(File.read(Rails.root.join('db/data/json/courses.json')))
  courses.each do |course|
    Course.create(
      name: course['Name'],
      author: course['Author'],
      state: course['State'] == 'active' ? 0 : 1,
      category: Category.find(course['Categories'])
    )
  end
  puts "Default courses created: courses count: #{Course.count}"
end

unless ENV['OPEN_SEARCH'].present?
  # Rake tasks needed to setup the default data
  Rake::Task['searchkick:reindex:all'].invoke
end

