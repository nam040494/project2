require "spec_helper"
require "rails_helper"

RSpec.describe "static_pages/help.html.erb" do
  subject {rendered}
  before do
    render
  end
    
  it{is_expected.to have_selector "h1", text: "Help"}
  it{is_expected.to have_link "Rails Tutorial help section", href: "http://www.railstutorial.org/help"}
end
