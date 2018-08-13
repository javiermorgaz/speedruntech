source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'

use_frameworks!
inhibit_all_warnings!

def shared_pods
  
  # Networking
  pod 'Alamofire', '~> 4.5.0'
  
  # UI
  pod 'MBProgressHUD', '~> 1.1.0'
  pod 'SDWebImage', '~> 4.4.0'

  # Logging
  pod 'CocoaLumberjack/Swift', '~> 3.4.0'

end

target 'speedruntech' do
    shared_pods
    
    target 'speedruntechTests' do
        inherit! :search_paths
        # Pods for testing
    end
    
end
