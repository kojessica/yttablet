//
//  WatchTableViewCell.m
//  yttablet
//
//  Created by Jessica Ko on 5/15/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import "WatchTableViewCell.h"

@implementation WatchTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onPinch:(UIPinchGestureRecognizer *)sender {
    CGFloat scale = sender.scale;
    /*self.imageView.transform = CGAffineTransformScale(self.imageView.transform, scale, scale);
    sender.scale = 1.0;*/
    if (scale > 1) {
        NSLog(@"Pinched out");
    }
}

@end
