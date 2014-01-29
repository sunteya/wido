shared_examples "require user sign_in" do
  let(:current_user) { create :user }
  before_do_action { sign_in(current_user) if current_user }
  
  context "not sign_in" do
    let(:current_user) { nil }
    it { should redirect_to(new_user_session_path) }
  end
end