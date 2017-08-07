require "rails_helper"

RSpec.describe UsersController, type: :controller do
  render_views

  describe "GET #new" do
    subject {response}
    before do
      get :new
    end
    it {is_expected.to have_http_status :success}
    it {expect(subject.body).to have_title "Signup | Ruby on Rails Tutorial Sample App"}
  end

  describe "POST #create" do
    context "invalid Signup" do
      let :count {0}
      before do
        post :create, params: {user: {name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar"}}
      end

      it {expect(User.count).to eq count}
      it {expect(response).to render_template :new}
      it {expect(response.body).to have_selector "div", id: "error_explanation"}
      it {expect(response.body).to have_selector "div", class: "field_with_errors"}
    end

    context "valid Signup" do
      let :count {0}
      before do
        post :create, params: {user: {name: "Hello",
          email: "user@valid.com",
          password: "foobar",
          password_confirmation: "foobar"}}
      end

      it {expect(User.count).not_to eq count}
      it {expect(response).to redirect_to user_path 1}
    end
  end
end
