// OPEventTracker
//
// Copyright (c) 2012 Brandon Williams (http://www.opetopic.com)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "OPEventTracker.h"

const struct OPEventTrackerNotifications OPEventTrackerNotifications = {
	.started = @"OPEventTrackerNotificationStarted",
	.stopped = @"OPEventTrackerNotificationStopped",
};

@interface OPEventTracker (/**/)
@property (atomic, assign, readwrite, getter=isTracking) BOOL tracking;
@end

@implementation OPEventTracker

+(void) startTracking {
    [[self class] sharedTracker];
}

+(id) sharedTracker {
    static OPEventTracker *_sharedTracker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedTracker = [OPEventTracker new];
        [_sharedTracker eventTrackingStopped];
    });
    return _sharedTracker;
}

-(void) eventTrackingStarted {
    self.tracking = YES;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:OPEventTrackerNotifications.started object:nil];
        
        [[NSRunLoop mainRunLoop] performSelector:@selector(eventTrackingStopped)
                                          target:self
                                        argument:nil 
                                           order:0 
                                           modes:@[NSDefaultRunLoopMode]];
    });
}

-(void) eventTrackingStopped {
    self.tracking = NO;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:OPEventTrackerNotifications.stopped object:nil];
        
        [[NSRunLoop mainRunLoop] performSelector:@selector(eventTrackingStarted) 
                                          target:self
                                        argument:nil
                                           order:0
    #if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR
                                           modes:@[UITrackingRunLoopMode]
    #else
                                           modes:[NSArray arrayWithObjects:NSModalPanelRunLoopMode, NSEventTrackingRunLoopMode, nil]
    #endif
         ];
    });
}

@end