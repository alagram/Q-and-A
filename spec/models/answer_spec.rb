require 'rails_helper'

RSpec.describe Answer, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:answer)).to be_valid
  end

  it { is_expected.to belong_to(:question) }
  it { is_expected.to belong_to(:user) }

  it { should validate_presence_of(:body) }
end
