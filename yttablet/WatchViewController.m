//
//  WatchViewController.m
//  yttablet
//
//  Created by Jessica Ko on 5/14/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import "WatchViewController.h"
#import "XCDYouTubeVideoPlayerViewController.h"
#import "UIImage+ImageEffects.h"
#import <QuartzCore/QuartzCore.h>

@interface WatchViewController ()

@property CGFloat previousTableViewYOffset;
@property (nonatomic, assign) int cellIndex;
@property (nonatomic, strong) UITableView *tview;
@property (nonatomic, assign) int selectedRow;
@property (nonatomic, strong) XCDYouTubeVideoPlayerViewController *videoPlayerViewController;
@property (nonatomic, strong) NSArray *videos;
@property (nonatomic, strong) NSArray *metadata;
@property (nonatomic, strong) NSArray *thumbnails;
@property (nonatomic, strong) UILabel *videoMetadata;
@property (nonatomic, strong) UILabel *videoTitle;

@end

@implementation WatchViewController

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
    self.watchTable.delegate = self;
    [self.watchTable registerNib:[UINib nibWithNibName:@"WatchTableViewCell" bundle:nil] forCellReuseIdentifier:@"WatchTableViewCell"];
    self.watchTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.watchTable.allowsSelection = YES;
    self.selectedRow = 1;
    self.cellIndex = 0;
    self.view.userInteractionEnabled = YES;
    
    UISwipeGestureRecognizer* recognizerUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onScrollUp)];
    [recognizerUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:recognizerUp];

    UISwipeGestureRecognizer* recognizerDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onScrollDown)];
    [recognizerDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:recognizerDown];
    
    /*self.videos = [NSArray arrayWithObjects: @"3fL9RmVtMP0",
                   @"uuZ4cMOHBTk",
                   @"VSdsjxopGVQ",
                   @"Yj0l7iGKh8g",
                   @"jNTFfRVYazU",
                   @"q_MLi2wAfdM",
                   @"CiqzHzAx4ro",
                   @"BFcT1cCeGjY",
                   @"ynZTbgSIiL8",
                   @"d9lJh2tBk2s",
                   nil];*/
    self.videos = [NSArray arrayWithObjects: @"video1.jpg",
                   @"video2.jpg",
                   @"video3.jpg",
                   @"video4.jpg",
                   @"video5.jpg",
                   @"video6.jpg",
                   @"video7.jpg",
                   @"video8.jpg",
                   @"video9.jpg",
                   @"video10.jpg",
                   nil];
    self.metadata = [NSArray arrayWithObjects: @"5 Seconds of Summer - Don't stop",
                     @"When will the bass drop? (ft. Lil Jon)",
                     @"Intersteller Trailer Official Warner Bros.",
                     @"PewDiePie Reinvents Google Glass",
                     @"Realistic Mario: Yoshi",
                     @"How to Ask Out a Girl",
                     @"Arcade Fire - We Exist",
                     @"Michael Jackson, Justin Timberlake",
                     @"What The Heck is Gluten?",
                     @"How Do Rainbows Form?",
                     nil];
    
    [self.watchTable reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotifications:)
                                                 name:@"browseScrollStarts"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotifications:)
                                                 name:@"browseScrollEnds"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotifications:)
                                                 name:@"browseSelect"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotifications:)
                                                 name:@"enterCategory"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotifications:)
                                                 name:@"scrollUpFromMetadata"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotifications:)
                                                 name:@"scrollDownFromMetadata"
                                               object:nil];

}

- (void)viewDidAppear:(BOOL)animated {
    [self.watchTable setContentOffset:CGPointMake(0, 415*self.cellIndex + 230) animated:YES];
}

