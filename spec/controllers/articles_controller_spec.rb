require 'spec_helper'

describe ArticlesController do
  describe "GET show" do
    let(:user) { create :user }
    let(:article) { create :article, :published, user: user }
    action { get :show, { author: user.slug, article: article.slug } }
    it { should respond_with(:success) }
  end
end
