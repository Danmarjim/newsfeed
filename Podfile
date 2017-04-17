# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'newsfeed' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    
    pod 'Firebase/Core'
    pod 'Firebase/Database'
    pod 'Firebase/Auth'
    
    pod 'APESuperHUD', :git => 'https://github.com/apegroup/APESuperHUD.git'
    pod 'SwiftyJSON', :git =>'https://github.com/SwiftyJSON/SwiftyJSON.git'
    
    pod 'Hero'
    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end
end
