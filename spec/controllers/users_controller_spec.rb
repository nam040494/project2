require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    render_views
    subject {response}
    before do
      get :new
    end
    it {is_expected.to have_http_status :success}
    it {expect(subject.body).to have_title "Signup | Ruby on Rails Tutorial Sample App"}
  end
end
