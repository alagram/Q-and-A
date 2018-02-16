require 'rails_helper'

RSpec.describe User, type: :model do
  describe "from_omniauth" do
    let(:auth) do
      {
        provider: 'google_oauth2',
        uid: '12345',
        info: {
          email: 'test@example.com',
          first_name: 'Alice',
          last_name: 'Smith'
          },
        credentials: {
          token: '98765',
          refresh_token: '12345abcde',
          expires_at: DateTime.now
        }
      }
    end

    let(:subject) { User.from_omniauth(auth) }

    context 'with persisted user' do
      let!(:user) { FactoryBot.create(:user, uid: '12345') }

      it 'does not create a user with same uid' do
        expect { subject }.to_not change(User, :count)
      end

      it_behaves_like "create_or_update_user_attribs" do
        let(:object) { User.first }
      end
    end

    context 'without persisted user' do

      it 'creates a new user' do
        expect { subject }.to change(User, :count).from(0).to(1)
      end

      it_behaves_like "create_or_update_user_attribs" do
        let(:object) { User.first }
      end
    end
  end
end
