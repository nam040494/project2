require "rails_helper"

RSpec.describe MicropostsController, type: :controller do
  let :user {FactoryGirl.create :user}
  let :count {user.microposts.count}

  describe "POST #create" do
    before do
      post :create, params: {micropost: {content: "Lorem ipsum"}}
    end
    context "not logged in" do
      it {expect(user.microposts.reload.count).to eq count}
      it {expect(response).to redirect_to login_url}
    end
  end

  describe "DELETE #destroy" do
    before do
      user.microposts.create content: "ldkjfl"
      delete :destroy, params: {id: user.microposts.first.id}
    end

    context "not logged in" do
      it {expect(user.microposts.reload.count).to eq count}
      it {expect(response).to redirect_to login_url}
    end

    context "wrong micropost" do
      let :other {FactoryGirl.create :user, name: "other",
        email: "other@gmail.com", password: "foobar", password_confirmation: "foobar"}

      before do
        other.microposts.create content: "kjdfk"
        allow(controller).to receive(:current_user) {user}
        delete :destroy, params: {id: other.microposts.first.id}
      end

      it {expect(response).to redirect_to root_url}
    end
  end
end
