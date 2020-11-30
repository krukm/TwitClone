# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TwitClone' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TwitClone
pod 'Swifter', :git => "https://github.com/mattdonnelly/Swifter.git", :tag => '2.4.0'

  target 'TwitCloneTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TwitCloneUITests' do
    # Pods for testing
  end
workspace 'TwitClone'

plugin 'cocoapods-keys', {
  :project => "TwitClone",
  :keys => [
    "TwitterAPIClientSecret",
    "TwitterAPIClientKey"
  ]}

end

