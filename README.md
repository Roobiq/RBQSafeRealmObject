# RBQSafeRealmObject

### **This project is deprecated as of Realm 2.2 due to native support for passing objects across threads.** 

Realm released "Thread-safe references" which conceptually act the same as `RBQSafeRealmObject` but support all types, including objects without primary keys, Realms, results, and lists:

1. Initialize a `ThreadSafeReference` with the thread-confined object.
2. Pass that `ThreadSafeReference` to a destination thread or queue.
3. Resolve this reference on the target Realm by calling `Realm.resolve(_:)`. Use the returned object as you normally would.

For example:

```swift
let realm = try! Realm()
let person = Person(name: "Jane") // no primary key required
try! realm.write {
  realm.add(person)
}
let personRef = ThreadSafeReference(to: person)
DispatchQueue(label: "com.example.myApp.bg").async {
  let realm = try! Realm()
  guard let person = realm.resolve(personRef) else {
    return // person was deleted
  }
  try! realm.write {
    person.name = "Jane Doe"
  }
}
```
See the release [blog post](https://realm.io/news/obj-c-swift-2-2-thread-safe-reference-sort-properties-relationships/) for more details.

---

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

