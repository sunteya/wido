require 'spec_helper'

describe Users::OmniauthCallbacksController do

  describe "POST google_oauth2" do
    let(:email) { "sunteya@gmail.com" }
    let(:access_token) { OmniAuth::AuthHash.new(info: { email: email }) }

    before do 
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = access_token
    end

    do_action { post :google_oauth2 }

    context "then new user" do
      it { should respond_with(:redirect) }
      it { expect(User.where(email: email).first).to_not be_nil }
    end

    context "then exist user" do
      let(:user) { create :user }
      let(:email) { user.email }

      it { should respond_with(:redirect) }
      it { expect(assigns[:user]).to eq(user) }
    end
  end
end
