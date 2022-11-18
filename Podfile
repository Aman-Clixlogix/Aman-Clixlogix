# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'BABL' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for BABL
  
  #Hide pod warnings
  inhibit_all_warnings!
  
  pod 'IQKeyboardManagerSwift'
  pod 'DropDown'
  pod 'Toaster'
  pod 'SwiftLint'
  pod 'Alamofire'
  pod 'AKSideMenu'
  pod 'GooglePlaces'
  pod 'CountryList'


  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'
  pod 'Firebase/Crashlytics'
  pod 'SDWebImage'
  pod 'RealmSwift'
  pod 'SwiftyJSON'
  pod 'ProgressHUD'


  target 'BABLTests' do
     inherit! :search_paths
     pod 'Alamofire'
     pod 'RealmSwift'
   end


  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
  end
  
end
