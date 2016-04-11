module Api
  class EventsController < ApplicationController
    def create
      if Event.create(event_params)
        render json: { message: 'Event saved' }
      else
        render json: { message: 'Event not saved' }
      end
    end

    def index
      events = Event.all_between(params[:start], params[:end])
      render json: events
    end

    def event_params
      params.require(:event).permit(:start_date, :end_date, :description)
    end
  end
end
