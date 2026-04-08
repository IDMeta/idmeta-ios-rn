# # FlutterModuleRn.podspec

require './ios/Podspecs/common'

Pod::Spec.new do |s|
  setCommonProps(s)
  s.name         = "IdmetaIosRn"
  s.description  = <<-DESC
                  idmeta_ios_rn
                   DESC
  s.source_files = "ios/**/*.{h,c,cc,cpp,m,mm,swift}"
  s.dependency "React-Core"
  s.dependency "Flutter"
  s.dependency "GoogleMLKit/FaceDetection"
  s.dependency "GoogleMLKit/MLKitCore"
  s.dependency "GoogleMLKit/BarcodeScanning"
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-undefined dynamic_lookup' }
  s.vendored_frameworks = [
    "ios/Frameworks/IDLiveFaceCamera.xcframework",
    "ios/Frameworks/IDLiveFaceDetection.xcframework",
    "ios/Frameworks/IDLiveFaceIAD.xcframework",
    "ios/Frameworks/BlinkID.xcframework"  
  ]
  s.frameworks = ['AVFoundation', 'UIKit']  # optional but safe
end
