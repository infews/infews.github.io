require_relative "../../helpers/git_date_helpers"

class Helpers
  include GitDateHelpers
end

RSpec.describe GitDateHelpers do
  let(:helpers) { Helpers.new }
  let(:full_path) { "/Users/dwfrank/workspace/infews.github.io/source/articles/2011-03-24-kids-teachable-moments.html.md" }

  describe "#updated_date" do
    it "returns a String with just the date" do
      expect(helpers.updated_date(full_path)).to eq("2023.07.17")
    end

    context "when a file is not yet in git" do
      let(:full_path) { "/Users/dwfrank/workspace/infews.github.io/source/newfile.md" }
      before do
        system("touch #{full_path}")
      end

      after do
        system("rm #{full_path}")
      end

      it "returns the current date" do
        expect(helpers.updated_date(full_path)).to eq(Time.now.strftime("%Y.%m.%d"))
      end
    end
  end

  describe "#updated_date_dashed" do
    it "returns a String with just the date in a dashed format" do
      expect(helpers.updated_date_dashed(full_path)).to eq("2023-07-17")
    end
  end

  describe "#created_date_dashed" do
    it "returns a String with just the date in a dashed format" do
      expect(helpers.created_date_dashed(full_path)).to eq("2020-09-21")
    end
    context "when a file is not yet in git" do
      let(:full_path) { "/Users/dwfrank/workspace/infews.github.io/source/newfile.md" }
      before do
        system("touch #{full_path}")
      end

      after do
        system("rm #{full_path}")
      end

      it "returns the current date" do
        expect(helpers.created_date_dashed(full_path)).to eq(Time.now.strftime("%Y-%m-%d"))
      end
    end
  end
end
