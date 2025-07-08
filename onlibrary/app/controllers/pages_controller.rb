class PagesController < ApplicationController
  def home
    @books = Book.limit(6)
  end
end
