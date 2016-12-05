#
# Be sure to run `pod lib lint AMDragDrop.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AMDragDrop'
  s.version          = '0.1.0'
  s.summary          = 'A UIView subclass that provide drag & drop functionality.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  AMDragDrop is a simple subclass for UIView that adds in a simple way the drag and drop funtionality. Feel free to Use/Modify!
 DESC

  s.homepage         = 'https://github.com/Posix88/AMDragDrop'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Antonino Francesco Musolino' => 'ninomusolino@gmail.com' }
  s.source           = { :git => 'https://github.com/Posix88/AMDragDrop.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Ninomusolino'

  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.source_files = 'AMDragDrop/Classes/**/*'
  

end
