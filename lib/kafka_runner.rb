require_relative "../config/environment"
require_relative "../app/consumers/book_borrowed_listener"

listener = BookBorrowedListener.new
listener.listen
