# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'COVID-19-vaccination-center' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for COVID-19-vaccination-center
  pod 'SnapKit'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxCoreLocation', '~> 1.5.1'
  pod 'RxMKMapView'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
   target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
