module TagSentenceHelpers
  def tag_sentence_for(tags, series_url, series_title = "")
    tags = Array(tags)
    series_url ||= ""

    if tags.empty? && series_url.empty?
      return ""
    end

    sentence = ["This article is"]

    unless series_url.empty?
      sentence << "part of the series"
      sentence << "<a href=\"/series/#{series_url}\">#{series_title}</a>"

      if tags.length > 0
        sentence << "and is"
      end
    end

    if tags.length > 0
      linked_tags = Array(tags).collect { |t| link_to(t, tag_url_for(t)) }
      sentence << "tagged with #{linked_tags.to_sentence}"
    end

    sentence.join(" ") + "."
  end

  def tag_url_for(tag)
    "/tags/#{tag.tr(" ", "-")}"
  end
end
