#
#  Be sure to run `pod spec lint HHNavigationController.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "HHNavigationController"
  s.version      = "0.0.3"
  s.summary      = "yet another navigation controller for iOS"
  s.description  = <<-DESC
                   yet another navigation controller for iOS
                   DESC
  s.homepage     = "https://github.com/shuoshi/HHNavigationController"
  s.license      = "MIT"
  s.author       = { "陈小实" => "chenshuoshi@gmail.com" }
  s.source       = { :git => "https://github.com/shuoshi/HHNavigationController.git", :tag => "0.0.3" }
  s.source_files  = "HHNavigationController/*.{h,m}"
end
