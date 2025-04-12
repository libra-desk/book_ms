require 'kafka'

class BookBorrowedListener
  def initialize
    @kafka = Kafka.new(["127.0.0.1:9092"], client_id: "book-ms")
    @topic = "book_borrowed"
    @group_id = "book-ms-consumer"
  end

  def listen
    consumer = @kafka.consumer(group_id: @group_id)
    consumer.subscribe(@topic)

    puts "Listening to #{@topic} topic..."
    
    consumer.each_message do |message|
      puts "Received the message #{message.value}"
      handle_message(JSON.parse(message.value))
    end
  rescue => e
    puts "There seems to be an error: #{e}"
    retry
  end


  private

  def handle_message(payload)
    book_id = payload['book_id']
    book = Book.find_by(id: book_id)

    if book
      book.update(available: false)
      puts "Book has been borrowed"
    else
      puts "Book not found mister"
    end
  end
end
