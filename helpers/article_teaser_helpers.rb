module ArticleTeaserHelpers
  def teaser_for(article_data)
    article_data.teaser || ""
  end
end
