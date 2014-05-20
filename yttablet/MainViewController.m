//
//  MainViewController.m
//  yttablet
//
//  Created by Jessica Ko on 5/14/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import "MainViewController.h"
#import "BrowseViewController.h"
#import "WatchViewController.h"
#import "MetadataViewController.h"
#import "CategoryViewController.h"
#import "UIView-JTViewToImage.h"

@interface MainViewController ()

@property (nonatomic, strong) UIView *videoContainerView;

@property (nonatomic, strong) CategoryViewController *browservc;
@property (nonatomic, strong) WatchViewController *watchvc;
@property (nonatomic, strong) UIView *browseview;
@property (nonatomic, strong) UIView *watchview;
@property (nonatomic, strong) UIImageView *snapshot;
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, assign) BOOL isFullScreen;

@end

@implementation MainViewController

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
    // Do any additional setup after loading the view from its nib.
    self.isFullScreen = NO;
    self.watchview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 744, self.view.bounds.size.height)];
    self.browseview = [[UIView alloc] initWithFrame:CGRectMake(744, 0, 280, self.view.bounds.size.height)];

    
    UIView *topbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 2)];
    topbar.backgroundColor = [UIColor colorWithRed:219/225.f green:33/225.f blue:39/225.f alpha:1];
    
    self.logo = [[UIImageView alloc] initWithFrame:CGRectMake(357, 13, 40, 26)];
    //logo.backgroundColor = [UIColor redColor];
    self.logo.image = [UIImage imageNamed:@"ylogo.png"];
    self.logo.alpha = 1.0f;

    self.browservc = [[CategoryViewController alloc] init];
    self.watchvc = [[WatchViewController alloc] init];
    
    self.watchvc.view.frame = self.watchview.bounds;
    self.browservc.view.frame = self.browseview.bounds;
    
    [self.watchview addSubview:self.watchvc.view];
    [self.browseview addSubview:self.browservc.view];
    
    
    [self.view addSubview:self.watchview];
    [self.view addSubview:self.browseview];
    
    [self.browservc didMoveToParentViewController:self];
    [self addChildViewController:self.browservc];
    
    [self.watchvc didMoveToParentViewController:self];
    [self addChildViewController:self.watchvc];
    
    [self.view bringSubviewToFront:self.watchview];
    [self.view addSubview:self.logo];
    [self.view addSubview:topbar];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotifications:)
                                                 name:@"bringOutMetadata"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotifications:)
                                                 name:@"goFullScreen"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotifications:)
                                                 name:@"exitFullScreen"
                                               object:nil];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)receiveNotifications:(NSNotification *)notification
{
   if ([[notification name] isEqualToString:@"goFullScreen"])
    {
        if (!self.isFullScreen) {
            UIImage *image = [self.view toImageWithScale:0 legacy:NO];
            //[self.view bringSubviewToFront:self.snapshot];
            self.snapshot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
            self.snapshot.image = image;
            [self.view addSubview:self.snapshot];
            
            [UIView animateWithDuration:0.7 animations:^{
                self.snapshot.frame = CGRectMake(0, -160, 1409.38, 1057);
            } completion:^(BOOL finished) {
            }];
            self.isFullScreen = YES;
        }

        /*UIView *dummyview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 744, self.view.bounds.size.height)];
        dummyview.userInteractionEnabled = YES;
        self.view.userInteractionEnabled = YES;
        
        UISwipeGestureRecognizer* recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(ontoNextVideo:)];
        recognizer.delegate = self;
        dummyview.backgroundColor = [UIColor redColor];
        [recognizer setDirection:UISwipeGestureRecognizerDirectionUp];
        [self.view addGestureRecognizer:recognizer];
        [self.view addSubview:dummyview];
        [self.view bringSubviewToFront:dummyview];
        NSLog(@"shucks");*/
    } else if ([[notification name] isEqualToString:@"exitFullScreen"]) {
        if (self.isFullScreen) {
            [UIView animateWithDuration:0.7 animations:^{
                self.snapshot.frame = CGRectMake(0, 0, 1024, self.view.bounds.size.height);
            } completion:^(BOOL finished) {
                [self.snapshot removeFromSuperview];
            }];
            self.isFullScreen = NO;
        }
    } else if ([[notification name] isEqualToString:@"bringOutMetadata"]) {
    }
}

- (void)ontoNextVideo:(UISwipeGestureRecognizer *)sender {
    NSLog(@"asdfasdfasdf");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
