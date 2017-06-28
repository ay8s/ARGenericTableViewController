/*
 * ARCellData.h
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

#import <Foundation/Foundation.h>
#import <AsyncDisplayKit/AsyncDisplayKit.h>

typedef void (^CellSelectionBlock_t)(ASTableNode *tableNode, NSIndexPath *indexPath);
typedef CGFloat (^CellDynamicHeightBlock_t)(UITableView *tableView, NSIndexPath *indexPath);
typedef void (^CellDeleteBlock_t)(UITableView *tableView, NSIndexPath *indexPath);
typedef void (^CellMoveBlock_t)(UITableView *tableView, NSIndexPath *fromIndexPath, NSIndexPath *toIndexPath);

@interface AYCellData : NSObject

@property (nonatomic, strong) ASCellNodeBlock cellNodeBlock;

// executed if the cell is selected
@property (nonatomic, strong) CellSelectionBlock_t cellSelectionBlock;

// edit the cell
@property (nonatomic) BOOL editable; // default is NO
@property (nonatomic) UITableViewCellEditingStyle editingStyle; // defailt is UITableViewCellEditingStyleDelete
@property (nonatomic, strong) CellDeleteBlock_t cellDeleteBlock;

// move the cell
@property (nonatomic) BOOL movable; // default is NO
@property (nonatomic, strong) CellMoveBlock_t cellMoveBlock;

@property (nonatomic, strong) id userInfo;

- (id)init;

- (void)setCellNodeBlock:(ASCellNodeBlock)cellNodeBlock;
- (void)setCellSelectionBlock:(CellSelectionBlock_t)cellSelectionBlock;
- (void)setCellDeleteBlock:(CellDeleteBlock_t)cellDeleteBlock;
- (void)setCellMoveBlock:(CellMoveBlock_t)cellMoveBlock;

@end
