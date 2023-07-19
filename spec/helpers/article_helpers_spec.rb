require_relative '../../helpers/article_teaser_helpers'

RSpec.describe ArticleTeaserHelpers do
  class Helpers
    include ArticleTeaserHelpers
  end

  let(:helpers) {Helpers.new}
  let(:article_data) {double("article_data")}

  context "when an article does not have a teaser" do
    it "returns an empty string" do
      allow(article_data).to receive(:teaser) {nil}
      expect(helpers.teaser_for(article_data)).to eq("")
    end
  end

  context "when an article does have a teaser" do
    it "returns it" do
      allow(article_data).to receive(:teaser) {"Teasing the article"}
      expect(helpers.teaser_for(article_data)).to eq("Teasing the article")
    end
  end
end