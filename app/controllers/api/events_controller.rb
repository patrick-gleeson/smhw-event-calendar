module Api
  class EventsController < ApplicationController
    def create
      event = Event.new(event_params)
      if event.save
        render json: { message: 'Event saved' }
      else
        render json: { message: event.all_errors },
               status: :unprocessable_entity
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
