
Pod::Spec.new do |s|
  s.name         = "Core"
  s.version      = "1.0.0"
  s.summary      = "Core"
  s.description  = <<-DESC
                  Core
                   DESC
  s.homepage     = "www.iule.cn"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => '', :tag => s.version }
  s.source_files  = "Core/**/*.{h,m}"
  s.requires_arc = true

end

