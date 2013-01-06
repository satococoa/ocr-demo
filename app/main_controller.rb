class MainController < UIViewController
  def viewDidLoad
    super
    view.backgroundColor = UIColor.whiteColor
    camera_button = UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
      b.frame = [[10, 50], [300, 40]]
      b.setTitle('写真を撮る', forState:UIControlStateNormal)
      b.addTarget(self, action:'take_picture', forControlEvents:UIControlEventTouchUpInside)
    end
    view.addSubview(camera_button)

    album_button = UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
      b.frame = [[10, 120], [300, 40]]
      b.setTitle('アルバムの写真を選択する', forState:UIControlStateNormal)
      b.addTarget(self, action:'open_album', forControlEvents:UIControlEventTouchUpInside)
    end
    view.addSubview(album_button)

    @text_area = UITextView.new.tap do |t|
      t.frame = [[10, 210], [300, content_frame.size.height - 210 - 10]]
      t.text = 'OCR結果がここに表示されます。'
      t.editable = false
      t.layer.borderWidth = 2
      t.layer.borderColor = UIColor.lightGrayColor.CGColor
      t.layer.cornerRadius = 5
    end
    view.addSubview(@text_area)
  end

  def take_picture
    BW::Device.camera.rear.picture(media_types: [:image]) do |result|
      image = result[:original_image]
      scan(image)
    end
  end

  def open_album
    BW::Device.camera.any.picture(media_types: [:image]) do |result|
      image = result[:original_image]
      scan(image)
    end
  end

  def scan(image)
    p image
    @ocr ||= MotionOCR.alloc.init
    text = @ocr.scan(image.CGImage)
    p text
    @text_area.text = text
  end
end