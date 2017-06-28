//
//  CustomCell.h
//  ARGenericTableView
//
//  Created by Jonas Stubenrauch on 04.04.13.
//  Copyright (c) 2013 arconsis IT-Solutions GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *customLabel;
@property (weak, nonatomic) IBOutlet UISwitch *customSwitch;

@end
