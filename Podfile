# Uncomment the next line to define a global platform for your project
platform :ios, '16.2'

target 'Reciplease' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Reciplease
pod 'Alamofire'

pod 'AlamofireImage'

pod 'MarqueeLabel'

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.2'
  end
 end
end
 
end
