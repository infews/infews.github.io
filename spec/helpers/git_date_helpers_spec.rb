require_relative "../../helpers/git_date_helpers"

class Helpers
  include GitDateHelpers
end

RSpec.describe GitDateHelpers do
  let(:helpers) { Helpers.new }
  let(:filename) { "/Users/dwfrank/workspace/infews.github.io/source/articles/2011-03-24-kids-teachable-moments.html.md" }

  describe "#updated_at" do
    it "returns a Time object that's the last time the file was updated in git" do
      expect(helpers.updated_at(filename)).to eq(Time.parse("2023-07-17 14:32:18.000000000 -0700"))
    end
  end

  describe "#updated_date" do
    it "returns a String with just the date" do
      expect(helpers.updated_date(filename)).to eq("2023.07.17")
    end
  end
end