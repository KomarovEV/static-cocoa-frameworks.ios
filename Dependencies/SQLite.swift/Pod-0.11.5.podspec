Pod::Spec.new do |s|
  s.name             = "SQLite.swift"
  s.version          = "0.11.5"
  s.summary          = "A type-safe, Swift-language layer over SQLite3 for iOS and OS X."

  s.description      = <<-DESC
    SQLite.swift provides compile-time confidence in SQL statement syntax and
    intent.
                       DESC

  s.homepage         = "https://github.com/stephencelis/SQLite.swift"
  s.license          = 'MIT'
  s.author           = { "Stephen Celis" => "stephen@stephencelis.com" }
  s.source           = { :git => "https://github.com/stephencelis/SQLite.swift.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/stephencelis'

  s.module_name      = 'SQLite'
  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.1"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "2.2"
  s.default_subspec  = 'standard'
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '4.1',
  }

  s.subspec 'standard' do |ss|
    ss.source_files = 'Sources/{SQLite,SQLiteObjc}/**/*.{c,h,m,swift}'
    ss.exclude_files = 'Sources/**/Cipher.swift'
    ss.private_header_files = 'Sources/SQLiteObjc/*.h'
    ss.library = 'sqlite3'

    ## ss.test_spec 'tests' do |test_spec|
    ##   test_spec.resources = 'Tests/SQLiteTests/fixtures/*'
    ##   test_spec.source_files = 'Tests/SQLiteTests/*.swift'
    ## end
  end

  s.subspec 'standalone' do |ss|
    ss.source_files = 'Sources/{SQLite,SQLiteObjc}/**/*.{c,h,m,swift}'
    ss.exclude_files = 'Sources/**/Cipher.swift'
    ss.private_header_files = 'Sources/SQLiteObjc/*.h'

    ss.xcconfig = {
      'OTHER_SWIFT_FLAGS' => '$(inherited) -DSQLITE_SWIFT_STANDALONE'
    }
    ss.dependency 'sqlite3'

    ## ss.test_spec 'tests' do |test_spec|
    ##   test_spec.resources = 'Tests/SQLiteTests/fixtures/*'
    ##   test_spec.source_files = 'Tests/SQLiteTests/*.swift'
    ## end
  end

  s.subspec 'SQLCipher' do |ss|
    ss.source_files = 'Sources/{SQLite,SQLiteObjc}/**/*.{c,h,m,swift}'
    ss.private_header_files = 'Sources/SQLiteObjc/*.h'
    ss.xcconfig = {
      'OTHER_SWIFT_FLAGS' => '$(inherited) -DSQLITE_SWIFT_SQLCIPHER',
      'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) SQLITE_HAS_CODEC=1'
    }
    ss.dependency 'SQLCipher', '>= 3.4.0', '< 4.0.0'

    ## ss.test_spec 'tests' do |test_spec|
    ##   test_spec.resources = 'Tests/SQLiteTests/fixtures/*'
    ##   test_spec.source_files = 'Tests/SQLiteTests/*.swift'
    ## end
  end

# MARK: - iOS Static Framework

  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'

  s.license = {}
  s.static_framework = true

  attr = Pod::Specification::DSL.attributes[:xcconfig]
  s.subspecs.each do |sc|
    cn1 = sc.consumer(:ios)
    sc.source_files = cn1.source_files.map { |pt| "#{cn1.version}/#{pt}" } if !cn1.source_files.blank?
    sc.exclude_files = cn1.exclude_files.map { |pt| "#{cn1.version}/#{pt}" } if !cn1.exclude_files.blank?
    sc.private_header_files = cn1.private_header_files.map { |pt| "#{cn1.version}/#{pt}" } if !cn1.private_header_files.blank?
  end
end
