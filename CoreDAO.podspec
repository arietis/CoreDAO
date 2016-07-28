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

   s.frameworks = 'Realm'
   s.module_map = 'Source/Module.modulemap'
   s.compiler_flags = "-DREALM_HAVE_CONFIG -DREALM_COCOA_VERSION='@\"#{s.version}\"' -D__ASSERTMACROS__"
   s.dependency 'Realm', '~> 1.0'

   s.requires_arc = true
end