module LinkingDataHelpers
  private

  class SeriesLd
    include LinkingData
    attr_accessor :series_data
    def initialize
      @linking_data = {
        "@type": "Blog",
        abstract: "A personal blog about software, productivity, career, and personal history.",
        keywords: "software development, agile, career, personal",
        headline: "DWF's Journal",
        blogPost: []
      }
      is_root_node

      yield self

      @linking_data.merge!(
        headline: @series_data.title,
        abstract: @series_data.teaser,
        keywords: @series_data.keywords,
      )
    end

    def articles=(new_articles)
      @linking_data[:blogPost] << new_articles
      @linking_data[:blogPost].flatten!
    end
  end
end
