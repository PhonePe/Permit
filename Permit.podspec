
Pod::Spec.new do |s|
    
  s.name         = "Permit"
  s.version      = "0.0.1"
  s.summary      = "A framework build to hide away complexities of device permissions in an elegant way."
  s.homepage     = "https://github.com/PhonePe/Permit"
  s.source       = { :git => "https://github.com/PhonePe/Permit.git", :tag => "#{s.version}" }
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "PhonePe" => "ios-support@phonepe.com" }
  s.platform     = :ios, "12.0"
  
  s.description  = <<-DESC
    PhonePe Permit permissions framework
                     DESC
  #fix with subspec
  s.source_files  = "Classes", "Classes/**/*.{h,m}", "Permit/**/*.{swift,h,m}"

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/*.{swift}'
  end
end
