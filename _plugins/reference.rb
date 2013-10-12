# -*- encoding : utf-8 -*-
module Jekyll
  class ReferenceList < Liquid::Tag
    def render(context)
      "**参考文献**"
    end
  end
end

Liquid::Template.register_tag('referencelist', Jekyll::ReferenceList)
