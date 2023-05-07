# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  describe 'POST #create' do
    let(:payload) do
      {
        reservation_code: '123456',
        start_date: '2023-05-10',
        end_date: '2023-05-15',
        nights: 5,
        guests: 2,
        adults: 2,
        children: 0,
        infants: 0,
        status: 'confirmed',
        currency: 'USD',
        payout_price: 15000,
        security_price: 5000,
        total_price: 20000,
        guest: {
          first_name: 'John',
          last_name: 'Doe',
          phone: '1234567890',
          email: 'john.doe@example.com'
        }
      }
    end

    context 'when payload is valid' do
      it 'calls ReservationService.parse_and_save and returns JSON response with created status' do
        expect(ReservationService).to receive(:parse_and_save).with(payload).and_return({ reservation: build(:reservation), guest: build(:guest) })

        post :create, body: payload.to_json

        expect(response).to have_http_status(:created)
      end
    end

    context 'when payload is invalid' do
      it 'returns JSON response with unprocessable_entity status' do
        allow(ReservationService).to receive(:parse_and_save).and_raise(StandardError.new('Invalid payload'))

        post :create, body: payload.to_json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body, symbolize_names: true)).to eq({ error: 'Invalid payload' })
      end
    end
  end
end
