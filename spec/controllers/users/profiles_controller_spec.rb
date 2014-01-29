require 'spec_helper'

describe Users::ProfilesController do
  describe "GET edit" do
    do_action { get :edit }

    it_behaves_like "require user sign_in" do
      it { should respond_with(:success) }
    end
  end

  describe "PUT update" do
    let(:attributes) { Hash.new }
    do_action { put :update, { user: attributes } }

    it_behaves_like "require user sign_in" do
      let(:user) { current_user }

      context "valid attributes" do
        let(:attributes) { { slug: "sunteya" } }
        it { should respond_with(:redirect) }
      end

      context "invalid attributes" do
        let(:attributes) { { slug: "" } }
        it { should respond_with(:success) }
      end
    end
  end
end
