class PinsController < ApplicationController

  def new
    @pin = Pin.new
    @boards = Board.all
  end

  def create
    pin = Pin.create(pin_params)

    respond_to do |format|
      if pin.save
        format.html { redirect_to new_pin_path(id: pin) }
      else
        format.html { }
      end
    end
  end

  def show
    @pin = Pin.find(params[:id])
  end

  def edit
    @pin = Pin.find(params[:id])
    @boards = Board.all
  end

  def update
    pin = Pin.find(params[:id])
    
    if pin.update(pin_params)
      redirect_to pin_path(pin)
    end
  end

  def destroy
    pin = Pin.find(params[:id])
    pin.destroy
    redirect_to boards_path
  end

  private
    def pin_params
      params.require(:pin).permit(:board_id, :title, :about, :image)
    end
end