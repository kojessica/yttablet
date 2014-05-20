//
//  CategoryViewController.h
//  yttablet
//
//  Created by Jessica Ko on 5/18/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property (weak, nonatomic) IBOutlet UITableView *categoryTable;

@end
