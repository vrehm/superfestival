class EventsController < ApplicationController
  before_action :set_event, only: [:destroy]

  def new
    @event = Event.new
  end

  def create
    @concert = Concert.find(params[:concert_id])
    @event = Event.new(concert: @concert)
    @event.timetable = current_user.find_or_create_timetable_for!(@event.concert.festival, params[:day])
    authorize @event
    validation = []
    @event.timetable.events.each do |event|
      if (event.concert.start_time < @event.concert.end_time && event.concert.end_time > @event.concert.start_time)
      # if ((event.concert.start_time <= @event.concert.start_time && @event.concert.start_time <= event.concert.end_time) || (event.concert.start_time <= @event.concert.end_time && @event.concert.end_time <= event.concert.end_time)) || (@event.concert.start_time <= event.concert.start_time && event.concert.start_time <= @event.concert.end_time)
        validation << false
      else
        validation << true
      end

    end
    if validation.include?(false)
      redirect_to festival_path(@event.concert.festival, date: params[:date], day: params[:day])
    else
      @event.save
      redirect_to festival_path(@event.concert.festival, date: params[:date], day: params[:day])
    end
  end

  def show
    raise
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:timetable_id, :concert_id)
  end
end
