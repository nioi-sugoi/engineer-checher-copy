class ImageAnalyzeService
  include Service
  require 'open-uri'

  def initialize(image_url)
    @image_url = image_url
  end

  def call
    set_rekognition_client
    result = {}
    begin
      #open-uriでプロフィール画像を開き、バイナリデータに変換
      file = open(@image_url)
      profile_image = file.read
      rekognition_face = @client.detect_faces({ :image => { :bytes => profile_image }, :attributes => ['ALL'] })
      # 人間の顔と判定できなかった場合はラベル解析で犬猫診断
      if rekognition_face.face_details[0] != nil
        result[:age_low] = rekognition_face.face_details[0].age_range.low
        result[:gender] = rekognition_face.face_details[0].gender.value
        result[:gender_confidence] = rekognition_face.face_details[0].gender.confidence
      else 
        rekognition_label = @client.detect_labels({ :image => { :bytes => profile_image }, :max_labels => 10 })
        label_names = rekognition_label.labels.map {|label| label.name}
        if label_names.include?(Settings.animal[:cat])
          result[:animal] = Settings.animal[:cat]
        elsif [Settings.animal[:dog], Settings.animal[:wolf]].any? {|i| label_names.include?(i)}
          result[:animal] = Settings.animal[:dog]
        end
      end
    rescue Aws::Rekognition::Errors::InvalidImageFormatException
      return {}
    end

    result
  end

  private

  def set_rekognition_client
    Aws.config[:region] = "ap-northeast-1"
    Aws.config[:access_key_id] = Rails.application.credentials.aws[:access_key_id]
    Aws.config[:secret_access_key] = Rails.application.credentials.aws[:secret_access_key]
    @client   = Aws::Rekognition::Client.new(:region => "ap-northeast-1")
  end
end
