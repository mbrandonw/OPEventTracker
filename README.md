OPEventTracker
==============

A common adage of iOS development is to do as little as possible on the main thread so to not disrupt UI events. However, sometimes it is necessary to some work on the main thread and so we would prefer to do that work when the interface is mostly static (e.g. the user isn't dragging anything, scroll views aren't scrolling, etc...).

Now you can check at anytime if some kind of event tracking it taking place by doing:

``` objective-c
if ([[OPEventTracker sharedTracker] isTracking])
{
}
```

My favorite place to use this is when saving an `NSManagedObjectContext` on a background thread that will then merge into the context on the main thread. In particular, I wait until event tracking stops before doing the save, that way if the merge takes some time it will not be noticeable in the UI.

You can also observe these events using the notifications `OPEventTrackerNotifications.started` and `OPEventTrackerNotifications.stopped`, e.g.

``` objective-c
[[NSNotificationCenter defaultCenter] addObserver:self 
                                         selector:@selector(eventsStarted) 
                                            name:OPEventTrackerNotifications.started 
                                          object:nil];
```

##Installation

We love [CocoaPods](http://github.com/cocoapods/cocoapods), so we recommend you use it.

##Author

Brandon Williams  
[@mbrandonw](http://www.twitter.com/mbrandonw)  
[www.opetopic.com](http://www.opetopic.com)

## License

OPEventTracker is available under the MIT license. See the LICENSE file for more info.
