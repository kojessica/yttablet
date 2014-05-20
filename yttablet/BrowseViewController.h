//
//  BrowseViewController.h
//  yttablet
//
//  Created by Jessica Ko on 5/14/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrowseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (weak, nonatomic) IBOutlet UITableView *browseTable;
@property (weak, nonatomic) IBOutlet UIView *selectionBox;
- (IBAction)openMetadata:(UITapGestureRecognizer *)sender;
- (IBAction)closeBrowseView:(UISwipeGestureRecognizer *)sender;
- (IBAction)onBackButton:(id)sender;

@end
