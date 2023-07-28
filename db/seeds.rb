# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

if Vertical.count.zero? && Category.count.zero? && Course.count.zero?
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

