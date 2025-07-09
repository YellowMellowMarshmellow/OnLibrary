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
Rental.destroy_all
Book.destroy_all

user = User.first
raise "No user found, please create a user first!" unless user

puts "Creating books with images..."

def random_price
  (50..200).step(5).to_a.sample / 100.00
end

books_data = [
  {
    title: "The Little Prince",
    author: "Antoine de Saint-Exupéry",
    categories: "Children, Fantasy",
    description: "A classic tale about a young prince's adventures.",
    user: user,
    image_file: "The_little_Prince_cover.jpg",
    price: random_price
  },
  {
    title: "1984",
    author: "George Orwell",
    categories: "Dystopia, Science Fiction",
    description: "A novel about totalitarianism and surveillance.",
    user: user,
    image_file: "1984_Cover.jpg",
    price: random_price
  },
  {
    title: "Harry Potter and the Sorcerer's Stone",
    author: "J.K. Rowling",
    categories: "Fantasy, Adventure",
    description: "The story of a young wizard and his friends.",
    user: user,
    image_file: "Harry_Potter_cover.jpeg",
    price: random_price
  },
  {
    title: "The Great Gatsby",
    author: "F. Scott Fitzgerald",
    categories: "Tragedy, Classic",
    description: "A portrait of the Jazz Age and the American Dream.",
    user: user,
    image_file: "The_great_gatsby_cover.jpg",
    price: random_price
  },
  {
    title: "The Hobbit",
    author: "J.R.R. Tolkien",
    categories: "Tragedy, Classic",
    description: "A prelude to the Lord of the Rings saga.",
    user: user,
    image_file: "The_Hobbit_cover.jpg",
    price: random_price
  },
  {
    title: "The Lord of the Rings",
    author: "J.R.R. Tolkien",
    categories: "Fantasy, Adventure",
    description: "An epic quest to destroy the One Ring and save Middle-earth.",
    user: user,
    image_file: "The_Lord_of_the_Rings_cover.jpg",
    price: random_price
  },
  {
    title: "The Wave",
    author: "Todd Strasser",
    categories: "Young Adult, Drama",
    description: "A high school experiment to demonstrate the rise of fascism spirals out of control.",
    user: user,
    image_file: "The_Wave_cover.jpeg",
    price: random_price
  },
  {
    title: "The BFG",
    author: "Roald Dahl",
    categories: "Children's Literature, Fantasy",
    description: "A young girl befriends a Big Friendly Giant who protects her from man-eating giants.",
    user: user,
    image_file: "The_BFG_cover.jpg",
    price: random_price
  },
  {
    title: "Les Furtifs",
    author: "Alain Damasio",
    categories: "Science Fiction, Speculative Fiction",
    description: "A thrilling story exploring invisible beings living alongside humans and challenging society’s norms.",
    user: user,
    image_file: "Les_Furtifs_cover.jpg",
    price: random_price
  },
  {
    title: "Marlavant",
    author: "A.D Quilliec",
    categories: "Science Fiction, Adventure",
    description: "Marlavant is a gripping tale of a forgotten hero facing shadows from the past to save a dying world.",
    user: user,
    image_file: "Marlavant_cover.jpg",
    price: random_price
  },
  {
  title: "Arsène Lupin, Gentleman Burglar",
  author: "Maurice Leblanc",
  categories: "Mystery, Crime, Classic",
  description: "Adventures of the clever and charming master thief Arsène Lupin.",
  user: user,
  image_file: "Arsene_Lupin_cover.jpg",
  price: random_price
}
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
