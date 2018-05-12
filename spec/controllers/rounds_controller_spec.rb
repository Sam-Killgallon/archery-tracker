require 'rails_helper'

RSpec.describe RoundsController do
  describe '#index' do
    context 'as html' do
      it 'renders the index page' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context 'as json' do
      it 'returns all rounds as json' do
        rounds = 0.upto(3).map { Round.create! }

        get :index, format: :json
        expect(response.body).to eql(rounds.to_json)
      end
    end
  end
end
