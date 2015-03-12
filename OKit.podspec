Pod::Spec.new do |s|

  s.name        = "OKit"
  s.version     = "1.0.0"
  s.summary     = "OKit, API clients made easy"
  s.homepage    = "https://github.com/bilby91/OKit"
  s.license     = { :type => "MIT" }
  s.authors     = { "bilby91" => "fmartin91@gmail.com" }

  s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "7.0"
  s.source   = { :git => "https://github.com/bilby91/OKit.git", :tag => s.version.to_s }
  s.source_files = "Source/*.{swift,h,m}"

  s.dependency 'Alamofire'
  s.dependency 'ObjectMapper'

end
