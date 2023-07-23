module LinkingDataHelpers
  class ArticleLd
    include LinkingData

    def initialize
      @linking_data = {
        "@type": "BlogPosting"
      }

      yield self
      is_authored_node
    end

    def article_data=(data)
      @linking_data.merge!(
        headline: data.title,
        abstract: data.teaser,
        keywords: data.keywords,
      )
    end

    def stripped_body=(body_text)
      @linking_data.merge!(
        articleBody: body_text
      )
    end
  end
end
