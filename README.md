RBQSafeRealmObject
===========================
#####Thread-Safe Representation Of A Realm Object
This class allows you to create a thread-safe representation of a given `RLMObject` subclass. For example, this enables performing queries on a background thread, and passing results as `RBQSafeRealmObject` to the main-thread for display. 

_**Note: It will only work with an `RLMObject` that has a primary key.**_

Both an Objective-C and Swift version are availble. Swift 2.0 support added in version 0.4.

####How To Use
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
Swift
```swift
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
    let anObject = Object()
    
    let safeObject = SafeObject(object: anObject)
    
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
        let mainThreadObject = safeObject.object()
    })
})
```

####Installation
RBQSafeRealmObject is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:
Objective-C
```
pod "RBQSafeRealmObject"
```
Swift
```
pod "SafeRealmObject"
```

