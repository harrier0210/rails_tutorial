require 'rails_helper'

RSpec.feature "StaticPages", type: :system do

  before do
    visit root_path
  end

  scenario "Home画面へ遷移できるか" do
    click_link "sample app"
    expect(page).to have_content("This is the home page")
  end

  scenario "Home画面へ遷移できるか" do
    click_link "Home"
    expect(page).to have_content("This is the home page")
  end

  scenario "Help画面へ遷移できるか" do
    click_link "Help"
    expect(page).to have_content("Get help on the Ruby on Rails Tutorial")
  end

  scenario "About画面へ遷移できるか" do
    click_link "About"
    expect(page).to have_content("Ruby on Rails Tutorial is a book")
  end

  scenario "Contact画面へ遷移できるか" do
    click_link "Contact"
    expect(page).to have_content("Contact the Ruby on Rails Tutorial")
  end

  scenario "Sign up画面へ遷移できるか" do
    click_link "Sign up now!"
    expect(page).to have_content("This will be a signup page for new users.")
  end
end
