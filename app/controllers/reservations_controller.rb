class ReservationsController < ApplicationController
  def create
    payload = JSON.parse(request.body.read, symbolize_names: true)
    result = ReservationService.parse_and_save(payload)

    render json: result, status: :created
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
