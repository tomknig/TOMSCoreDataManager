Pod::Spec.new do |s|
  s.name             = "TOMSCoreDataManager"
  s.version          = "0.1.0"
  s.summary          = "TOMSCoreDataManager is an approach to simplify persistency with CoreData and an optional REST backend. TOMSCoreDataManager provides handy superclasses for your custom TableViewController or CollectionViewController implementation as well as an useful ManagedObject extension."
  s.homepage         = "https://github.com/TomKnig/TOMSCoreDataManager"
  s.license          = 'MIT'
  s.author           = { "TomKnig" => "hi@tomknig.de" }
  s.source           = { :git => "https://github.com/TomKnig/TOMSCoreDataManager.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/TomKnig'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/**/*.{h,m}'

  s.framework = 'CoreData'

  s.dependency 'AFIncrementalStore'
end
