require "spec_helper"
require "rails_helper"

RSpec.describe "static_pages/contact.html.erb" do
  subject {rendered}
  before do
    render
  end
    
  it{is_expected.to have_selector "h1", text: "Contact"}
  it{is_expected.to have_link "contact page", href: "http://www.railstutorial.org/contact"}
end
