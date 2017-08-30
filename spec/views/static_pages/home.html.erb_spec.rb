require "spec_helper"
require "rails_helper"

RSpec.describe "static_pages/home.html.erb" do
  subject {rendered}
  before do
    render
  end
    
  it{is_expected.to have_selector "h1", text: "Sample App"}
  it{is_expected.to have_link "Ruby on Rails Tutorial", href: "http://www.railstutorial.org/"}
end
