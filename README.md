# Permit

Permit framework provides a universal API for querying the permission status of different kinds of permissions, in an abstracted format with only what the user needs to know.

## Navigate

- [Install](#Install)
- [Usage](#Usage)
- [Available Use Cases](#Available-Use-Cases)
- [Desired Features](#Desired-Features)
- [Contribution Guide](#Contribution-Guide)

## Install

Ready to use of iOS 12+. For iOS only right now.

Permit can be installed throught `Cocoapods`. [CocoaPods](https://cocoapods.org) is a dependency manager for Apple Platforms. For usage and installation instructions, visit their website. To integrate using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'Permit'
```

## Usage

`Permit` aims to provide a very minimal API for accessing and requesting permissions for different use cases. For a list of available use cases, see [available use cases](#Available-Use-Cases).

Request status between `isAuthorized`, `isDenied` and `isNotDetermined` like: 

```swift
if Permit.isAuthorized(usecase: .camera) {
	// do any stuff for authorised
} else {
	// we know that it is either denied or not-determined..
	// so, request permission which handles both usecases internally.
	Permit.requestPermission(usecase: type, showPopupIfNeededOn: self) { result in
		switch result {
		case let .success(type):
			// do permission granted stuff
		case let .failure(error):
		 // show error dialog
	}
}
```

You can also provide custom alert configs like:

```swift
struct DeniedAlertConfig: AlertConfig {
  var title: String
  var message: String
  var cancelButtonText: String
  var settingsButtonText: String
  
  init() {
      self.title = "Demo Denied Alert Title"
      self.message = "Demo Denied Alert Message"
      self.cancelButtonText = "Cancel"
      self.settingsButtonText = "Settings"
  }
}
```

And use them while requesting permissions as:

``` swift
let config: AlertConfig = DeniedAlertConfig()
Permit.requestPermission(usecase: type, 
                         showPopupIfNeededOn: self, 
                         settingsDialogConfig: alertConfig) { result in }
```

## Available Use Cases

- Camera
- Calendar
- Contacts
- Location When In Use
- Location Always 
- Microphone
- Notifications
- Photos

## Desired Features

- More coverage on Permission across Apple platforms.
- More platform support - MacOS, TvOS etc.
- Segregation between frameworks so that only needed ones can be used.
- [Maybe?] Custom alerts for pre-asking some permissions.

## Contribution Guide

We are welcoming any and all contributions in the framework from the community. We should together strive to make this framework better for everyone of us. To contribute:

1. Fork this repository as your own.
2. For issues: Please indicate that you will pickup the issue and fix it. Discuss the approach with the moderators and continue to build that fix. Raise the Pull Request to `main` branch along with issue.
3. For new features: Please indicate the need for new features, and any approach you might have to build that. Discuss the approach with moderators and build it! Raise the Pull Request to `main`. 
4. Please make use of tags while adding issues, such as `version numbers`, `feature`, `bug` etc.
5. We look forward to your contributions!

## Credits
[Bhagat Singh](https://twitter.com/soulful_swift), [Srikanth KV](https://twitter.com/SrikanthVKabadi), [Pulkit Karira]()
