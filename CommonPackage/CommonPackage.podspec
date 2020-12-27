Pod::Spec.new do |s|
  s.name          = "CommonPackage"
  s.version       = "0.0.1"
  s.summary       = "iOS SDK for CommonPackage"
  s.description   = "iOS SDK for CommonPackage, doesn't including example for now"
  
  s.homepage      = "https://github.com/ramirolvn/"
  s.license       = "MIT"
  s.author        = { 'Ramiro Lima' => 'ramirolvn@gmail.com' }
  
  s.platform      = :ios, "9.0"
  s.swift_version = "5"

  s.dependency 'Kingfisher'
  
  s.source        = {
    :git => "https://github.com/ramirolvn/BeerList.git",
    :tag => "#{s.version}"
  }
  s.source_files        = "CommonPackage/**/*.{h,m,swift}"
end
