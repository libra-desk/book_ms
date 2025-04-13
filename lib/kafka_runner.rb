require_relative "../config/environment"
require_relative "../app/consumers/kafka_consumer"

# listener = BookBorrowedListener.new("book_borrowed")
# listener.listen

threads = []

threads << Thread.new do
  puts "Listening to book_borrowed topic"
  KafkaConsumer.new(topic: "book_borrowed").listen
end

threads << Thread.new do
  puts "Listening to book_returned topic"
  KafkaConsumer.new(topic: "book_returned").listen
end

threads.each(&:join)
