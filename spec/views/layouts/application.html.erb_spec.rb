require "spec_helper"
require "rails_helper"

RSpec.describe "layouts/application.html.erb" do
  subject {rendered}
  before do
    render
  end
  it {is_expected.to have_link href: root_path, count: 2}
  it {is_expected.to have_link "Help", href: static_page_path(:help)}
  it {is_expected.to have_link "About", href: static_page_path(:about)}
  it {is_expected.to have_link "Contact", href: static_page_path(:contact)}
end
