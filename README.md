# RBQSafeRealmObject

##### Thread-Safe Representation Of A Realm Object

[![Version](https://img.shields.io/cocoapods/v/RBQSafeRealmObject.svg?style=flat)](http://cocoapods.org/pods/RBQSafeRealmObject)
[![License](https://img.shields.io/cocoapods/l/RBQSafeRealmObject.svg?style=flat)](http://cocoapods.org/pods/RBQSafeRealmObject)
[![Language Objective-C | Swift 3](https://img.shields.io/badge/Language-ObjectiveC%20%2F%20Swift%203-orange.svg)](https://developer.apple.com/swift)
[![Platform](https://img.shields.io/cocoapods/p/RBQSafeRealmObject.svg?style=flat)](http://cocoapods.org/pods/RBQSafeRealmObject)

This class allows you to create a thread-safe representation of a given `RLMObject` subclass. For example, this enables performing queries on a background thread, and passing results as `RBQSafeRealmObject` to the main-thread for display.

_**Note: It will only work with an `RLMObject` that has a primary key.**_

Both an Objective-C and Swift version are availble. Swift 2.0 support added in version 0.4.

#### How To Use

Objective-C

```objc
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    RLMObjectSubclass *anObject = [RLMObjectSubclass objectForPrimaryKey:@"key"];

    RBQSafeRealmObject *safeObject = [RBQSafeRealmObject safeObjectFromObject:anObject];

    dispatch_async(dispatch_get_main_queue(), ^{
        RLMObjectSubclass *mainThreadObject = [safeObject RLMObject];

        // Do Something...
    });
});
```

Swift 3

```swift
DispatchQueue.global().async {
    let anObject = Object()

    let safeObject = SafeObject(object: anObject)

    DispatchQueue.main.async {
        let mainThreadObject = safeObject.object()
    }
}
```

#### Installation

RBQSafeRealmObject is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

Objective-C

```ruby
pod "RBQSafeRealmObject"
```

Swift

```ruby
pod "SafeRealmObject"
```

#### CocoaPod Linting

Linting using CocoaPods 1.1.0.rc.2 (with Xcode 8 fixes) needs `FORK_XCODE_WRITING` to be set to get the build to work. One warning comes through from Realm core.

```bash
FORK_XCODE_WRITING=true pod lib lint SafeRealmObject.podspec --allow-warnings
```

