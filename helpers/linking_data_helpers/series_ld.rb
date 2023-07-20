module LinkingDataHelpers
  private

  class SeriesLd
    include LinkingData
    attr_accessor :series_data
    def initialize
      @data = {
        "@type": "Blog",
        abstract: "A personal blog about software, productivity, career, and personal history.",
        keywords: "software development, agile, career, personal",
        headline: "DWF's Journal",
        blogPost: []
      }
      is_root_node

      yield self

      @data.merge!(
        headline: @series_data.title,
        abstract: @series_data.teaser,
        # keywords: @article_data.keywords,
      )
    end

    def articles=(new_articles)
      @data[:blogPost] << new_articles
      @data[:blogPost].flatten!
    end
  end
end
