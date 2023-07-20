module LinkingDataHelpers
  private

  class HomeLd
    include LinkingData
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
    end

    def articles=(new_articles)
      @data[:blogPost] << new_articles
      @data[:blogPost].flatten!
    end
  end
end
