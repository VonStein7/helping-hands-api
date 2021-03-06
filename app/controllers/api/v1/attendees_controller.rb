class Api::V1::AttendeesController < ApplicationController


  def create
    @attendee = Attendee.new(attendee_params)
    @user = User.find_by(id: attendee_params[:user_id])

    if session_user
      attending_arr = @user.events.find do |e| e.id == @attendee.event_id end
      # byebug
      if attending_arr != nil
        return render json: {errors: "User already attends this event."}
      end

      if @attendee.save
        @organization = @attendee.event.organization
        render json: @organization
      else
        render json: {errors: @attendee.errors.full_messages}
      end
    end
  end

  def update
    @attendee = find_attendee

    @attendee.update(attendee_params)
    if @attendee.save
      render json: @attendee, status: :accepted
    else
      render json: { errors: @attendee.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    Attendee.destroy(params[:id])
		render json: { success: "You successefully removed your organization's events attendee."}
	end

  private 

  def attendee_params
    params.require(:attendee).permit(:event_id,:user_id)
  end
 
  def find_attendee
    @attendee = Attendee.find(params[:id])
  end
end
