module LinkingDataHelpers
  private

  # YES. This looks weird. And it is. But creating classes and yielding to blocks
  #   seems to play havoc with Tilt & Middleman. So.
  module LinkingData
    attr_reader :linking_data

    def is_root_node
      @linking_data[:@context] = "https://schema.org"
    end

    def is_authored_node
      me = DwfLd.new.linking_data

      @linking_data.merge!({
        author: me,
        publisher: me
      })
    end

    def url=(new_url)
      @linking_data[:url] = new_url
    end

    def published_at=(new_date)
      @linking_data[:datePublished] = new_date
      @linking_data[:dateCreated] = new_date
    end

    def updated_at=(new_date)
      @linking_data[:dateModified] = new_date
    end

    def to_json
      @linking_data.to_json
    end
  end
end
