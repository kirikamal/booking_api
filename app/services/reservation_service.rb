class ReservationService
  def self.parse_and_save(payload)
    reservation_data = extract_reservation_data(payload)
    guest_data = extract_guest_data(payload)

    guest = save_guest(guest_data)
    reservation = save_reservation(reservation_data, guest)

    { reservation: reservation, guest: guest }
  end

  private

  def self.extract_reservation_data(payload)
    if payload.key?(:reservation_code)
      extract_reservation_data_from_code(payload)
    else
      extract_reservation_data_from_payload(payload)
    end
  end

  def self.extract_reservation_data_from_code(payload)
    {
      reservation_code: payload[:reservation_code],
      start_date: payload[:start_date],
      end_date: payload[:end_date],
      nights: payload[:nights],
      guests: payload[:guests],
      adults: payload[:adults],
      children: payload[:children],
      infants: payload[:infants],
      status: payload[:status],
      currency: payload[:currency],
      payout_price: payload[:payout_price],
      security_price: payload[:security_price],
      total_price: payload[:total_price]
    }
  end

  def self.extract_reservation_data_from_payload(payload)
    reservation_payload = payload[:reservation]
    guest_details = reservation_payload[:guest_details]

    {
      reservation_code: reservation_payload[:code],
      start_date: reservation_payload[:start_date],
      end_date: reservation_payload[:end_date],
      nights: reservation_payload[:nights],
      guests: reservation_payload[:number_of_guests],
      adults: guest_details[:number_of_adults],
      children: guest_details[:number_of_children],
      infants: guest_details[:number_of_infants],
      status: reservation_payload[:status_type],
      currency: reservation_payload[:host_currency],
      payout_price: reservation_payload[:expected_payout_amount],
      security_price: reservation_payload[:listing_security_price_accurate],
      total_price: reservation_payload[:total_paid_amount_accurate]
    }
  end

  def self.extract_guest_data(payload)
    if payload.key?(:reservation_code)
      payload[:guest]
    else
      extract_guest_data_from_payload(payload)
    end
  end

  def self.extract_guest_data_from_payload(payload)
    reservation_payload = payload[:reservation]

    {
      first_name: reservation_payload[:guest_first_name],
      last_name: reservation_payload[:guest_last_name],
      phone: reservation_payload[:guest_phone_numbers],
      email: reservation_payload[:guest_email],
    }
  end

  def self.save_guest(guest_data)
    guest = Guest.find_or_initialize_by(email: guest_data[:email])
    guest.update(guest_data)
    guest
  end

  def self.save_reservation(reservation_data, guest)
    reservation = Reservation.find_or_initialize_by(reservation_code: reservation_data[:reservation_code])
    reservation.update(reservation_data.merge(guest: guest))
    reservation
  end
end
