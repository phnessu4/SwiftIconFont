Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.osx.deployment_target  = '10.9'
  s.name = "SwiftIconFont"
  s.summary = "Icons fonts for Swift (FontAwesome, Ionicons, Octicons, Iconic)"
  s.requires_arc = true
  s.version = "2.7.3"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Sedat CIFTCI" => "me@sedat.us" }
  s.homepage = "http://sedat.ninja"
  s.source = { :git => "https://github.com/0x73/SwiftIconFont.git", :tag => "#{s.version}"}
  s.ios.framework = "UIKit"
  s.tvos.framework = "UIKit"
  s.osx.framework = "Cocoa"
  s.ios.source_files   = "SwiftIconFont/Classes/**/*"
  s.ios.resources = "SwiftIconFont/Resources/*.{ttf}"
  s.tvos.source_files   = "SwiftIconFont/Classes/**/*"
  s.tvos.resources = "SwiftIconFont/Resources/*.{ttf}"
  s.osx.source_files   = "SwiftIconFontMac/Classes/**/*"
  s.osx.resources = "SwiftIconFontMac/Resources/*.{ttf}"
end