- (void)receiveNotifications:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"browseScrollStarts"])
    {
        //NSDictionary *userInfo = [notification userInfo];
        //int cellIndex = [[userInfo objectForKey:@"cellindex"] integerValue];
        //NSLog(@"asdfasdfasdfasdf: %i", cellIndex);
        //[self.watchTable setContentOffset:CGPointMake(0, 415*cellIndex + 230) animated:YES];
    }
    else if ([[notification name] isEqualToString:@"browseScrollEnds"])
    {
        //NSDictionary *userInfo = [notification userInfo];
        //int cellIndex = [[userInfo objectForKey:@"cellindex"] integerValue];
        //NSLog(@"asdfasdfasdfasdf: %i", cellIndex);
        //[self.watchTable setContentOffset:CGPointMake(0, 415*cellIndex + 230) animated:YES];
    }
    else if ([[notification name] isEqualToString:@"browseSelect"])
    {
        NSDictionary *userInfo = [notification userInfo];
        int cellIndex = [[userInfo objectForKey:@"cellindex"] integerValue] - 1;
        self.cellIndex = cellIndex;
        self.selectedRow = cellIndex + 1;
        [self.watchTable setContentOffset:CGPointMake(0, 415*cellIndex + 230) animated:YES];
        [self.watchTable reloadData];
    }
    else if ([[notification name] isEqualToString:@"enterCategory"]) {
        self.selectedRow = 1;
        self.cellIndex = 0;
        [self.watchTable setContentOffset:CGPointMake(0, 415*self.cellIndex + 230) animated:YES];
        [self.watchTable reloadData];
    }
    else if ([[notification name] isEqualToString:@"scrollUpFromMetadata"]) {
        [self onScrollUp];
    }
    else if ([[notification name] isEqualToString:@"scrollDownFromMetadata"]) {
        [self onScrollDown];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 415.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.videos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tview = tableView;
    
    WatchTableViewCell *cell = (WatchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"WatchTableViewCell"];
    //WatchTableViewCell *cell = [[WatchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.cellLabel.text = @"";
    cell.cellLabel.textColor = [UIColor whiteColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    
    UIView *selectedView = [[UIView alloc]init];
    cell.selectedBackgroundView =  selectedView;
    
    if (self.selectedRow == indexPath.row) {
        UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)];
        pinchRecognizer.delegate = self;
        [cell addGestureRecognizer:pinchRecognizer];
        
        cell.backgroundColor = [UIColor blackColor];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [self.videos objectAtIndex:indexPath.row]]];
        cell.screenshot.alpha = 0;
        
        UIImageView *blurredImage = [[UIImageView alloc] initWithFrame:cell.screenshot.frame];
        blurredImage.image = [image applyBlurWithRadius:15.f tintColor:[UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:0.5] saturationDeltaFactor:0.66 maskImage:nil];
        blurredImage.alpha = 0;
        self.videoTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 700, 500)];
        self.videoTitle.text = [self.metadata objectAtIndex:indexPath.row];
        self.videoTitle.font = [UIFont boldSystemFontOfSize:40.f];
        self.videoTitle.textColor = [UIColor whiteColor];
        
        self.videoMetadata = [[UILabel alloc] initWithFrame:CGRectMake(50, 45, 700, 500)];
        self.videoMetadata.text = @"by FoxVideos";
        self.videoMetadata.font = [UIFont boldSystemFontOfSize:20.f];
        self.videoMetadata.textColor = [UIColor whiteColor];
        self.videoMetadata.alpha = 0.6;
        
        [blurredImage addSubview:self.videoTitle];
        [blurredImage addSubview:self.videoMetadata];
        [cell addSubview:blurredImage];
        cell.screenshot.image = image;
        
        [UIView animateWithDuration:0.7 animations:^{
            blurredImage.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateKeyframesWithDuration:2.f delay:2.f options:UIViewKeyframeAnimationOptionBeginFromCurrentState animations:^{
                cell.screenshot.alpha = 1;
                blurredImage.alpha = 0;
            } completion:^(BOOL finished) {
                [blurredImage removeFromSuperview];
            }];
        }];
        
        
    } else {
        cell.backgroundColor = [UIColor blackColor];
        UIImage *originalImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [self.videos objectAtIndex:indexPath.row]]];
        cell.screenshot.alpha = 0;

        
        CGColorSpaceRef colorSapce = CGColorSpaceCreateDeviceGray();
        CGContextRef context = CGBitmapContextCreate(nil, originalImage.size.width, originalImage.size.height, 8, originalImage.size.width, colorSapce, kCGImageAlphaNone);
        CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
        CGContextSetShouldAntialias(context, NO);
        CGContextDrawImage(context, CGRectMake(0, 0, originalImage.size.width, originalImage.size.height), [originalImage CGImage]);
        
        CGImageRef bwImage = CGBitmapContextCreateImage(context);
        CGContextRelease(context);
        CGColorSpaceRelease(colorSapce);
        
        UIImage *resultImage = [UIImage imageWithCGImage:bwImage];
        CGImageRelease(bwImage);
        
        cell.screenshot.alpha = 0.2;
        cell.screenshot.image = resultImage;
    }
    
    return cell;
}

