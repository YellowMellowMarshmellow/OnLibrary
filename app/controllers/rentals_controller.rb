class RentalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:create, :update]
  before_action :set_rental, only: [:update]

  def index
    @rentals = current_user.rentals
  end

  def create
    duration_days = params[:duration_days].to_i
    [duration_days, 30].min

    @rental = @book.rentals.new(user: current_user, rental_start_date: Date.current)

    if @rental.save
      @book.update(available: false)
      redirect_to rentals_path, notice: 'Book was successfully rented.'
    else
      flash.now[:alert] = 'Unable to rent book.'
      render 'books/show', status: :unprocessable_entity
    end
  end

  def update
    if @rental.update(rental_end_date: Date.current)
      @rental.book.update(available: true)
      redirect_to rentals_path, notice: 'Rental updated successfully.'
    else
      flash.now[:alert] = 'Unable to update rental.'
      render :index, status: :unprocessable_entity
    end
  end

  def return
    @rental = Rental.find(params[:id])
    @rental.update(rental_end_date: Date.current)
    redirect_to rentals_path, notice: "Book returned successfully."
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_rental
    @rental = @book.rentals.find(params[:id])
  end
end
