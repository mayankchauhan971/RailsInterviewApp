class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @meetings = Meeting.where(name: current_user.user_name).or(Meeting.where(user: current_user))
  end
  
  def show
  end

  def new
    @meeting = Meeting.new
  end

  def edit
  end

  def create
    u = User.find_by(:user_name => params[:meeting][:user_name])
    @meeting = Meeting.create(:user_id => u.id, :start_time => params[:meeting][:start_time], :end_time => params[:meeting][:end_time], :name => params[:meeting][:name], :resume => params[:meeting][:resume])

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        UserMailer.with(:user_id => u.id).reminder_email.deliver_later(wait_until: @meeting.start_time - 30.minutes)
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        UserMailer.with(:user_id => u.id).updation_email.deliver_later(wait_until: @meeting.start_time - 30.minutes)
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    def meeting_params
      params.permit(:name, :start_time, :end_time, :user_id, :user_name, :resume)
    end
end
