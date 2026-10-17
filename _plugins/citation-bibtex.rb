# Liquid filter `citation_bibtex`: turns an entry's BibTeX (jekyll-scholar's
# `entry.bibtex`) into a citation-ready record by dropping fields that only
# drive the website and the equal-contribution markers in author names.
require "bibtex"

module Jekyll
  module CitationBibtex
    SITE_ONLY_FIELDS = %i[
      abbr abstract altmetric code html month_numeric note pdf poster
      preview selected slides status supp video website
    ].freeze

    def citation_bibtex(bibtex)
      entry = BibTeX.parse(bibtex.to_s).data.find { |item| item.is_a?(BibTeX::Entry) }
      return "" unless entry

      SITE_ONLY_FIELDS.each { |field| entry.delete(field) }
      entry[:author] = entry[:author].to_s.delete("*†") if entry[:author]
      # A bare & breaks LaTeX; BibTeX needs \&.
      entry.fields.each do |name, value|
        text = value.to_s
        entry[name] = text.gsub(/(?<!\\)&/) { "\\&" } if text.include?("&")
      end
      # Extra braces keep the title's capitalization (e.g. "TexBench", "LSM").
      entry[:title] = "{#{entry[:title]}}" if entry[:title]
      entry.to_s.strip
    end
  end
end

Liquid::Template.register_filter(Jekyll::CitationBibtex)
