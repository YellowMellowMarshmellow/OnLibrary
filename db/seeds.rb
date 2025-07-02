# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Cleaning database..."
Book.destroy_all

user = User.first
raise "No user found, please create a user first!" unless user

puts "Creating books with images..."

books_data = [
  {
    title: "The Little Prince",
    author: "Antoine de Saint-Exupéry",
    categories: "Children, Fantasy",
    description: "A classic tale about a young prince's adventures.",
    user: user,
    image_file: "The_little_Prince_cover.jpg"
  },
  {
    title: "1984",
    author: "George Orwell",
    categories: "Dystopia, Science Fiction",
    description: "A novel about totalitarianism and surveillance.",
    user: user,
    image_file: "1984_Cover.jpg"
  },
  {
    title: "Harry Potter and the Sorcerer's Stone",
    author: "J.K. Rowling",
    categories: "Fantasy, Adventure",
    description: "The story of a young wizard and his friends.",
    user: user,
    image_file: "Harry_Potter_cover.jpeg"
  },
  {
    title: "The Great Gatsby",
    author: "F. Scott Fitzgerald",
    categories: "Tragedy, Classic",
    description: "A portrait of the Jazz Age and the American Dream.",
    user: user,
    image_file: "The_great_gatsby_cover.jpg"
  },
  {
    title: "The Hobbit",
    author: "J.R.R. Tolkien",
    categories: "Tragedy, Classic",
    description: "A prelude to the Lord of the Rings saga.",
    user: user,
    image_file: "The_Hobbit_cover.jpg"
  },
]

books_data.each do |book_data|
  image_file = book_data.delete(:image_file)
  book = Book.create!(book_data)

  image_path = Rails.root.join("app/assets/images/#{image_file}")
  if File.exist?(image_path)
    book.image.attach(io: File.open(image_path), filename: image_file)
    puts "✅ Attached image for #{book.title}"
  else
    puts "❌ Image not found for #{book.title} at path #{image_path}"
  end
end

puts "Seeding done!"
