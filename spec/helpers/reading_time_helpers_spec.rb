require_relative "../../helpers/reading_time_helpers"

class Helpers
  include ReadingTimeHelpers
end

RSpec.describe ReadingTimeHelpers do
  let(:helpers) { Helpers.new }

  context "when an article has a very short reading time" do
    let(:article_body) { "this is a short article" }

    it "returns an empty string" do
      expect(helpers.reading_time_for(article_body)).to eq("under 1 minute to read")
    end
  end

  context "when an article has a longer reading time" do
    let(:article_body) { "This is a longer article." * 300 }

    it "returns an empty string" do
      expect(helpers.reading_time_for(article_body)).to eq("about a 6 minute read")
    end
  end
end
