class BookingsController < ApplicationController
  include BookingsHelper

  def new
    @booking = Booking.new
    @selected_flight = Flight.find(params[:flight])
    @passengers_count = params[:pax].to_i
    @passengers_count.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      flash[:notice] = 'Booking successfully completed!'
      if Rails.env.development?
        @booking.passengers.each do |passenger|
          PassengerMailer.confirmation_email(passenger).deliver_now
        end
      end
      redirect_to booking_path(@booking)
    else
      flash[:alert] = 'An error occured!'
      render "new"
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end
end