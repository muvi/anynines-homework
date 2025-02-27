class ArticleController
  def create_article(article)
    article_not_exists = Article.where(:title => article['title']).empty?
    
    return { ok: false, msg: 'Article with given title already exists' } unless article_not_exists

    new_article = Article.new(:title => article['title'], :content => article['content'], :created_at => Time.now)
    new_article.save

    { ok: true, obj: article }
  rescue StandardError
    { ok: false }
  end

  def update_article(id, new_data)

    article = Article.where(:id => id).first

    return { ok: false, msg: 'Article could not be found' } unless !article.nil?

    article.title = new_data['title']
    article.content = new_data['content']
    article.save

    { ok: true, obj: article }
  rescue StandardError
    puts e.message
    { ok: false }
  end

  def get_article(id)
    res = Article.where(:id => id)

    if res.empty?
      { ok: false, msg: 'Article not found' }
    else
      comments = Comment.where(:article_id => id)
      { ok: true, data: res.first, comments: comments }
    end
  rescue StandardError
    { ok: false }
  end
  
  def create_comment(id, comment)
    res = Article.where(:id => id)

    if res.empty?
      { ok: false, msg: 'Article not found' }
    else
      new_comment = Comment.new(:article_id => id, :content => comment['content'], :author_name => comment['author_name'], :created_at => Time.now)
      new_comment.save
      { ok: true, msg: 'Article commented' }
    end
  rescue StandardError => e
    { ok: false, msg: e.message }
  end

  def delete_article(id)
    Comment.delete_by(article_id: id)
    delete_count = Article.delete(id)

    if delete_count == 0
      { ok: false }
    else
      { ok: true, delete_count: delete_count }
    end
  end

  def get_batch
    res = Article.all()

    if res.empty?
      { ok: false, msg: 'Could not get articles.' }
    else
      { ok: true, data: res }
    end
  rescue StandardError
    { ok: false }
  end
end
