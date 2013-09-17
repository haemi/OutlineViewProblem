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

@interface FNAppDelegate ()

@property (nonatomic, strong) FNWrapperView *wrapperView;
@property (nonatomic, strong) NSOutlineView *outlineView;

@end

@implementation FNAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self createOutlineView];
}

- (void)createOutlineView {
    self.wrapperView = [[FNWrapperView alloc] initWithFrame:CGRectZero];
    
    self.outlineView = [[NSOutlineView alloc] initWithFrame:CGRectZero];
    self.outlineView.delegate = self;
    self.outlineView.dataSource = self;
    self.outlineView.translatesAutoresizingMaskIntoConstraints = NO;
    self.outlineView.backgroundColor = [NSColor whiteColor];
    
    self.scrollView.backgroundColor = [NSColor blueColor];
    
    self.wrapperView.documentView = self.documentView;
    self.wrapperView.scrollView = self.scrollView;
    
    NSTableColumn *tableColumn = [[NSTableColumn alloc] initWithIdentifier:@"tableColumn"];
    [tableColumn setEditable: NO];
    [self.outlineView addTableColumn:tableColumn];
    [self.outlineView setOutlineTableColumn:tableColumn];
    NSNib *diffChunkContentCellView = [[NSNib alloc] initWithNibNamed:[FNCellView className] bundle:nil];
    [self.outlineView registerNib:diffChunkContentCellView forIdentifier:@"FNCellView"];
    
    NSView *headerView = [[NSView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.documentView addSubview:headerView];
    [self.wrapperView addSubview:self.outlineView];
    [self.documentView addSubview:self.wrapperView];
    
    NSDictionary *views = @{@"outlineView": self.outlineView, @"wrapperView": self.wrapperView, @"documentView": self.documentView, @"headerView": headerView};
    NSMutableArray *constraints = [NSMutableArray new];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[wrapperView]|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerView]|" options:0 metrics:nil views:views]];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[headerView(50)]-10-[wrapperView(50)]" options:0 metrics:nil views:views];
    [constraints addObjectsFromArray:verticalConstraints];
    
    [self.documentView removeConstraints:self.documentView.constraints];
    [self.documentView addConstraints:constraints];
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
