require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    context "not logged in" do
      before do
        get :index
      end

      it {expect(response).to redirect_to login_url}
    end

    context "logged in" do
      before do
        allow(controller).to receive(:logged_in?) {true}
        get :index
      end

      it {expect(response).to render_template "users/index"}
    end
  end

  describe "GET #new" do
    render_views
    subject {response}
    before do
      get :new
    end
    it {is_expected.to have_http_status :success}
    it {expect(subject.body).to have_title "Signup | Ruby on Rails Tutorial Sample App"}
  end

  describe "POST #create" do
    render_views

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
    end
  end

  describe "GET #edit" do
    let :user {FactoryGirl.create :user}
    subject {response}
    before do
      allow(controller).to receive(:logged_in?) {true}
      allow(controller).to receive(:current_user) {user}
      get :edit, params: {id: user.id}
    end

    it {is_expected.to render_template :edit}
  end

  describe "POST #update" do
    let :user {FactoryGirl.create :user}
    let :another {FactoryGirl.create :user, name: "another",
      email: "another@gmail.com",password: "foobar",
      password_confirmation: "foobar"}

    context "not logged in" do
      subject {response}
      before do
        patch :update, params: {id: user.id, user: {name: "foo bar",
          email: "foo@bar.com", password: "", password_confirmation: ""}}
      end

      it {is_expected.to redirect_to login_url}
    end

    context "logged in" do
      subject {response}
      before do
        allow(controller).to receive(:logged_in?) {true}
        allow(controller).to receive(:current_user) {user}
        patch :update, params: {id: user.id, user: {name: "foo bar",
          email: "foo@bar.com", password: "", password_confirmation: ""}}
      end

      it do
        is_expected.to redirect_to user

        user.reload
        expect(user.name).to eq "foo bar"
        expect(user.email).to eq "foo@bar.com"
      end
    end

    context "another user" do
      subject {response}
      before do
        allow(controller).to receive(:logged_in?) {true}
        allow(controller).to receive(:current_user) {user}
        patch :update, params: {id: another.id, user: {name: "foo bar",
          email: "foo@bar.com", password: "", password_confirmation: ""}}
      end

      it {is_expected.to redirect_to root_url}
    end
  end

  describe "DELETE #destroy" do
    let :user {FactoryGirl.create :user, admin: true}
    let :other {FactoryGirl.create :user, name: "other",
      email: "other@gmail.com", password: "foobar",
      password_confirmation: "foobar"}

    context "when not logged in" do
      before do
        delete :destroy, params: {id: other.id}
      end

      it {expect(response).to redirect_to login_url}
    end

    context "logged in as a non-admin" do
      before do
        allow(controller).to receive(:current_user) {other}
        delete :destroy, params: {id: user}
      end

      it {expect(response).to redirect_to root_url}
    end
  end
end
