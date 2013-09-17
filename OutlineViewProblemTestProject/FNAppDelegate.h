//
//  FNAppDelegate.h
//  OutlineViewProblemTestProject
//
//  Created by Stefan Walkner on 17.09.13.
//  Copyright (c) 2013 fournova. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FNAppDelegate : NSObject <NSApplicationDelegate, NSOutlineViewDataSource, NSOutlineViewDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSScrollView *scrollView;
@property (assign) IBOutlet NSView *documentView;

@end
