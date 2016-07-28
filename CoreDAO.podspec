Pod::Spec.new do |s|
   s.name = 'CoreDAO'
   s.version = '1.0'
   s.license = 'AGIMA'

   s.summary = 'Lib CoreDAO'
   s.homepage = 'https://github.com/Klimowsa/CoreDAO'
   s.author = 'RMR + AGIMA'

   s.source = { :git => 'https://github.com/Klimowsa/CoreDAO.git', :tag => s.version }
   s.source_files = 'Source/CoreDAO/CoreDAO/Classes/*.h,m'

   s.ios.deployment_target = '8.0'
   s.osx.deployment_target = '10.10'

   s.frameworks = 'CoreData'

   s.requires_arc = true
end