require 'spec_helper'

describe ArticlesController do
  describe "GET show" do
    let(:user) { create :user }
    let(:article) { create :article, user: user }
    do_action { get :show, { author: user.slug } }
  end
end
