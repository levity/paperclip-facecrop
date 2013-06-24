require 'unirest'

class FaceCrop::Detector::LambdaLabs < FaceCrop::Detector::Base
  URL = "https://lambda-face-recognition.p.mashape.com/detect"

  def detect_faces(file)
    response = Unirest.post URL, {'X-Mashape-Authorization' => @options[:mashape_key]}, {files: File.new(file)}
    body = response.body

    photo = body['photos'].first
    photo['tags'].map do |tag|
      # values are returned as percentual values

      x = tag['center']['x'].to_i
      y = tag['center']['y'].to_i
      w = tag['width'].to_i
      h = tag['height'].to_i

      region = FaceCrop::Detector::Region.new(x, y, w, h)
      region.color = "blue"
      region
    end
  end
end