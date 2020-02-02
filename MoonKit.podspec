Pod::Spec.new do |s|
  s.name               = "MoonKit"
  s.version            = "1.0.0"
  s.summary            = "MoonKit is a short framework to get information about the moon"
  s.requires_arc       = true
  s.homepage           = "https://github.com/thejohnlima/MoonKit"
  s.license            = "MIT"
  s.author             = { "John Lima" => "thejohnlima@icloud.com" }
  s.social_media_url   = "https://twitter.com/thejohnlima"
  s.platform           = :ios, "9.0"
  s.source             = { :git => "https://github.com/thejohnlima/MoonKit.git", :tag => "#{s.version}" }
  s.source_files       = "Sources/MoonKit/**/*.{swift}"
  s.swift_version      = "5.0"
end
