module LinkingDataHelpers
  private

  class DwfLd
    include LinkingData

    def initialize
      @data = {
        "@type": "Person",
        name: "Davis W. Frank",
        email: "dwfrank@gmail.com",
        url: "https://dwf.bigpencil.net/about_me",
        alumniOf: "University of Georgia",
        image: "https://dwf.bigpencil.net/images/dwf@2x-b89bef4d.png",
        sameAs: [
          "https://www.linkedin.com/in/daviswfrank",
          "https://github.com/infews",
          "https://ruby.social/@dwfrank",
          "https://www.threads.net/@dwfrank"
        ]
      }

      yield self if block_given?
    end
  end
end
