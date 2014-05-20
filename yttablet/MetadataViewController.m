//
//  MetadataViewController.m
//  yttablet
//
//  Created by Jessica Ko on 5/18/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import "MetadataViewController.h"

@interface MetadataViewController ()

@end

@implementation MetadataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.videoTitle.text = self.vtitle;
    self.scrollv.delegate = self;
    self.scrollv.contentSize = CGSizeMake(280, 500);
    
    UISwipeGestureRecognizer* recognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onScrollUp:)];
    [recognizerUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.dummyView addGestureRecognizer:recognizerUp];
    
    UISwipeGestureRecognizer* recognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onScrollDown:)];
    [recognizerDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.dummyView addGestureRecognizer:recognizerDown];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)];
    [self.dummyView addGestureRecognizer:pinchRecognizer];

}

- (IBAction)onScrollUp:(UISwipeGestureRecognizer *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeMetadata" object:nil userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollUpFromMetadata" object:nil userInfo:nil];
}

- (IBAction)onScrollDown:(UISwipeGestureRecognizer *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeMetadata" object:nil userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollDownFromMetadata" object:nil userInfo:nil];
}

- (void)pinchDetected:(UIPinchGestureRecognizer *)pinchRecognizer
{
    CGFloat scale = pinchRecognizer.scale;
    if (scale > 1.1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"goFullScreen" object:nil userInfo:nil];
        [UIView animateWithDuration:1.5 animations:^{
            self.scrollv.frame = CGRectMake(self.view.bounds.size.width + 280, 0, 280, self.view.bounds.size.height);
        } completion:^(BOOL finished) {
        }];
    } else if (scale < 0.95) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"exitFullScreen" object:nil userInfo:nil];
        [UIView animateWithDuration:0.4 animations:^{
            self.scrollv.frame = CGRectMake(self.view.bounds.size.width - 280, 0, 280, self.view.bounds.size.height);
        } completion:^(BOOL finished) {
        }];

    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.scrollv setContentSize:CGSizeMake(280, 500)];
}

- (void)viewDidLayoutSubviews
{
    [self.scrollv setContentSize:CGSizeMake(280, 500)];
}

- (void)viewWillLayoutSubviews
{
    [self.scrollv setContentSize:CGSizeMake(280, 500)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClose:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeMetadata" object:nil userInfo:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onSwipe:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
