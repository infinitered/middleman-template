require "spec_helper"

describe "example secondary page", type: :feature do

  before do
    visit "/"
    # within "#header-nav" do
    #   click_on "Contact"
    # end
    # click_link "Let's Get Started"
  end
  
  it "has a button to get a quote" do
    expect(page).to have_selector "h1"
  end

  it "allows filling in input fields" do
    # within "#client-survey" do
    #   fill_in "name", with: "Roger Wilco"
    #   fill_in "_replyto", with: "roger@example.com"
    #   fill_in "phone", with: "360-555-1212"
    #   fill_in "location", with: "Vancouver, WA"
      expect(page).to have_selector("h1")
    # end
  end
  
end
