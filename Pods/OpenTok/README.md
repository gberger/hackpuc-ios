OpenTok iOS SDK
================

The OpenTok iOS SDK lets you use OpenTok-powered video sessions in apps
you build for iPad, iPhone, and iPod touch devices.

Apps written with the OpenTok iOS SDK 2.6.1 can interoperate with OpenTok apps
written with the following OpenTok SDKs:

* [OpenTok.js 2.4+](http://tokbox.com/developer/sdks/js/)

* [OpenTok Android SDK
  2.4+](http://tokbox.com/opentok/developer/sdks/android/)

* [OpenTok iOS SDK 2.4+](http://tokbox.com/developer/sdks/ios/)

Using the SDK
-------------

The OpenTok.framework directory contains the OpenTok iOS SDK.

The OpenTok iOS SDK is available as the Pod "OpenTok", for use with
[CocoaPods](http://cocoapods.org/).

The OpenTok iOS SDK requires Xcode 5+.

The OpenTok iOS SDK requires the following frameworks:

* AudioToolbox.framework
* AVFoundation.framework
* CoreGraphics.framework
* CoreMedia.framework
* CoreTelephony.framework
* CoreVideo.framework
* Foundation.framework
* GLKit.framework
* libc++.dylib
* libsqlite3.dylyp
* OpenGLES.framework
* QuartzCore.framework
* SystemConfiguration.framework
* UIKit.framework
* VideoToolbox.framework

Do not use the `-all_load` linker flag. Instead, use the `-force_load` linker
flag to load specific libraries that require it.

The OpenTok iOS SDK links to the libc++ standard library. If another library
that links to the libc++ standard library was compiled in a version of Xcode
older than 6.0.0, it may result in segfaults at run time when using it with the
OpenTok iOS SDK. Known incompatible libraries include, but are not limited to,
Firebase (versions earlier than 2.1.2 -- see
https://code.google.com/p/webrtc/issues/detail?id=3992) and Google Maps
(versions earlier than 1.9.0). To fix this issue, download a version of the
other library that was compiled using XCode 6.0.0 or later.

See the [release notes](release-notes.md) for information on the latest version
of the SDK and for a list of known issues.

See [this document](http://tokbox.com/developer/sdks/ios/background-state.html)
for information on using the SDK in apps running in the background mode.

System requirements
-------------------

The OpenTok iOS SDK is supported on the following devices:

* iPhone 4S+
* iPad 2+
* iPod Touch 5+

The OpenTok iOS SDK is supported in iOS 6+.

The OpenTok iOS SDK is supported on Wi-Fi and 4G/LTE connections.

The OpenTok iOS SDK supports one published audio-video stream, one
subscribed audio-video stream, and up to three additional subscribed
audio-only streams simultaneously. (This is the baseline support on
an iPhone 4S.) To connect more than two clients in a session using the
OpenTok iOS SDK, create a session that uses the OpenTok Media Router
(a session with the media mode set to routed). See
[The OpenTok Media Router and media
modes](http://tokbox.com/developer/guides/create-session/#media-mode).

Sample apps
-----------

For sample code, go to the
[opentok-ios-sdk-samples repo](https://github.com/opentok/opentok-ios-sdk-samples)
at GitHub.

Documentation
-------------

Reference documentation is included in the docs subdirectory of the SDK and at
<http://www.tokbox.com/developer/sdks/ios/reference/index.html>.

More information
-----------------

For a list of API and changes and user interface changes from version 2.1.7 of
the OpenTok iOS SDK, see [Migrating to the latest version of the OpenTok
SDK](http://tokbox.com/developer/sdks/ios/migrating-to-version-2.2.html).

For a list of new features and known issues, see the [release notes](release_notes.md).
