require 'rails_helper'

RSpec.describe Question, type: :model do
  it "has a valid factory" do
    expect(FactoryBot.build(:question)).to be_valid
  end

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:answers) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
end
