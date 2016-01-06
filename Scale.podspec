Pod::Spec.new do |s|
  s.name             = "Scale"
  s.version          = "0.1.0"
  s.summary          = "Unit converter in Swift"

  s.homepage         = "https://github.com/onmyway133/Scale"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Khoa Pham" => "onmyway133@gmail.com" }
  s.source           = { :git => "https://github.com/onmyway133/Scale.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/onmyway133'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/Output/**/*'
  s.resource_bundles = {
    'Scale' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/Output/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
