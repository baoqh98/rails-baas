require 'rails_helper'

RSpec.describe "Api::KanbanColumns", type: :request do
  let(:headers) do
    { 'ACCEPT' => 'application/json' }
  end
  let(:auth) { create(:auth) }
  before { sign_in auth }
  let(:profile) { create(:profile, auth: auth) }
  let(:kanban) { create(:kanban, author: Profile.find(profile.id)) }
  let(:kanban_column) { create(:kanban_column, kanban: kanban) }
  let(:kanban_assignee) { create(:kanban_assignee, kanban: kanban, profile: profile) }

  let(:valid_attributes) {
    {
      name: "New Kanban column",
      kanban_id: kanban.id
    }
  }

  describe 'POST /create' do
    context 'create kanban columns in kanban show view' do
      context 'with valid parameters' do
        it 'creates a new Kanban' do
          post kanban_columns_path,
               params: { kanban_column: valid_attributes },
               headers: { 'HTTP_REFERER' => kanban_path(kanban.id) }
          expect(response).to have_http_status(:found)
        end
        it "renders errors for invalid params" do
          post kanban_columns_path, params: {}, headers: headers
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'kanban column exist' do
      it 'delete successfully' do
        delete kanban_column_path(kanban_column), headers: { 'HTTP_REFERER' => kanban_path(kanban.id) }
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'is successful' do
        patch kanban_column_path(kanban_column), headers: { 'HTTP_REFERER' => kanban_path(kanban.id) }
        expect(response).to have_http_status(:found)
      end
    end
  end
end
