# -*- encoding : utf-8 -*-
module Jekyll
  module Tags
    class Theorem < Liquid::Block
      def initialize(tag_name, markup, tokens)
        super
        @header = <<-'END'
<div class="theorem">
<i class="icon-superscript note-icon"></i>
<h5>定理</h5>

        END
        @footer = <<-'END'

</div>
        END
      end
      
      def render(context)
        @header + super + @footer
      end
    end

    class Lemma < Theorem
      def initialize(tag_name, markup, tokens)
        super
        @header = <<-'END'
<div class="lemma">
<i class="icon-quote-left note-icon"></i>
<h5>引理</h5>

        END
      end
    end

    class Property < Theorem
      def initialize(tag_name, markup, tokens)
        super
        @header = <<-'END'
<div class="property">
<i class="icon-magic note-icon"></i>
<h5>性质</h5>

        END
      end
    end

    class Problem < Theorem
      def initialize(tag_name, markup, tokens)
        super
        @header = <<-'END'
<div class="problem">
<i class="icon-question-sign note-icon"></i>
<h5>问题</h5>

        END
      end
    end

    class Prove < Theorem
      def initialize(tag_name, markup, tokens)
        super
        @header = <<-'END'
<div class="prove">
<strong>证明</strong>
END
        @footer = <<-'END'
<i class="icon-check-empty end-prove"></i>
</div>
END
      end
    end

    class Solution < Theorem
      def initialize(tag_name, markup, tokens)
        super
        @header = <<-'END'
<div class="prove">
<strong>解法</strong>
END
        @footer = <<-'END'
<i class="icon-check-empty end-prove"></i>
</div>
END
      end
    end

    class Define < Theorem
      def initialize(tag_name, markup, tokens)
        super
        @header = <<-'END'
<div class="prove">
<strong>定义</strong>
END
        @footer = <<-'END'
<i class="icon-check-empty end-prove"></i>
</div>
END
      end
    end

  end
end

Liquid::Template.register_tag('theorem', Jekyll::Tags::Theorem)
Liquid::Template.register_tag('lemma', Jekyll::Tags::Lemma)
Liquid::Template.register_tag('property', Jekyll::Tags::Property)
Liquid::Template.register_tag('problem', Jekyll::Tags::Problem)
Liquid::Template.register_tag('prove', Jekyll::Tags::Prove)
Liquid::Template.register_tag('define', Jekyll::Tags::Define)
Liquid::Template.register_tag('solution', Jekyll::Tags::Solution)
