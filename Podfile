# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

def web_service
  pod 'SwiftyJSON' , '5.0.1'
  pod 'Alamofire' , '5.0.0'
  pod 'ObjectMapper' , '4.2.0'
  pod 'RecaptchaEnterprise', '18.6.0'
end

def downloader
  pod 'SDWebImage', '~> 5.0'
end

def ui
  pod 'SnapKit', '~> 5.0.0'
  pod "UPCarouselFlowLayout"
  pod 'Introspect'
end

def convertor
  pod 'PhoneNumberKit', '~> 3.6'
end

def real_time
  pod 'WebRTC'
  pod 'ParseLiveQuery', '~> 2.8'
end

def google
  pod 'GoogleSignIn'
end

def facebook
  pod 'FBSDKLoginKit'
end

def chat
  pod 'Crisp'
end

def security
  pod 'RecaptchaEnterprise', '18.6.0'
end

def lightbox
  pod 'Lightbox'
end

def notification
  pod 'Firebase/Messaging'
end

def firebase
  pod 'Firebase'
  pod 'FirebaseCrashlytics'
  pod 'GoogleAnalytics'
end

def share_pod
  web_service
  downloader
  ui
#  convertor
#  real_time
  google
  facebook
#  lightbox
  firebase
#  chat
#  security
  notification
end

target 'up' do
  use_frameworks!
  share_pod
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
  end
end
