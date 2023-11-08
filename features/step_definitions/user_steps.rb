World(AuthenticationHelpers)

Given /the following users exist/ do |users_table| 
  users_table.hashes.each do |user|
    User.create!(user)
  end
end

Given /an unauthenticated user/ do
  # do nothing
end

Given /I am authenticated as "(.*)"/ do |email|
  User.login_as(email)
end

Given /I am on the login page/ do
  visit "/login/"
end

When /I try to access "(.*)"/ do |path|
  visit path
end

When /I try to access the homepage of the user "(.*)"/ do |email|
  user = User.find_by(email: email)
  visit user_orms_path(user)
end

Then /I should be (on|redirected to) the login page/ do
  expect(current_url).to match(%r{/login})
end

Then /I should be (on|redirected to) the signup page/ do
  expect(current_url).to match(%r{/signup})
end

Then /I should be (on|redirected to) the homepage of the user "(.*)"/ do |email|
  user = User.find_by(email: email)
  expect(current_url).to match(%r{/users/#{user.id}/orms})
end

Then /I should be (on|redirected to) the edit page for the user "(.*)"/ do |email|
  user = User.find_by(email: email)
  expect(current_url).to match(%r{/users/#{user.id}/edit})
end

And /I fill in the (.*) with "(.*)"/ do |tag, value|
  fill_in tag, with: value
end

And /the (.*) of the user "(.*)" should( not)? be "(.*)"/ do |attribute, email, no, value|
  user = User.find_by(email: email)
  if no
    expect(user.send(attribute)).to_not eq(value)
  else
    expect(user.send(attribute)).to eq(value)
  end
end
