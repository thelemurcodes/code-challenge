require 'nokogiri'
require 'json'

module HTMLParser
  def self.parse(html_file)
    # Read the HTML file
    html_content = File.read(html_file)

    # Parse the HTML content
    doc = Nokogiri::HTML(html_content)

    # Extract painting information
    artworks = []

    doc.css('.klitem, .ttwCMe').each do |artwork|
      image = artwork.at_css('img')

      if artwork['class'].include?('ttwCMe')
        name = artwork.at_css('.oyj2db')&.text
        extensions_text = artwork.at_css('.MVXjze')&.text
        extensions = extensions_text.scan(/\d{4}/).map(&:strip)
      else
        title = artwork['title']
        next unless title

        name, extensions = title.split(' (', 2)
        extensions = extensions&.delete(')')&.split(',')
        image_data = image['data-key'] if image
      end

      link = artwork['href']

      artworks << {
        name: name,
        extensions: extensions ? extensions : nil,
        link: link ? "https://www.google.com#{link}" : nil,
        image: image_data ? image_data : nil
      }
    end

    File.open('results.json', 'w') do |file|
      file.write('{"artworks": ' + JSON.pretty_generate(artworks.map { |artwork| artwork.reject { |k, v| k == :extensions && v.nil? } })+'}')
    end
  end
end
