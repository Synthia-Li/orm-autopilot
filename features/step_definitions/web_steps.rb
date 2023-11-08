require 'uri'
require 'cgi'

Given /I am on the new review page/ do
  visit new_user_orm_path(user_id: cookies[:user_id])
end

Given /I am on the homepage/ do
  visit user_orms_path(user_id: cookies[:user_id])
end

Given /I am on the review page for chat ID "(\d+)"/ do |id| 
  visit user_orm_path(user_id: cookies[:user_id], id: id)
end

Then /I should be on the homepage/ do
  expect(page).to have_current_path(user_orms_path(user_id: cookies[:user_id]))
end

Then /I should be on the new review page/ do
  expect(page).to have_current_path(new_user_orm_path(user_id: cookies[:user_id]))
end

Then /I should be on the review page for "(.*)"/ do |code_title|
  review = user.orms.find_by(title: code_title)
  expect(page).to have_current_path(user_orm_path(user_id: cookies[:user_id], id: review.id))
end

Then /I should be on the review page for chat ID "(\d+)"/ do |id|
  expect(page).to have_current_path(user_orm_path(user_id: cookies[:user_id], id: id))
end

Then('I should be on the edit review page for {string}') do |review_title|
  user = User.find_by(id: cookies[:user_id])
  review = user.orms.find_by(title: review_title)
  expect(page).to have_current_path(edit_user_orm_path(user_id: cookies[:user_id], id: review.id))
end

Then /I should be on the edit review page for chat ID "(\d+)"/ do |id|
  expect(page).to have_current_path(edit_user_orm_path(user_id: cookies[:user_id], id: id))
end

Then /I should see a div with class "(.*)"/ do |class_name|
  expect(page).to have_css("div.#{class_name}")
end

Then('I should not see the review {string}') do |review_title|
  expect(page).not_to have_content(review_title)
end

Then /I should see the "(.*)" code/ do |code|
  expect(page).to have_content(code)
end

When /I follow the "(.*)" link/ do |link|
  click_link(link)
end

When /I fill in the form with the ORM code "(.*)"/ do |code|
  fill_in 'code', with: code
end

And /I press "(.*)"/ do |button|
  click_button(button)
end

And /I should see the reviews/ do 
  step "I should see a div with class \"feedback-div\"" 
end

And /I should see the "(.*)" button/ do |button|
  expect(page).to have_button(button)
end

And /I should see "(.*)"/ do |content|
  expect(page).to have_content(content)
end
