# idmeta-ios-rn

## Getting started

`$ npm install idmeta-ios-rn --save`

### Mostly automatic installation

`$ react-native link idmeta-ios-rn`


# idmeta-ios-rn

`idmeta-ios-rn` is a React Native library integrated with the Idmeta SDK, providing seamless integration and functionality for your React Native applications.

## Installation

Note: "idmeta-ios-rn" project is still in development and is tested upto **RN-0.77** version , this is the beta release for testing.
To install the library, run:

```sh
npm install https://github.com/C4SI-0/idmeta-ios-rn.git
```

OR

"Yarn Add " for better native linking with the module,

Note: Yarn Add is required for now for better automatic installation.

```sh
yarn add  https://github.com/IDMeta/idmeta-ios-rn.git

```

## Ios Setup

To configure your RN Ios project to use this package, 

Open <host>\ios\Podfile

Add the following code on top.

```js
require_relative '../node_modules/idmeta-ios-rn/ios/pods'

```

In Your target inside Podfile

```js
use_idmeta_ios_rn!()

```

Your Podfile will look like this

```js

# Resolve react_native_pods.rb with node to allow for hoisting
require_relative '../node_modules/idmeta-ios-rn/ios/pods'
require Pod::Executable.execute_command('node', ['-p',
  'require.resolve(
    "react-native/scripts/react_native_pods.rb",
    {paths: [process.argv[1]]},
  )', __dir__]).strip

platform :ios, min_ios_version_supported
prepare_react_native_project!

linkage = ENV['USE_FRAMEWORKS']
if linkage != nil
  Pod::UI.puts "Configuring Pod with #{linkage}ally linked Frameworks".green
  use_frameworks! :linkage => linkage.to_sym
end

target 'AwesomeProjectRn' do
  config = use_native_modules!
  use_idmeta_ios_rn!()
  use_react_native!(
    :path => config[:reactNativePath],
    # An absolute path to your application root.
    :app_path => "#{Pod::Config.instance.installation_root}/.."
  )

  post_install do |installer|
    # https://github.com/facebook/react-native/blob/main/packages/react-native/scripts/react_native_pods.rb#L197-L202
    react_native_post_install(
      installer,
      config[:reactNativePath],
      :mac_catalyst_enabled => false,
      # :ccache_enabled => true
    )
  end
end


```

Now Install the Pods

```js
cd ios/
pod install

```

## Error Building

If you getting error on after build

```js
error: Error: Unable to resolve module idmeta-ios-rn from. idmeta-ios-rn could not be found within the project or in these directories:

```
```sh
yarn install
```
Do "Yarn Install" and build the app. It will resolve the issue 


If Your app is crashing on Real Device on debug/Testing

Note: Sdk wont work on some real devices on Debug/Testing mode

Open your xcode project , Goto Product->Scheme->Edit Schemes
For Debug , change Build Configuration to "Release".

![Alt text](https://i.imgur.com/RHmcwaD.png)
![Alt text](https://i.imgur.com/uvnTI4P.png)


## Usage

```js
// App.tsx

import React from 'react';
import { Button, SafeAreaView, ScrollView, StatusBar, Text, View, StyleSheet, useColorScheme } from 'react-native';
import IdmetaIosRn from 'idmeta-ios-rn';

const startIdmetaFlow = () => {
  // Set your flowId and userToken values
  const flowId = 'YourFlowId';
  const userToken = 'YourToken'; //e.g Bearer 12|xxxxxxxxxxxxxxx

  IdmetaIosRn.startActivity(flowId, userToken, (response: string) => {
    console.log('Response from Idmeta:', response);
  });
};

const App = () => {
  const isDarkMode = useColorScheme() === 'dark';
  const backgroundStyle = {
    backgroundColor: isDarkMode ? 'dark' : 'light',
  };

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar barStyle={isDarkMode ? 'light-content' : 'dark-content'} backgroundColor={backgroundStyle.backgroundColor} />
      <ScrollView contentInsetAdjustmentBehavior="automatic" style={backgroundStyle}>
        <View style={{ backgroundColor: isDarkMode ? 'black' : 'white' }}>
          <Button title="Start Idmeta Flow" onPress={startIdmetaFlow} />
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
});

export default App;



```



## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---
