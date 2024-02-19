class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[ show edit update destroy ]
  private

  def publish_message(message)
    pubsub = Google::Cloud::Pubsub.new
    topic = pubsub.topic('projects/tanfaiz-cwx-internal/topics/rails-test') # Replace with your actual topic name
    topic.publish(message)
  end

  # GET /profiles or /profiles.json
  def index
    @profiles = Profile.all
    publish_message('Hello from Pub/Sub profile app!')
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end
  # POST /profiles or /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully created." }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /profiles/1 or /profiles/1.json
  def show
  end

  # GET /profiles/1/edit
  def edit
    redirect_to root_path
  end

  # PATCH/PUT /profiles/1 or /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to profile_url(@profile), notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1 or /profiles/1.json
  def destroy

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:profile).permit(:name, :youtube, :twitter, :other)
    end
end
