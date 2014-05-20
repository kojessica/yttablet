//
//  MetadataViewController.h
//  yttablet
//
//  Created by Jessica Ko on 5/18/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MetadataViewController : UIViewController <UIScrollViewDelegate>

- (IBAction)onClose:(id)sender;
- (IBAction)onSwipe:(UISwipeGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (strong, nonatomic) NSString *vtitle;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollv;
@property (weak, nonatomic) IBOutlet UIView *dummyView;

@end
