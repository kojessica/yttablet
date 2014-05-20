//
//  CategoryTableViewCell.h
//  yttablet
//
//  Created by Jessica Ko on 5/18/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *videoCount;
@property (weak, nonatomic) IBOutlet UILabel *nameCategory;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;

@end
