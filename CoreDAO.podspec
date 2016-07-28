Pod::Spec.new do |s|
   s.name = 'CoreDAO'
   s.version = '1.0'
   s.license = 'MIT'

   s.summary = 'Lib CoreDAO'
   s.homepage = 'https://github.com/Klimowsa/CoreDAO'
   s.author = 'RMR + AGIMA'

   s.source = { :git => 'https://github.com/Klimowsa/CoreDAO.git', :tag => s.version }
   s.source_files = 'Source/CoreDAO/**/*.{h,m}'

   s.platform = :ios
   s.ios.deployment_target = '8.0'

   s.frameworks = 'CoreData'

   s.requires_arc = true
end