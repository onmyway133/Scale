Pod::Spec.new do |s|
  s.name             = "Scale"
  s.version          = "1.1.0"
  s.summary          = "Unit converter in Swift"
  s.homepage         = "https://github.com/onmyway133/Scale"
  s.license          = 'MIT'
  s.author           = { "Khoa Pham" => "onmyway133@gmail.com" }
  s.source           = { :git => "https://github.com/onmyway133/Scale.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/onmyway133'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Sources/**/*'
end
