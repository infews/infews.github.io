module LinkingDataHelpers
  private

  # YES. This looks weird. And it is. But creating classes and yielding to blocks
  #   seems to play havoc with Tilt & Middleman. So.
  module LinkingData
    attr_reader :data

    def is_root_node
      @data[:@context] = "https://schema.org"
    end

    def is_authored_node
      me = DwfLd.new.data

      @data.merge!({
        author: me,
        publisher: me,
      })
    end

    def url=(new_url)
      @data[:url] = new_url
    end

    def published_at=(new_date)
      @data[:datePublished] = new_date
      @data[:dateCreated] = new_date
    end

    def updated_at=(new_date)
      @data[:dateModified] = new_date
    end

    def to_json
      @data.to_json
    end
  end
end