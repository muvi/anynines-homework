require_relative '../controllers/articles'

class ArticleRoutes < Sinatra::Base
  use AuthMiddleware

  def initialize
    super
    @articleCtrl = ArticleController.new
  end

  before do
    content_type :json
  end

  get('/') do
    summary = @articleCtrl.get_batch

    if summary[:ok]
      { articles: summary[:data] }.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end

  get('/:id') do
    summary = @articleCtrl.get_article params[:id]

    if summary[:ok]
      { article: summary[:data], comments: summary[:comments] }.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end

  post('/') do
    payload = JSON.parse(request.body.read)

    summary = @articleCtrl.create_article(payload)

    if summary[:ok]
      { msg: 'Article created' }.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end

  post('/:id') do
    payload = JSON.parse(request.body.read)
    
    summary = @articleCtrl.create_comment(params[:id], payload)
    
    { msg: summary[:msg] }.to_json
  end

  put('/:id') do
    payload = JSON.parse(request.body.read)
    summary = @articleCtrl.update_article params[:id], payload

    if summary[:ok]
      { msg: 'Article updated' }.to_json
    else
      { msg: summary[:msg] }.to_json
    end
  end

  delete('/:id') do
    summary = @articleCtrl.delete_article params[:id]

    if summary[:ok]
      { msg: 'Article deleted' }.to_json
    else
      { msg: 'Article does not exist' }.to_json
    end
  end
end
