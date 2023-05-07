# frozen_string_literal: true

require 'rails_helper'

describe ReservationService do
  describe '#parse_and_save' do
    let(:payload) do
      {
        reservation_code: 'YYY12345678',
        start_date: '2023-05-10',
        end_date: '2023-05-15',
        nights: 5,
        guests: 2,
        adults: 2,
        children: 0,
        infants: 0,
        status: 'accepted",',
        currency: 'AUD',
        payout_price: 1500,
        security_price: 000,
        total_price: 2000,
        guest: {
          first_name: 'Wayne',
          last_name: 'Woodbridge',
          phone: '1234567890',
          email: 'wayne_woodbridge@bnb.com'
        }
      }
    end

    context 'when payload contains reservation code' do
      it 'saves the guest and reservation' do
        expect(Guest).to receive(:find_or_initialize_by).with(email: payload[:guest][:email]).and_return(build(:guest))
        expect(Reservation).to receive(:find_or_initialize_by).with(reservation_code: payload[:reservation_code]).and_return(build(:reservation))

        result = ReservationService.parse_and_save(payload)

        expect(result[:guest]).to be_a(Guest)
        expect(result[:reservation]).to be_a(Reservation)
        expect(result[:reservation][:reservation_code]).to eq('YYY12345678')
      end
    end

    context 'when payload contains reservation details' do
      let(:reservation_payload) do
        {
          code: 'XXX12345678',
          start_date: '2023-05-20',
          end_date: '2023-05-25',
          nights: 5,
          number_of_guests: 3,
          guest_details: {
            number_of_adults: 2,
            number_of_children: 1,
            number_of_infants: 0
          },
          guest_email: 'wayne_woodbridge@bnb.com',
          guest_first_name: 'Wayne',
          guest_last_name: 'Woodbridge',
          guest_phone_numbers: ['639123456789', '639123456789'],
          status_type: 'accepted',
          host_currency: 'AUD',
          expected_payout_amount: 10000,
          listing_security_price_accurate: 5000,
          total_paid_amount_accurate: 15000
        }
      end

      let(:payload) { { reservation: reservation_payload } }

      it 'saves the guest and reservation' do
        expect(Guest).to receive(:find_or_initialize_by).with(email: reservation_payload[:guest_email]).and_return(build(:guest))
        expect(Reservation).to receive(:find_or_initialize_by).with(reservation_code: reservation_payload[:code]).and_return(build(:reservation))

        result = ReservationService.parse_and_save(payload)

        expect(result[:guest]).to be_a(Guest)
        expect(result[:reservation]).to be_a(Reservation)
        expect(result[:reservation][:guests]).to eq(3)
      end
    end
  end
end
