def login_user
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, :scope => :user)
  end
end

def sign_in_user
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryBot.create(:user)
    sign_in @user
  end
end
