class Book < ApplicationRecord
  has_one_attached :pdf_file
  # validates_presence_of :title,
  #                       :description,
  #                       :pages,
  #                       :isbn,
  #                       :pdf_file
end
