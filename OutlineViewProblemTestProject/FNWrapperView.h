//
//  FNWrapperView.h
//  OutlineViewProblemTestProject
//
//  Created by Stefan Walkner on 17.09.13.
//  Copyright (c) 2013 fournova. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface FNWrapperView : NSView

@property (nonatomic, strong) NSView *documentView;
@property (nonatomic, strong) NSView *scrollView;

@end
