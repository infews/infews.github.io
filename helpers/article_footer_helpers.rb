module ArticleFooterHelpers

  def article_footer_for(tags, series)
    footer = "This article is"
    footer += " part of the series #{series_link_for series}" if series
    footer += " and" if series and tags
    footer += " tagged with #{tag_links_for tags}" if tags
    footer += "."
    footer
  end

  def series_link_for(series_name)
    "<a href=\"/series/#{series_name.downcase.gsub(" ", "-")}\">#{series_name}</a>"
  end

  def tag_links_for(tags)
    if tags.length == 1
      return tag_link(tags.first)
    end

    list = tags[0..-2].map do |tag|
      tag_link(tag)
    end.join(", ")

    if tags.length > 2
      list += ","
    end

    list += " and #{tag_link(tags.last)}"
    list
  end

  def tag_link(tag)
    "<a href=\"/tags/#{tag}/\">#{tag}</a>"
  end
end
