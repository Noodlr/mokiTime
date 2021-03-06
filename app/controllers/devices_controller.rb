class DevicesController < ApplicationController
  
  def index
    @filterrific = initialize_filterrific(
      Device,
      params[:filterrific],
    ) or return
  
    @devices = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @device = Device.find(params[:id])
    @comment = @device.comments.order("created_at").last
  end

  def edit
    @device = Device.find(params[:id])
  end

  def create
    @location = Location.find(params[:location_id])
    @device = @location.devices.create(device_params)
    redirect_to location_path(@location)
  end

  def destroy
    @device = Device.find(params[:id])
    @device.destroy
  end

  private
    def device_params
      params.require(:device).permit(:name, :software_id, :d_id, :registration_code)
    end
end
