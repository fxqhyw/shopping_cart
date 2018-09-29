class BooksController < ApplicationController
  def index
    @products = Book.all
  end
end
