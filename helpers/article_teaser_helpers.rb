module ArticleTeaserHelpers
  def teaser_for(article)
    teaser = article.data.teaser
    return "" unless teaser

    article.data.teaser
  end
end
