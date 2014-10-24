require "spec_helper"

describe "home page", type: :feature do

  before do
    visit "/"
  end

  it "has the correct title" do
    expect(page).to have_content(/ClearSight/i)
  end

  it "has other content" do
    expect(page).to have_selector "h1"
  end

end
