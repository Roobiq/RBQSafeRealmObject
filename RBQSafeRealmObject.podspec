Pod::Spec.new do |s|
  s.name         = "RBQSafeRealmObject"
  s.version      = "1.0.1"
  s.summary      = "Thread-safe representation of a Realm object"
  s.description  = <<-DESC
RBQSafeRealmObject represents a RLMObject with a primary key and can be used across threads.
                   DESC
  s.homepage     = "https://github.com/Roobiq/RBQSafeRealmObject"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Roobiq" => "support@roobiq.com" }
  s.social_media_url   = "http://twitter.com/Roobiq"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/Roobiq/RBQSafeRealmObject.git", :tag => "v#{s.version}"}
  s.source_files  = "*.{h,m}"
  s.requires_arc = true
  s.dependency 'Realm', '>= 0.99.1'
  s.dependency 'RealmUtilities', '>=0.2.1'
end
