class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @meetings = Meeting.all
  end

  def show
    puts("---------------------------------------------------------------------")
    puts(meeting_params[:start_time])
    puts(meeting_params[:name])
    u = User.find_by(:user_name => meeting_params[:user_name])
    @meeting = Meeting.find_by(:user_id => u.id)
  end

  def new
    @meeting = Meeting.new
  end

  def edit
  end

  def create
    @meeting = Meeting.new
    u = User.find_by(:user_name => meeting_params[:user_name])
    puts("------------------------------------")
    puts(params)
    puts(params[:meeting][:user_name])
    puts(meeting_params[:user_name])
    puts(meeting_params[:start_time])
    puts(meeting_params[:end_time])
    puts(meeting_params[:name])
    puts("######################################")
    @meeting = Meeting.create(:user_id => u.id, :start_time => meeting_params[:start_time], :end_time => meeting_params[:end_time], :name => meeting_params[:name])
    

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
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
      params.require(:meeting).permit(:name, :start_time, :end_time, :user_id, :user_name)
    end
end
