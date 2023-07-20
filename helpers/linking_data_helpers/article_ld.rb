module LinkingDataHelpers
  class ArticleLd
    include LinkingData

    attr_accessor :article_data, :stripped_body

    def initialize
      @data = {
        "@type": "BlogPosting"
      }

      yield self

      @data.merge!(
        headline: @article_data.title,
        abstract: @article_data.teaser,
        keywords: @article_data.keywords,
        articleBody: @stripped_body
      )

      is_authored_node
    end
  end
end
