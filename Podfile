source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '13.0'

use_frameworks!
inhibit_all_warnings!

def shared_pods
  
  # Networking
  pod 'Alamofire', '~> 5.2.2'
  
  # UI
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'SDWebImage', '~> 5.8.4'

  # Logging
  pod 'CocoaLumberjack/Swift', '~> 3.6.1'
  
  # Clean Code
  pod 'SwiftLint', '~> 0.39.2'

end

target 'speedruntech' do
    shared_pods
    
    target 'speedruntechTests' do
        inherit! :search_paths
        # Pods for testing
    end
    
end
