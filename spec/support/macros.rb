def login_user
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, :scope => :user)
  end
end
