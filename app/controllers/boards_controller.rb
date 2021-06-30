class BoardsController < ApplicationController
  def index
    @board = Board.new
    @boards = Board.all
    @pin = Pin.new
    @pins = Pin.all
  end

  def new
    @board = Board.new
  end

  def create
    board = Board.create(board_params)

    respond_to do |format|
      if board.save
        # cause turbo tag form in new page so go back the page to get the frame
        format.html { redirect_to new_board_path(id: board) }
      else
        # format.turbo_stream { render turbo_stream: turbo_stream.replace(board, partial: 'boards/form', locals: { board: board }) }
        format.html { }
      end
    end

    # if board.save
    #   redirect_to boards_path(id: board)
    # end
  end

  def show
    @board = Board.find(params[:id])
    @boards = Board.all
    @pin = Pin.new
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    board = Board.find(params[:id])
    
    if board.update(board_params)
      redirect_to board_path(board)
    end
  end

  def destroy
    board = Board.find(params[:id])
    board.destroy
    redirect_to boards_path
  end

  private
    def board_params
      params.require(:board).permit(:name)
    end
end