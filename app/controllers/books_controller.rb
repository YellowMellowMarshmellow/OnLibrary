class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :destroy, :update]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    set_book
    @recommended_books = Book.where.not(id: @book.id).limit(10)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save!
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    @book.update(book_params)
    redirect_to book_path(@book)
  end

  def destroy
    @book.destroy
    redirect_to book_path(@books)
  end

  def search
    if params[:query].present?
      @books = Book.where("title ILIKE ? OR author ILIKE ? OR categories ILIKE ?",
                          "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @books = Book.all
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :categories, :description, :price, :image)
  end

end
