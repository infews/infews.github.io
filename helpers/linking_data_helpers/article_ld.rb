module LinkingDataHelpers
  class ArticleLd
    include LinkingData

    attr_accessor :article_data, :stripped_body
    attr_reader :linking_data

    def initialize
      @linking_data = {
        "@type": "BlogPosting"
      }

      yield self

      @linking_data.merge!(
        headline: @article_data.title,
        abstract: @article_data.teaser,
        keywords: @article_data.keywords,
        articleBody: @stripped_body
      )

      is_authored_node
    end
  end
end
