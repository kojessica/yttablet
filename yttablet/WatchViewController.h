//
//  WatchViewController.h
//  yttablet
//
//  Created by Jessica Ko on 5/14/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WatchTableViewCell.h"

@interface WatchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *watchTable;

@end
