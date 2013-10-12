# -*- encoding : utf-8 -*-
# Authored my Maxfan http://github.com/Maxfan-zone http://maxfan.org
# This is used to convert tikz code into svg file and load in you jekyll site
#
# Install:
#
#   1. Copy this file in your _plugins/ directory. You can customize it, of course.
#   2. Make sure texlive and Imagemagick are installed on your computer.
#
# Input:
#   
#   {% tikz filename %}
#     \tikz code goes here 
#   {% endtikz %}
#
# This will generate a /tikz/post-title-from-filename/filename.svg in your jekyll directory
# 
# And then return this in your HTML output file:
#   
# Note that it will generate a /_tikz_tmp directory to save tmp files.
#

module Jekyll
  module Tags
    class Tikz < Liquid::Block
      def initialize(tag_name, markup, tokens)
        super
        @figcaption = markup.split(":name").first
        @file_name = markup.split(":name").last.gsub(/\s+/, "")

        @header = <<-'END'
        \documentclass{standalone}
        \usepackage{tikz}
        \usepackage{_source/custom}
        \begin{document}
        \fontsize{16px}{16px}\selectfont
        \begin{tikzpicture}[color=customtextcolor]
        END

        @footer = <<-'END'
        \end{tikzpicture}
        \end{document}
        END
      end

      def render(context)
        tikz_code = @header + super + @footer

        tmp_directory = File.join(Dir.pwd, "_source/_tikz_tmp", File.basename(context["page"]["url"], ".*"))
        tex_path = File.join(tmp_directory, "#{@file_name}.tex")
        pdf_path = File.join(tmp_directory, "#{@file_name}.pdf")
        FileUtils.mkdir_p tmp_directory

        dest_directory = File.join(Dir.pwd, "_source/tikz", File.basename(context["page"]["url"], ".*"))
        dest_path = File.join(dest_directory, "#{@file_name}.png")
        FileUtils.mkdir_p dest_directory


        # if the file doesn't exist or the tikz code is not the same with the file, then compile the file
        if !File.exist?(tex_path) or !tikz_same?(tex_path, tikz_code) or !File.exist?(dest_path)
          File.open(tex_path, 'w') { |file| file.write("#{tikz_code}") }
          system("pdflatex -output-directory #{tmp_directory} #{tex_path}")
          system("convert -density 96 -depth 8 -quality 85 #{pdf_path} #{dest_path}")
        end

        web_dest_path = File.join(context["site"]["baseurl"], "/tikz", File.basename(context["page"]["url"], ".*"), "#{@file_name}.png")
        "<figure><img src=\"#{web_dest_path}\"><figcaption>#{@figcaption}</figcaption></figure>"
      end

      private

      def tikz_same?(file, code)
        File.open(file, 'r') do |file|
          file.read == code
        end
      end
    end

    class Latex < Tikz
      def initialize(tag_name, markup, tokens)
        super
        @header = <<-'END'
        \documentclass{standalone}
        \usepackage{tikz}
        \usepackage{_source/custom}
        \begin{document}
        \fontsize{16px}{16px}\selectfont
        END

        @footer = <<-'END'
        \end{document}
        END
      end
    end
  end
end



Liquid::Template.register_tag('tikz', Jekyll::Tags::Tikz)
Liquid::Template.register_tag('latex', Jekyll::Tags::Latex)
