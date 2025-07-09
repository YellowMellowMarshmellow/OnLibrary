class ReviewsController < ApplicationController
  before_action :set_book

  def create
    # Find the rental this review is tied to
    rental = Rental.find_by(user: current_user, book: @book)

    # Find an existing review for this user + rental, or create a new one
    @review = @book.reviews.find_or_initialize_by(user: current_user, rental: rental)

    # Assign the new form input values (rating and content)
    @review.assign_attributes(review_params)

    if @review.save
      redirect_to @book, notice: 'Your review has been submitted.'
    else
      redirect_to @book, alert: 'Review could not be saved.'
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
