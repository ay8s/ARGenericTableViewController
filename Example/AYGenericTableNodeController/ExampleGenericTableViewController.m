//
//  ExampleGenericTableViewController.m
//  ARGenericTableView
//
//  Created by Jonas Stubenrauch on 04.04.13.
//  Copyright (c) 2013 arconsis IT-Solutions GmbH. All rights reserved.
//

#import "ExampleGenericTableViewController.h"

@implementation ExampleGenericTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.animateChanges = YES;

    AYTableNodeData *tableNodeData = [[AYTableNodeData alloc] initWithSectionDataArray:@[[self sampleSectionData]]];

    // add the section to the tableView
    [tableNodeData addSectionData:[self customCellSectionData]];

    // setting the tableViewData property will automaticaly reload the tableView
    self.tableNodeData = tableNodeData;
}

- (AYSectionData *)sampleSectionData
{
    // configure the section
    AYSectionData *sectionData = [[AYSectionData alloc] init];
    sectionData.headerTitle = @"Header";
    sectionData.footerTitle = @"Footer";


    // configure the cell
    for (int i = 0; i < 3; i++) {
        AYCellData *cellData = [[AYCellData alloc] init];
        cellData.editable = YES;

        [cellData setCellNodeBlock:^ASCellNode * _Nonnull{
            ASTextCellNode *cell = [[ASTextCellNode alloc] init];
            cell.text = [NSString stringWithFormat:@"Cell %d", i];
            return cell;
        }];
        
        [cellData setCellSelectionBlock:^(ASTableNode *tableNode, NSIndexPath *indexPath) {
            // called in didSelectRowAtIndexPath
            UIAlertView *alert = [[UIAlertView alloc] init];
            alert.title = [NSString stringWithFormat:@"Cell %d", i];
            [alert addButtonWithTitle:@"OK"];
            [alert show];
        }];

        [sectionData addCellData:cellData];
    }

    return sectionData;
}

- (AYSectionData *)customCellSectionData {
    // configure the section
    AYSectionData *sectionData = [[AYSectionData alloc] init];
    sectionData.headerTitle = @"Custom Cells";


    // configure the cell
    for (int i = 0; i < 4; i++) {
        AYCellData *cellData = [[AYCellData alloc] init];

        [cellData setCellNodeBlock:^ASCellNode * _Nonnull{
            ASTextCellNode *cell = [[ASTextCellNode alloc] init];
            cell.text = [NSString stringWithFormat:@"Cell %d", i];
            return cell;
        }];
        
        [cellData setCellSelectionBlock:^(ASTableNode *tableNode, NSIndexPath *indexPath) {
            // called in didSelectRowAtIndexPath
            UIAlertView *alert = [[UIAlertView alloc] init];
            alert.title = [NSString stringWithFormat:@"Custom Cell %d", i];
            [alert addButtonWithTitle:@"OK"];
            [alert show];
        }];

        [sectionData addCellData:cellData];
    }

    return sectionData;
}


@end
