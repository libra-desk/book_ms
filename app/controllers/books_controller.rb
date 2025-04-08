class BooksController < ApplicationController

  def index
    books = Book.all
    render json: books
  end

  def show
    book = Book.find(params[:id])

    render json: book
  end

  def create
    book = Book.new(book_params)

    if book.save
      render json: book, status: :created
    else
      render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    book = Book.find(params[:id])

    if book.update(book_params)
      render json: book
    else
      render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def destroy
    # find method raises an exception. Use find_by which returns nil
    # if you use find method, then if the book is not there, that error json wont be shown. 
    # Instead it will raise an ActiveRecord::RecordNotFound exception. Either you use find_by method
    # or put it inside a rescue block instead of the if else block.
    book = Book.find(id: params[:id]) 

    book.destroy
    head :no_content # This is used to send back a success response with no response body
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Book not found!" }, status: :not_found
  end

  private

  def book_params
    params.permit(:title, 
                  :description,
                  :pdf_file,
                  :pages,
                  :isbn
                 )
  end
end
