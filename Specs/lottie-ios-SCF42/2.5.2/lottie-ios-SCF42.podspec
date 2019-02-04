#
# Be sure to run `pod lib lint lottie-ios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'lottie-ios'
  s.version          = '2.5.2'
  s.summary          = 'Used to natively render vector animations exported from After Effects.'

  s.description      = <<-DESC
Lottie is a mobile library for Android and iOS that parses Adobe After Effects animations exported as json with bodymovin and renders the vector animations natively on mobile and through React Native!

For the first time, designers can create and ship beautiful animations without an engineer painstakingly recreating it be hand. Since the animation is backed by JSON they are extremely small in size but can be large in complexity! Animations can be played, resized, looped, sped up, slowed down, and even interactively scrubbed.
                       DESC

  s.homepage         = 'https://github.com/airbnb/lottie-ios'
  s.license          = { :type => 'Apache', :file => 'LICENSE' }
  s.author           = { 'Brandon Withrow' => 'buba447@gmail.com' }
  s.source           = { :git => 'https://github.com/airbnb/lottie-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'lottie-ios/Classes/**/*'
  s.osx.exclude_files = ['lottie-ios/Classes/PublicHeaders/LOTAnimationTransitionController.h',
                         'lottie-ios/Classes/Private/LOTAnimationTransitionController.m',
                          'lottie-ios/Classes/PublicHeaders/LOTCacheProvider.h',
                          'lottie-ios/Classes/Private/LOTCacheProvider.m',
                          'lottie-ios/Classes/PublicHeaders/LOTAnimatedSwitch.h',
                          'lottie-ios/Classes/Private/LOTAnimatedSwitch.m',
                          'lottie-ios/Classes/PublicHeaders/LOTAnimatedControl.h',
                          'lottie-ios/Classes/Private/LOTAnimatedControl.m']
  # s.resource_bundles = {
  #   'lottie-ios' => ['lottie-ios/Assets/*.png']
  # }

  s.public_header_files = 'lottie-ios/Classes/PublicHeaders/*.h'
  s.ios.frameworks = 'UIKit'
  s.osx.frameworks = ['AppKit', 'CoreVideo']
  s.module_name = 'Lottie'
  s.header_dir = 'Lottie'

# MARK: - iOS Static Framework

  s.name = "#{s.name}-SCF42"

  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'

  s.default_subspec = 'StaticCocoaFramework'
  s.source = {
    http: "https://dl.bintray.com/roxiemobile/generic/lottie-ios-#{s.version}-SCF42.zip",
    sha256: '5e634691be9389b4470aad443be55f3f215538e2dc35bf5111b77070b94f200e'
  }

  s.source_files = nil
  s.public_header_files = nil

  s.subspec 'StaticCocoaFramework' do |sc|
    sc.preserve_paths = 'Lottie.framework/*'
    sc.source_files = 'Lottie.framework/Headers/*.h'
    sc.public_header_files = 'Lottie.framework/Headers/*.h'
    sc.vendored_frameworks = 'Lottie.framework'
  end
end
