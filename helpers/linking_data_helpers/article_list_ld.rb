module LinkingDataHelpers
  private

  class ArticleListLd
    include LinkingData
    def initialize
      @linking_data = {
        "@type": "Blog",
        blogPost: []
      }
      is_root_node

      yield self
    end

    def summary_data=(data)
      @linking_data.merge!(
        headline: data[:title],
        abstract: data[:teaser],
        keywords: data[:keywords]
      )
    end

    def articles=(new_articles)
      @linking_data[:blogPost] << new_articles
      @linking_data[:blogPost].flatten!
    end
  end
end
