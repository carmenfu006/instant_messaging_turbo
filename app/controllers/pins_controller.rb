class PinsController < ApplicationController

  def new
    @pin = Pin.new
    @boards = Board.all
  end

  def create
    pin = Pin.create(pin_params)

    respond_to do |format|
      if pin.save
        format.html { redirect_to new_pin_path }
      else
        format.html { }
      end
    end
  end

  private
    def pin_params
      params.require(:pin).permit(:board_id, :title, :about, :image)
    end
end