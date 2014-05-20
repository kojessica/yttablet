//
//  WatchTableViewCell.h
//  yttablet
//
//  Created by Jessica Ko on 5/15/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WatchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UIView *video;
@property (weak, nonatomic) IBOutlet UIImageView *screenshot;

@end
