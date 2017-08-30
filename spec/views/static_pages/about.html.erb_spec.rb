require "spec_helper"
require "rails_helper"

RSpec.describe "static_pages/about.html.erb" do
  subject {rendered}
  before do
    render
  end
    
  it{is_expected.to have_selector "h1", text: "About"}
  it{is_expected.to have_link "book", href: "http://www.railstutorial.org/book"}
end
