class EventsController < ApplicationController
  before_action :authenticate_user!, :check_logged_in, :only => [:new, :create]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
      event_parmas = params.require(:event).permit(:artist, :description,
      :price_low, :price_high, :event_date, :image_src, :is_adult_only, :places_limit)
      @event = Event.new(event_parmas)
      if @event.save
      flash[:komunikat] = 'Event został poprawnie stworzony.'
      redirect_to "/events/#{@event.id}"
      else
      render 'new'
      end
    end
end

private 

def check_logged_in
  if !user_signed_in?
    authenticate_or_request_with_http_basic("Ads") do |is_admin|
      is_admin == true
    end
  end
end