require_relative '../../helpers/tag_sentence_helpers'
require "active_support/core_ext/array/conversions"

RSpec.describe TagSentenceHelpers do
  class Helpers
    include TagSentenceHelpers

    # lightweight dumb implementation because using Middleman's was complex
    def link_to(text, url)
      "<a href=\"#{url}\">#{text}</a>"
    end
  end

  let(:helpers) { Helpers.new }

  context "when an article has no tags and not part of a series" do
    context "when both are undefined" do
      let(:tags) { nil }
      let(:series_url) { nil }
      it "returns an empty string" do
        expect(helpers.tag_sentence_for(tags, series_url)).to eq("")
      end
    end

    context "when both are empty" do
      let(:tags) { [] }
      let(:series_url) { "" }
      it "returns an empty string" do
        expect(helpers.tag_sentence_for(tags, series_url)).to eq("")
      end
    end

    context "when tags is empty" do
      let(:tags) { [] }
      let(:series_url) { nil }
      it "returns an empty string" do
        expect(helpers.tag_sentence_for(tags, series_url)).to eq("")
      end
    end

    context "when series is empty" do
      let(:tags) { nil }
      let(:series_url) { "" }
      it "returns an empty string" do
        expect(helpers.tag_sentence_for(tags, series_url)).to eq("")
      end
    end
  end

  context "when the article is part of a series" do
    context "and has no tags" do
      let(:tags) { nil }
      let(:series_url) { "sasquatch-coffee" }
      let(:series_title) { "Sasquatch Coffee" }

      it "builds the right linked sentence" do
        expect(helpers.tag_sentence_for(tags, series_url, series_title)).to eq("This article is part of the series <a href=\"/series/sasquatch-coffee\">Sasquatch Coffee</a>.")
      end
    end

    context "and has tags" do
      let(:tags) { ["foo", "bar"] }
      let(:series_url) { "sasquatch-coffee" }
      let(:series_title) { "Sasquatch Coffee" }

      it "builds the right linked sentence" do
        expect(helpers.tag_sentence_for(tags, series_url, series_title)).to eq("This article is part of the series <a href=\"/series/sasquatch-coffee\">Sasquatch Coffee</a> and is tagged with <a href=\"/tags/foo\">foo</a> and <a href=\"/tags/bar\">bar</a>.")
      end

    end
  end

  context "when the article is not part of a series" do
    context "and has one tag" do
      let(:tags) { ["foo"] }
      let(:series_url) { nil }
      it "builds the right linked sentence" do
        expect(helpers.tag_sentence_for(tags, series_url)).to eq("This article is tagged with <a href=\"/tags/foo\">foo</a>.")
      end
    end

    context "and has one multi-word tag" do
      let(:tags) { ["foo bar"] }
      let(:series_url) { nil }
      it "builds the right linked sentence" do
        expect(helpers.tag_sentence_for(tags, series_url)).to eq("This article is tagged with <a href=\"/tags/foo-bar\">foo bar</a>.")
      end
    end

    context "and has two tags" do
      let(:tags) { ["foo", "bar"] }
      let(:series_url) { nil }
      it "builds the right linked sentence" do
        expect(helpers.tag_sentence_for(tags, series_url)).to eq("This article is tagged with <a href=\"/tags/foo\">foo</a> and <a href=\"/tags/bar\">bar</a>.")
      end
    end
    context "and has more than two tags" do
      let(:tags) { ["foo", "bar", "baz"] }
      let(:series_url) { nil }
      it "builds the right linked sentence" do
        expect(helpers.tag_sentence_for(tags, series_url)).to eq("This article is tagged with <a href=\"/tags/foo\">foo</a>, <a href=\"/tags/bar\">bar</a>, and <a href=\"/tags/baz\">baz</a>.")
      end
    end

  end
end