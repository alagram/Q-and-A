require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  sign_in_user

  let(:question) { FactoryBot.create(:question, user: @user, body: 'test') }

  describe 'POST #create' do
    let(:attribs) do
      { body: 'Hell yeah!' }
    end

    context 'with redirects to question show page' do
      it 'creates a new answer' do
        post :create, params: { question_id: question.to_param, answer: attribs }
        expect(response).to redirect_to(question_path(question))
      end

      it 'creates a new answer' do
        expect do
          post :create, params: { question_id: question.to_param, answer: attribs }
        end.to change(Answer, :count).by(1)
      end

      it 'assigns answer to @answer' do
        post :create, params: { question_id: question.to_param, answer: attribs }
        expect(assigns(:answer)).to be_a(Answer)
        expect(assigns(:answer)).to be_persisted
      end

      it 'render "questions/show" on failure' do
        post :create, params: { question_id: question.to_param, answer: { body: nil } }
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'PUT #update' do
    sign_in_user

    let(:answer) { FactoryBot.create(:answer, body: 'test', question: question) }

    context 'with valid params' do
      let(:new_attribs) do
        { body: 'new answer' }
      end

      let(:subject) { post :update, params: { id: answer.to_param, question_id: question.to_param, answer: new_attribs } }

      before do
        subject
      end

      it 'updates the requested answer' do
        expect(answer.reload.body).to eq 'new answer'
      end

      it "assings the requested answer as @answer" do
        expect(assigns(:answer)).to eq answer
      end

      it 'redirects to the question' do
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid params' do
      it 'renders to edit template' do
        post :update, params: { id: answer.to_param, question_id: question.to_param, answer: { body: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    it 'destroys the requested answer' do
      answer = FactoryBot.create(:answer, question: question)

      expect do
        delete :destroy, params: { id: answer.to_param, question_id: question.to_param }
      end.to change(Answer, :count).by(-1)
    end
  end
end
