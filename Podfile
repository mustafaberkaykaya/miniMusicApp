# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
workspace "miniMusicApp"
target 'miniMusicApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for miniMusicApp
  # UI
  pod 'TinyConstraints', '~> 4.0'
  
  pod 'lottie-ios'
  
  # Network
  pod 'Alamofire', '~> 5.6'

  target 'miniMusicAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'miniMusicAppUITests' do
    # Pods for testing
  end

end

target 'UIComponents' do
  
  project 'UIComponents/UIComponents.xcodeproj'
  
  # Pods for UIComponents
  
  # UI
  pod 'lottie-ios'
  pod 'TinyConstraints', '~> 4.0'
  

end
