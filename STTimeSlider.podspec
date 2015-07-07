#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "STTimeSlider"
  s.version          = "1.2.3"
  s.source           = { :git => "https://github.com/jschwendt/STTimeSlider.git", :tag => s.version.to_s }
  s.authors =  { 'Sebastien THIEBAUD' => 'sthiebaud@icloud.com', 'Joe Schwendt' => 'Joe@Schwendt.com' }
  s.homepage = "https://github.com/jschwendt/STTimeSlider"
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.requires_arc = true
  s.source_files  = 'STTimeSlider/*.{h,m}'
  s.frameworks = ["CoreGraphics", "QuartzCore"]

  s.summary          = "A custom component like UISegmentedControl highly customizable."
  s.description      = "If you need to get the device location in multiple sections of the app CLLocationManager may be a solution. CLLocationManager is a wrapper to avoid using multiple CLLocationManager across an application. All delegates added to IKLocation are notified when the location is available or when the refresh method is called. IKLocation automatically removes object when those are deallocated."
end
