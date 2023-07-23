require_relative "../../helpers/linking_data_helpers"
require "nokogiri"
require "json"

RSpec.shared_examples "person fields" do
  it "includes the author" do
    person = ld["author"]
    expect(person["@type"]).to eq("Person")
    expect(person["name"]).to eq("Davis W. Frank")
    expect(person["email"]).to eq("dwfrank@gmail.com")
    expect(person["url"]).to eq("https://dwf.bigpencil.net/about_me")
  end

  it "includes the publisher" do
    person = ld["publisher"]
    expect(person["@type"]).to eq("Person")
    expect(person["name"]).to eq("Davis W. Frank")
    expect(person["email"]).to eq("dwfrank@gmail.com")
    expect(person["url"]).to eq("https://dwf.bigpencil.net/about_me")
  end
end

RSpec.describe LinkingDataHelpers do
  # let(:helpers) { Helpers.new }
  let(:date_re) { /\d\d\d\d-\d\d-\d\d/ }

  # Note: This is a full-stack test, rendering some files, then pulling in HTML
  #   of specific files, parsing the LD+JSON and checking the contents.

  before :all do
    `NO_CONTRACTS=true bundle exec middleman build --clean --parallel`
  end

  after :all do
    `rm -rf build`
  end

  describe "#linking_data_for" do
    let(:formatted_date) { /\d\d\d\d-\d\d-\d\d/ }
    let(:ld) do
      doc = Nokogiri::HTML5(File.read(filepath))
      ld_json = doc.search("//script").first
      JSON.parse(ld_json)
    end

    context "for the home page" do
      let(:filepath) { "build/index.html" }

      include_examples "person fields"

      it "has the correct type" do
        expect(ld["@type"]).to eq("Blog")
      end

      it "includes the content fields" do
        expect(ld["headline"]).to eq("DWF's Journal")
        expect(ld["abstract"]).to match(/^A personal blog/)
      end

      it "includes the date fields" do
        expect(ld["datePublished"]).to match(formatted_date)
        expect(ld["dateCreated"]).to match(formatted_date)
        expect(ld["dateModified"]).to match(formatted_date)
      end

      it "includes relevant blog posts" do
        expect(ld["blogPost"].length).to eq(3)
        latest, cd_test, obsidian = *ld["blogPost"]

        expect(latest["@type"]).to eq("BlogPosting")
        expect(latest["headline"]).to eq("Curiosity and Impatience") # Sorry; this will change

        expect(cd_test["@type"]).to eq("BlogPosting")
        expect(cd_test["headline"]).to eq("The Continuous Delivery Test")

        expect(obsidian["@type"]).to eq("BlogPosting")
        expect(obsidian["headline"]).to eq("How I Obsidian")
      end
    end

    context "for an article page" do
      let(:filepath) { "build/kids-teachable-moments/index.html" }

      include_examples "person fields"

      it "is a root node" do
        expect(ld["@context"]).to eq("https://schema.org")
      end

      it "has the correct type" do
        expect(ld["@type"]).to eq("BlogPosting")
      end

      it "includes the dates" do
        expect(ld["datePublished"]).to match(formatted_date)
        expect(ld["dateCreated"]).to match(formatted_date)
        expect(ld["dateModified"]).to match(formatted_date)
      end

      it "includes the content fields" do
        expect(ld["headline"]).to eq("Kids & Teachable Moments")
        expect(ld["abstract"]).to eq("In which my son learns about lost luggage.")
        expect(ld["url"]).to eq("https://dwf.bigpencil.net/kids-teachable-moments/")
        expect(ld["keywords"]).to eq(["parenting"])
        expect(ld["articleBody"]).to match(/^Back to Work/)
        expect(ld["articleBody"]).not_to match(/<\/?[^>]*>/)
      end
    end

    context "for a series page" do
      let(:filepath) { "build/series/obsidian/index.html" }

      it "is a root node" do
        expect(ld["@context"]).to eq("https://schema.org")
      end

      it "has the correct type" do
        expect(ld["@type"]).to eq("Blog")
      end

      it "includes the content fields" do
        expect(ld["headline"]).to eq("How I Obsidian")
        expect(ld["abstract"]).to match(/^All the tips/)
        expect(ld["keywords"]).not_to be_empty
      end

      it "includes the date fields" do
        expect(ld["datePublished"]).to match(formatted_date)
        expect(ld["dateCreated"]).to match(formatted_date)
        expect(ld["dateModified"]).to match(formatted_date)
      end

      it "includes articles" do
        articles = ld["blogPost"]
        expect(articles.length > 1).to eq(true)
      end
    end

    context "for the about me page " do
      let(:filepath) { "build/about_me/index.html" }

      it "matches the Person json_ld spec" do
        expect(ld["@context"]).to eq("https://schema.org")
        expect(ld["@type"]).to eq("Person")
        expect(ld["name"]).to eq("Davis W. Frank")
        expect(ld["email"]).to eq("dwfrank@gmail.com")
        expect(ld["url"]).to eq("https://dwf.bigpencil.net/about_me/")
        expect(ld["alumniOf"]).to eq("University of Georgia")
        expect(ld["image"]).to eq("https://dwf.bigpencil.net/images/dwf@2x-b89bef4d.png")
        expect(ld["sameAs"]).to eq(["https://www.linkedin.com/in/daviswfrank",
                                    "https://github.com/infews",
                                    "https://ruby.social/@dwfrank",
                                    "https://www.threads.net/@dwfrank"])
      end
    end

    context "for my resume" do
      let(:filepath) { "build/daviswfrank_resume/index.html" }

      it "matches the Person json_ld spec" do
        expect(ld["@context"]).to eq("https://schema.org")
        expect(ld["@type"]).to eq("Person")
        expect(ld["name"]).to eq("Davis W. Frank")
        expect(ld["email"]).to eq("dwfrank@gmail.com")
        expect(ld["url"]).to eq("https://dwf.bigpencil.net/daviswfrank_resume/")
        expect(ld["alumniOf"]).to eq("University of Georgia")
        expect(ld["image"]).to eq("https://dwf.bigpencil.net/images/dwf@2x-b89bef4d.png")
        expect(ld["sameAs"]).to eq(["https://www.linkedin.com/in/daviswfrank",
                                    "https://github.com/infews",
                                    "https://ruby.social/@dwfrank",
                                    "https://www.threads.net/@dwfrank"])
      end
    end

    context "for the all posts page" do
      let(:filepath) { "build/posts/index.html" }

      it "is a root node" do
        expect(ld["@context"]).to eq("https://schema.org")
      end

      it "has the correct type" do
        expect(ld["@type"]).to eq("Blog")
      end

      it "includes the content fields" do
        expect(ld["headline"]).to eq("DWF's Journal - All Posts")
      end

      it "includes the date fields" do
        expect(ld["datePublished"]).to match(formatted_date)
        expect(ld["dateCreated"]).to match(formatted_date)
        expect(ld["dateModified"]).to match(formatted_date)
      end

      it "includes articles" do
        articles = ld["blogPost"]
        expect(articles.length > 1).to eq(true)
      end
    end

    context "for one tags page" do
    end

    context "for the all_tags page" do
    end
  end
end
