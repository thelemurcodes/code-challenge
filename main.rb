require_relative 'parsers/html_parser'
require_relative 'parsers/test_parser'

def parse_html_file(html_file)
  # Call the HTML parser to parse the provided HTML file
  HTMLParser.parse(html_file)
  # TestParser.parse(html_file)
end

def main
  puts "Choose an option:"
  puts "1. Parse Van gogh file"
  puts "2. Parse Dali file"
  puts "3. Parse Picasso file"
  choice = gets.chomp.to_i

  case choice
  when 1
    html_file = 'files/van-gogh-paintings.html'
    parse_html_file(html_file)
  when 2
    html_file = 'extra-results-pages/dali.html'
    parse_html_file(html_file)
  when 3
    html_file = 'extra-results-pages/pablo-picasso.html'
    parse_html_file(html_file)
  else
    puts "Invalid choice"
  end
end

main