- (void)pinchDetected:(UIPinchGestureRecognizer *)pinchRecognizer
{
    CGFloat scale = pinchRecognizer.scale;
    if (scale > 1.1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"goFullScreen" object:nil userInfo:nil];
    } else if (scale < 0.95) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"exitFullScreen" object:nil userInfo:nil];
    }
}

- (UIView *)loadVideo
{
    UIView *videoWrapper = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 744, 415)];
    [videoWrapper.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger cellIndexAdj = self.cellIndex + 1;
    NSString *videoId = [self.videos objectAtIndex:cellIndexAdj];
    
    self.videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:videoId];
    [self.videoPlayerViewController.moviePlayer prepareToPlay];
    
    [self.videoPlayerViewController presentInView:videoWrapper];
    return videoWrapper;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self.watchTable reloadData];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //NSLog(@"Will begin dragging");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollSpeed = abs(scrollView.contentOffset.y - self.previousTableViewYOffset);
    self.previousTableViewYOffset = scrollView.contentOffset.y;
    if (scrollSpeed < 2) {
            CGFloat yOffset = self.cellIndex * 415 + 230;
            NSNumber *yOffsetNumber = [NSNumber numberWithFloat:yOffset];
            NSNumber *cellIndex = [NSNumber numberWithInt:self.cellIndex];
            
            NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
            [userInfo setObject:yOffsetNumber forKey:@"offset"];
            [userInfo setObject:cellIndex forKey:@"cellindex"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"watchScrollEnds" object:nil userInfo:userInfo];
        
            //AUTOSCROLL
            //[scrollView setContentOffset:CGPointMake(0, yOffset) animated:YES];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    self.cellIndex = floor(targetContentOffset->y / 415);
    self.selectedRow = self.cellIndex + 1;
    [self tableView:self.tview didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:(self.cellIndex + 1) inSection:0]];

    NSLog(@"%f", scrollView.contentOffset.y);
    NSLog(@"%d", self.cellIndex);
    NSNumber *cellIndex = [NSNumber numberWithInt:self.cellIndex];
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:cellIndex forKey:@"cellindex"];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"watchScrollStarts" object:nil userInfo:userInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onScrollUp
{
    [self.videoMetadata removeFromSuperview];
    [self.videoTitle removeFromSuperview];
    [self.view.layer removeAllAnimations];
    self.cellIndex++;
    self.selectedRow = self.cellIndex + 1;
    [self.watchTable setContentOffset:CGPointMake(0, 415*self.cellIndex + 230) animated:YES];
    
    [self.watchTable reloadData];
    
    NSNumber *cellIndex = [NSNumber numberWithInt:self.cellIndex];
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:cellIndex forKey:@"cellindex"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"watchScrollStarts" object:nil userInfo:userInfo];
}

- (IBAction)onScrollDown
{
    [self.videoMetadata removeFromSuperview];
    [self.videoTitle removeFromSuperview];
    [self.view.layer removeAllAnimations];
    self.cellIndex--;
    self.selectedRow = self.cellIndex + 1;
    [self.watchTable setContentOffset:CGPointMake(0, 415*self.cellIndex + 230) animated:YES];
    
    [self.watchTable reloadData];
    
    NSNumber *cellIndex = [NSNumber numberWithInt:self.cellIndex];
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:cellIndex forKey:@"cellindex"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"watchScrollStarts" object:nil userInfo:userInfo];
}

@end
