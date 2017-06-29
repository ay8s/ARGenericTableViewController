/*
 * ARGenericTableViewController.m
 *
 * Copyright (c) 2013 arconsis IT-Solutions GmbH
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies
 * or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

#import "AYGenericTableNodeController.h"

@interface AYGenericTableNodeController ()
@property (nonatomic, strong) UIBarButtonItem *internalEditButtonItem;
@property (nonatomic, strong) NSMutableDictionary *tableViewCellClassDict;
@end

@implementation AYGenericTableNodeController

- (void)setup {
    self.animateChanges = NO;
    self.tableViewCellClassDict = [[NSMutableDictionary alloc] init];

}

- (id)initWithStyle:(UITableViewStyle)style {
    ASTableNode *tableNode = [[ASTableNode alloc] initWithStyle:style];
    if (!(self = [super initWithNode:tableNode]))
        return nil;
    
    self.tableNode = tableNode;
    self.tableNode.delegate = self;
    self.tableNode.dataSource = self;
    
    [self setup];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self setup];
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}

- (id)init {
    return [self initWithStyle:UITableViewStylePlain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)setTableNodeData:(AYTableNodeData *)tableNodeData {
    _tableNodeData = tableNodeData;
    self.tableNodeData.delegate = self;
    [self.tableNode reloadData];
}

#pragma mark - ASTableNodeDataSource

- (NSInteger)numberOfSectionsInTableNode:(ASTableNode *)tableNode {
    return self.tableNodeData.numberOfSections;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return [self.tableNodeData sectionDataForSection:section].cellCount;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.tableNodeData sectionDataForSection:section].headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [self.tableNodeData sectionDataForSection:section].footerTitle;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // Not supported right now
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AYCellData *cellData = [self.tableNodeData cellDataAtIndexPath:indexPath];
        
        if (cellData.cellDeleteBlock) {
            cellData.cellDeleteBlock(tableView,indexPath);
        }
        [self.tableNodeData removeCellDataAtIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    AYCellData *cellData = [self.tableNodeData cellDataAtIndexPath:indexPath];
    return cellData.editable || cellData.movable;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath {
    AYCellData *cellData = [self.tableNodeData cellDataAtIndexPath:indexPath];
    return cellData.cellNodeBlock;
}


#pragma mark - ASTableDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.tableNodeData sectionDataForSection:section].headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.tableNodeData sectionDataForSection:section].footerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    AYSectionData *data = [self.tableNodeData sectionDataForSection:section];
    if (data.headerIdentifier) {
        return [self.tableNode.view dequeueReusableHeaderFooterViewWithIdentifier:data.headerIdentifier];
    }
    return [self.tableNodeData sectionDataForSection:section].headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    AYSectionData *data = [self.tableNodeData sectionDataForSection:section];
    if (data.footerIdentifier) {
        return [self.tableNode.view dequeueReusableHeaderFooterViewWithIdentifier:data.footerIdentifier];
    }
    return [self.tableNodeData sectionDataForSection:section].footerView;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    AYCellData *cellData = [self.tableNodeData cellDataAtIndexPath:indexPath];
    return cellData.editable ? cellData.editingStyle : UITableViewCellEditingStyleNone;
}

- (void)tableNode:(ASTableNode *)tableNode didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AYCellData *cellData = [self.tableNodeData cellDataAtIndexPath:indexPath];
    
    [tableNode deselectRowAtIndexPath:indexPath animated:NO];
    
    if (cellData.cellSelectionBlock) {
        cellData.cellSelectionBlock(tableNode, indexPath);
    }
}

#pragma mark - Table view data delegate

- (void)tableNodeDataWillChange:(AYTableNodeData *)tableNodeData {
    if (self.animateChanges) {
        [self.tableNode.view beginUpdates];
    }
}

- (void)tableNodeData:(AYTableNodeData *)tableViewData didChangeSectionAtIndex:(NSUInteger)sectionIndex forChangeType:(TableViewDataChangeType)type newSectionIndex:(NSUInteger)newSectionIndex {
    if (!self.animateChanges) {
        return;
    }
    
    switch(type) {
        case TableViewDataChangeInsert: {
            [self.tableNode insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        case TableViewDataChangeDelete: {
            [self.tableNode deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        case TableViewDataChangeUpdate: {
            [self.tableNode reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        case TableViewDataChangeMove: {
            [self.tableNode moveSection:sectionIndex toSection:newSectionIndex];
            break;
        }
    }
}

- (void)tableNodeData:(AYTableNodeData *)tableNodeData didChangeRowAtIndexPath:(NSIndexPath *)indexPath forChangeType:(TableViewDataChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    if (!self.animateChanges) {
        return;
    }
    
    switch(type) {

        case TableViewDataChangeInsert: {
            [self.tableNode insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        case TableViewDataChangeDelete: {
            [self.tableNode deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        case TableViewDataChangeUpdate: {
            [self.tableNode reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        }
        case TableViewDataChangeMove: {
            [self.tableNode moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
        }
    }
}

- (void)tableNodeDataDidChange:(AYTableNodeData *)tableNodeData {
    if (self.animateChanges) {
        [self.tableNode.view endUpdates];
    } else {
        [self.tableNode reloadData];
    }
}
@end
