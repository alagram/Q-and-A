require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'GET #index' do

    context 'with unauthenticated user' do

      before do
        get :index
      end

      it 'redirects on unauthenticated user' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'with authenticated user' do
      sign_in_user

      it 'returns HTTP success' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

  end

  describe 'GET #new' do
    context 'with unauthenticated user' do
      before do
        get :new
      end

      it 'redirects on unauthenticated user' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'with authenticated user' do
      sign_in_user

      it 'returns HTTP success' do
        get :new
        expect(response).to have_http_status(:success)
      end

      it 'assigns a new question as @question' do
        get :new
        expect(assigns(:question)).to be_a_new(Question)
      end
    end
  end

  describe 'POST create' do
    let(:valid_attribs) do
      { title: 'hello', body: 'world' }
    end

    before do
      post :create, params: { question: FactoryBot.attributes_for(:question) }
    end
    context 'with unauthenticated user' do
      it 'redirects on unauthenticated user' do
        expect(response).to have_http_status(:redirect)
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'with authenticated user' do
      sign_in_user

      it 'redirects to root_path' do
        post :create, params: { question: FactoryBot.attributes_for(:question) }
        expect(response).to redirect_to root_path
      end

      it 'creates a new question' do
        expect do
          post :create, params: { question: valid_attribs }
        end.to change(Question, :count).by(1)
      end

      it 'assigns question to current_user' do
        post :create, params: { question: valid_attribs }
        expect(assigns(:question)).to be_a(Question)
        expect(assigns(:question)).to be_persisted
      end

      it 'render "new on failure' do
        post :create, params: { question: FactoryBot.attributes_for(:question, body: nil) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    sign_in_user

    let(:question) { FactoryBot.create(:question, user: @user, body: 'test') }

    context 'with valid params' do
      let(:new_attribs) do
        { body: 'Hell yeah!' }
      end

      it 'updates the requested question' do
        put :update, params: { id: question.to_param, question: new_attribs }
        expect(question.reload.body).to eq 'Hell yeah!'
      end

      it "assings the requested question as @question" do
        put :update, params: { id: question.to_param, question: new_attribs }
        expect(assigns(:question)).to eq question
      end

      it 'redirects to the question' do
        put :update, params: { id: question.to_param, question: new_attribs }
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid params' do
      it 'renders to edit template' do
        put :update, params: { id: question.to_param, question: { body: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    it 'destroys the requested question' do
      question = FactoryBot.create(:question)
      expect do
        delete :destroy, params: { id: question.to_param }
      end.to change(Question, :count).by(-1)
    end
  end
end
