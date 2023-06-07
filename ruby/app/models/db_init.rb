require 'active_record'

DB = ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => ENV['DB_NAME'],
  :host => ENV['DB_HOST'],
  :username => ENV['DB_USER'],
  :password => ENV['DB_PASS'],
)

ActiveRecord::Base.connection.create_table(:articles, primary_key: 'id', force: true) do |t|
    t.string :title
    t.string :content
    t.string :created_at
end

ActiveRecord::Base.connection.create_table(:comments, primary_key: 'id', force: true) do |t|
    t.integer :article_id
    t.text :content
    t.string :created_at
    t.string :author_name
end

require_relative 'article'

Article.create(:title => 'Title ABC', :content => 'Lorem Ipsum', :created_at => Time.now)
Article.create(:title => 'Title ZFX', :content => 'Some Blog Post', :created_at => Time.now)
Article.create(:title => 'Title YNN', :content => 'O_O_Y_O_O', :created_at => Time.now)

puts "Article count in DB: #{Article.count}"

require_relative 'comment'

Comment.create(:article_id => 1, :content => 'Very interesting', :author_name => 'Bob', :created_at => Time.now)
Comment.create(:article_id => 1, :content => 'Never read this before', :author_name => 'Dave', :created_at => Time.now)
Comment.create(:article_id => 1, :content => 'Brilliant!', :author_name => 'Lexie', :created_at => Time.now)
Comment.create(:article_id => 3, :content => 'o_O', :author_name => 'Traci', :created_at => Time.now)

