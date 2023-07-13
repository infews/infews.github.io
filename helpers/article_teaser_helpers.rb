module ArticleTeaserHelpers
  def teaser_for(article)
    article.data.teaser || ""
  end
end
