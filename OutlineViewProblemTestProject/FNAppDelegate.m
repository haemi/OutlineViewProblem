//
//  FNAppDelegate.m
//  OutlineViewProblemTestProject
//
//  Created by Stefan Walkner on 17.09.13.
//  Copyright (c) 2013 fournova. All rights reserved.
//

#import "FNAppDelegate.h"
#import "FNWrapperView.h"
#import "FNCellView.h"
#import "CustomView.h"
#import "HeaderView.h"

@interface FNAppDelegate ()

@property (nonatomic, strong) FNWrapperView *wrapperView;
@property (nonatomic, strong) NSOutlineView *outlineView;

@property (nonatomic, strong) NSWindow *mainWindow;
@end

@implementation FNAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self createOutlineView];
}


- (void)createOutlineView {

    CustomView *customView = [[CustomView alloc] initWithFrame:[self.scrollView.documentView bounds]];
    self.scrollView.documentView = customView;
    
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:NSMakeRect(0,0,customView.frame.size.width,
                                                                          50)];
    
    [customView addSubview:headerView];
    
    self.outlineView = [[NSOutlineView alloc] initWithFrame:NSMakeRect(0,50,customView.frame.size.width,
                                                                       customView.frame.size.height)];
    NSTableColumn *outlineColumn = [[NSTableColumn alloc] initWithIdentifier:@"tableColumn"];
    [self.outlineView addTableColumn:outlineColumn];
    self.outlineView.outlineTableColumn = outlineColumn;
    self.outlineView.headerView = nil;
    self.outlineView.dataSource = self;
    self.outlineView.delegate = self;
    NSNib *diffChunkContentCellView = [[NSNib alloc] initWithNibNamed:[FNCellView className] bundle:nil];
    [self.outlineView registerNib:diffChunkContentCellView forIdentifier:@"FNCellView"];
    [customView addSubview:self.outlineView];
}

- (NSArray *)elements {
    return @[@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten"];
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    FNCellView *cellView = (FNCellView *) [outlineView makeViewWithIdentifier:@"FNCellView" owner:self];

    if ([item isKindOfClass:[NSString class]]) {
        [cellView.cellLabel setStringValue:item];
    }
    
    return cellView;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
    if (item == nil) {
        return self.elements[index];
    } else {
        return @1;
    }
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    return [item isKindOfClass:[NSString class]];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldShowOutlineCellForItem:(id)item {
    return YES;
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    if (item == nil) {
        return [self.elements count];
    } else if ([item isKindOfClass:[NSString class]]) {
        return 1;
    } else {
        return 0;
    }
}

- (CGFloat)outlineView:(NSOutlineView *)outlineView heightOfRowByItem:(id)item {
    if ([item isKindOfClass:[NSString class]]) {
        return 24;
    } else {
        return 400;
    }
}

- (void)outlineViewItemDidExpand:(NSNotification *)notification {
    [self.wrapperView setNeedsUpdateConstraints:YES];
}

- (void)outlineViewItemDidCollapse:(NSNotification *)notification {
    [self.wrapperView setNeedsUpdateConstraints:YES];
}
@end
