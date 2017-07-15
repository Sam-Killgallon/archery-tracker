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
        rounds = double(:rounds)
        expect(Round).to receive(:all).and_return(rounds)

        get :index, format: :json
        expect(response.body).to eql(rounds.to_json)
      end
    end
  end
end
