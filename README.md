RBQSafeRealmObject
===========================
#####Thread-Safe Representation Of A Realm Object
This class allows you to create a thread-safe representation of a given `RLMObject` subclass. For example, this enables performing queries on a background thread, and passing results as `RBQSafeRealmObject` to the main-thread for display. 

_**Note: It will only work with an `RLMObject` that has a primary key.**_

Both an Objective-C and Swift version are availble, but currently the Swift version requires Realm API access that will be in a future release (see this [PR for more details](https://github.com/realm/realm-cocoa/pull/2213)).

####How To Use
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

####Installation
RBQSafeRealmObject is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:
```
pod "RBQSafeRealmObject"
```

