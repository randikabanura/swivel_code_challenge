# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

if Vertical.count.zero?
  verticals = JSON.parse(File.read(Rails.root.join('db/data/json/verticals.json')))
  verticals.each do |vertical|
    Vertical.create(
      id: vertical['Id'],
      name: vertical['Name']
    )
  end
end

if Category.count.zero?
  categories = JSON.parse(File.read(Rails.root.join('db/data/json/categories.json')))
  categories.each do |category|
    Category.create(
      id: category['Id'],
      name: category['Name'],
      state: category['State'] == 'active' ? 1 : 0,
      vertical: Vertical.find(category['Verticals'])
    )
  end
end

if Course.count.zero?
  courses = JSON.parse(File.read(Rails.root.join('db/data/json/courses.json')))
  courses.each do |course|
    Course.create(
      id: course['Id'],
      name: course['Name'],
      author: course['Author'],
      state: course['State'] == 'active' ? 1 : 0,
      category: Category.find(course['Categories'])
    )
  end
end

