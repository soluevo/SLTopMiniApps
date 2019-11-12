#
# Be sure to run `pod lib lint SLTopMiniApps.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SLTopMiniApps'
  s.version          = '0.7.0'
  s.summary          = 'This framework was created to make it easy to create a pull to down menu.'

  s.homepage         = 'https://github.com/soluevo/SLTopMiniApps'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'PedroMouraoLM' => 'pedro.mourao@soluevo.com.br' }
  s.source           = { :git => 'https://github.com/soluevo/SLTopMiniApps.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SLTopMiniApps/Classes/**/*'
  
   s.resource_bundles = {
     'SLTopMiniApps' => ['SLTopMiniApps/Assets/*.png']
   }

  s.swift_version = '5.0'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
