require 'json'

def setCommonProps(s)
  package = JSON.parse(File.read(File.join(__dir__, '../../package.json')))
  s.version       = package["version"]
  s.summary       = package["description"]
  s.homepage      = package['homepage']
  s.license       = package['license']
  s.authors       = { package['author']['name'] => package['author']['url'] }
  s.source        = { :git => package['repository']['url'], :tag => "#{s.version}" }
  s.platforms     = { :ios => "16.0" }
  s.swift_version = '5.0'
  s.requires_arc  = true
end


def generateFrameworksSpecProps(s, configuration)
  setCommonProps(s)
  s.name = "FlutterModuleFrameworks-#{configuration}"
  s.source = { :http => "file://#{__dir__}/../../build/ios/framework/#{configuration}.zip"}
  # You can reference sources as a git repository instead:
  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => "'${PODS_ROOT}/#{s.name}'"}
  s.description  = <<-DESC
                  FlutterModuleFrameworks, #{configuration}
                   DESC
  s.source_files = "**/*.{swift,h,m}"

  conflicting_pods = %w[
    GTMSessionFetcher
    GoogleDataTransport
    GoogleToolboxForMac
    GoogleUtilities
    FBLPromises
    nanopb
    IDLiveFaceCamera
    IDLiveFaceDetection
    IDLiveFaceIAD
  ]
  s.prepare_command = conflicting_pods.map { |fw| "rm -rf #{configuration}/#{fw}.xcframework" }.join("\n")
  s.vendored_frameworks = '**/*.xcframework'
  s.preserve_paths = "**/*.xcframework"
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.dependency "Flutter"
end
