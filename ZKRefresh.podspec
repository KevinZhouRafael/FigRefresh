#
# Be sure to run `pod lib lint ZKRefresh.Swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZKRefresh'
  s.version          = '1.0.0'
  s.summary          = 'An easy way to use pull-to-refresh for Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
An easy way to use pull-to-refresh for Swift.
                       DESC

  s.homepage         = 'https://github.com/KevinZhouRafael/ZKRefresh'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhoukai' => 'wumingapie@gmail.com' }
  s.source           = { :git => 'https://github.com/KevinZhouRafael/ZKRefresh.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_version = '5'
  s.ios.deployment_target = '8.0'

  s.source_files = 'ZKRefresh/Classes/**/*'
  s.resource_bundles = {
    'ZKRefreshResource' => ['ZKRefresh/Resources/**/*.{storyboard,xib,xcassets,json,imageset,png}']
  }

end
