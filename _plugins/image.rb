# -*- encoding : utf-8 -*-
# image block tag

module Jekyll
  module Tags
    class ImageTag < Liquid::Block
      def initialize(tag_name, markup, tokens)
        super
        @markup = markup
      end

      def render(context)
        alt = super
        path = File.join(context["site"]["baseurl"], "/img", File.basename(context["page"]["url"], ".*"), @markup);

        "<figure><img src=\"#{path}\" alt=\"#{alt}\"><figcaption>#{alt}</figcaption></figure>"
      end
    end
  end
end

Liquid::Template.register_tag('image', Jekyll::Tags::ImageTag)
