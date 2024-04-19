require './html_parser'

describe HTMLParser do
  describe '.parse' do
    let(:html_file) { './code-challenge/files/van-gogh-paintings.html' }

    context 'when given a valid HTML file' do
      before do
        HTMLParser.parse(html_file)
        @results_json = JSON.parse(File.read('results.json'))
      end

      it 'creates a results.json file' do
        expect(File.exist?('results.json')).to be true
      end

      it 'parses artworks correctly' do
        expect(@results_json["artworks"]).not_to be_empty
      end

      it "artworks" do
        expect(@results_json["artworks"]).to be_a(Array)
        expect(@results_json["artworks"]).to_not be_empty
      end

      it "artworks - name" do
        expect(@results_json["artworks"][0]["name"]).to be_a(String)
        expect(@results_json["artworks"][0]["name"]).to_not be_empty
      end

      it "artworks - extensions" do
        expect(@results_json["artworks"][0]["extensions"]).to be_a(Array)
        expect(@results_json["artworks"][0]["extensions"]).to_not be_empty
      end

      it "artworks - link" do
        expect(@results_json["artworks"][0]["link"]).to be_a(String)
        expect(@results_json["artworks"][0]["link"]).to_not be_empty
      end

      it "artworks - image" do
        expect(@results_json["artworks"][0]["image"]).to be_a(String)
        expect(@results_json["artworks"][0]["image"]).to_not be_empty
      end
    end
  end
end
