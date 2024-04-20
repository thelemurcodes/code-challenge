require 'nokogiri'
require 'benchmark'

module TestParser
  def self.parse(html_file)
    # Read the HTML file
    html_content = File.read(html_file)

    # Parse the HTML content
    time = Benchmark.realtime do
      doc = Nokogiri::HTML(html_content)

      artworks = []

      # Select the g-scrolling-carousel element
      carousel_element = doc.xpath('//g-scrolling-carousel')

      # Check if the carousel element exists
      if carousel_element
      #   # Extract div elements within the carousel based on their depth level
        div_elements = carousel_element.xpath('.//div[a]')

        div_elements.each do |div|
          next if div.at_xpath('.//svg')
          link = div.at_xpath('.//a')
          if link
            image_tag = link.at_xpath('.//img')
            image_url = image_tag['src'] if image_tag
            # image_id = image_tag['id'] if image_tag

            title = link['title']
            name, extensions = title.split(' (', 2)
            extensions = extensions&.delete(')')&.split(',')

            if extensions.nil?
              extensions_text = link.at_css('.MVXjze')&.text
              extensions = extensions_text.scan(/\d{4}/).map(&:strip) if extensions_text && extensions_text.match?(/\d{4}/)
            end

            href = link['href']

            artworks << {
              name: name,
              extensions: extensions ? extensions : nil,
              link: link ? "https://www.google.com#{href}" : nil,
              image: image_url,
            }
          end
        end

        File.open('results/test_results.json', 'w') do |file|
          file.write('{"artworks": ' + JSON.pretty_generate(artworks.map { |artwork| artwork.reject { |k, v| k == :extensions && v.nil? } })+'}')
        end
      end
    end

    puts "TestParser Execution time: #{time.round(4)} seconds"
  end
end
