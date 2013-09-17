//
//  FNWrapperView.m
//  OutlineViewProblemTestProject
//
//  Created by Stefan Walkner on 17.09.13.
//  Copyright (c) 2013 fournova. All rights reserved.
//

#import "FNWrapperView.h"

@interface FNWrapperView ()

@property (nonatomic, strong) NSLayoutConstraint *widthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;

@end

@implementation FNWrapperView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
    
    NSLayoutConstraint *wrapperViewVerticalSizeConstraint;
    FNWrapperView *wrapperView = self;
    NSOutlineView *outlineView = (NSOutlineView *)wrapperView.subviews[0];
    
    for (NSLayoutConstraint *constraint in self.documentView.constraints) {
        if ([constraint.firstItem isKindOfClass:[FNWrapperView class]] && constraint.secondItem == nil) {
            wrapperViewVerticalSizeConstraint = constraint;
            break;
        }
    }
    
    NSRect oRect = [outlineView rectOfRow:([outlineView numberOfRows] - 1)]; //get rect of last row
    CGFloat n = oRect.origin.y + oRect.size.height;
    
    NSRect documentRect = self.documentView.frame;
    float height = MAX(240 + n, self.scrollView.frame.size.height);
    [self.documentView setFrame:NSMakeRect(documentRect.origin.x, documentRect.origin.y, documentRect.size.width, height)];
    
    wrapperViewVerticalSizeConstraint.constant = n;
    
    if (self.widthConstraint != nil) {
        [self.documentView removeConstraints:@[self.widthConstraint, self.heightConstraint]];
    }
    
    self.widthConstraint = [NSLayoutConstraint constraintWithItem:outlineView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:wrapperView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    self.heightConstraint = [NSLayoutConstraint constraintWithItem:outlineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:wrapperView attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    
    [self.documentView addConstraints:@[self.widthConstraint, self.heightConstraint]];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    CGContextRef context = (CGContextRef) [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSetRGBFillColor(context, 1, 0.651, 0.637, 1.0);
    CGContextFillRect(context, NSRectToCGRect(dirtyRect));
}

@end
