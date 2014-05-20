//
//  BrowseViewController.m
//  yttablet
//
//  Created by Jessica Ko on 5/14/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import "BrowseViewController.h"
#import "BrowseTableViewCell.h"
#import "MetadataViewController.h"

@interface BrowseViewController ()

@property CGFloat previousTableViewYOffset;
@property NSInteger cellIndex;
@property (nonatomic, strong) UITableView *bview;
@property (nonatomic, strong) NSArray *thumbnails;
@property (nonatomic, strong) NSArray *metadata;
@property (assign,nonatomic) BOOL isPresent;

@end

@implementation BrowseViewController

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
    self.browseTable.delegate = self;
    /*self.thumbnails = [NSArray arrayWithObjects: @"3fL9RmVtMP0",
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
    self.thumbnails = [NSArray arrayWithObjects: @"video1.jpg",
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
    
    self.selectionBox.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.selectionBox.layer.borderWidth = 2.0f;
    [self.selectionBox removeFromSuperview];
    
    [self.browseTable registerNib:[UINib nibWithNibName:@"BrowseTableViewCell" bundle:nil] forCellReuseIdentifier:@"BrowseTableViewCell"];
    [self.browseTable reloadData];
    self.browseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.browseTable.backgroundColor = [UIColor blackColor];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotifications:)
                                                 name:@"watchScrollStarts"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotifications:)
                                                 name:@"watchScrollEnds"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotifications:)
                                                 name:@"closeMetadata"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotifications:)
                                                 name:@"goFullScreen"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotifications:)
                                                 name:@"exitFullScreen"
                                               object:nil];

    self.cellIndex = 1;
    [self.browseTable setContentOffset:CGPointMake(0, 100*self.cellIndex + 43) animated:YES];
    UIView *topbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 2)];
    topbar.backgroundColor = [UIColor colorWithRed:219/225.f green:33/225.f blue:39/225.f alpha:1];
    [self.view addSubview:topbar];

}

- (void)viewDidAppear:(BOOL)animated {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.browseTable selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
}

- (void)receiveNotifications:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"watchScrollStarts"])
    {
        NSDictionary *userInfo = [notification userInfo];
        self.cellIndex = [[userInfo objectForKey:@"cellindex"] integerValue];
        //
        //self.selectionBox.layer.borderWidth = 2.0f;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.cellIndex+1) inSection:0];
        [self.browseTable selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionNone];
        [self.browseTable setContentOffset:CGPointMake(0, 100*self.cellIndex + 43) animated:YES];
    }
    else if ([[notification name] isEqualToString:@"watchScrollEnds"])
    {
        NSDictionary *userInfo = [notification userInfo];
        self.cellIndex = [[userInfo objectForKey:@"cellindex"] integerValue];
        [self.browseTable setContentOffset:CGPointMake(0, 100*self.cellIndex + 43) animated:YES];
    }
    else if ([[notification name] isEqualToString:@"goFullScreen"]) {
        [UIView animateWithDuration:0.7 animations:^{
            self.view.frame = CGRectMake(0, -280, self.view.bounds.size.height, 280);
        } completion:^(BOOL finished) {
        }];
    } else if ([[notification name] isEqualToString:@"exitFullScreen"]) {
        [UIView animateWithDuration:0.7 animations:^{
            self.view.frame = CGRectMake(0, 0, self.view.bounds.size.height, 280);
        } completion:^(BOOL finished) {
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.thumbnails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.bview = tableView;
    BrowseTableViewCell *cell = (BrowseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BrowseTableViewCell"];
    cell.cellLabel.text = [self.metadata objectAtIndex:indexPath.row];
    cell.cellLabel.numberOfLines = 0;
    cell.cellLabel.textColor = [UIColor whiteColor];
    cell.cellLabel.alpha = 0.8;
    cell.backgroundColor = [UIColor blackColor];
    
    /*NSString *thumbnailUrl = [NSString stringWithFormat:(@"https://i1.ytimg.com/vi/%@/default.jpg"), [self.thumbnails objectAtIndex:indexPath.row]];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:thumbnailUrl]];
    UIImage *image = [[UIImage alloc] initWithData:imageData];*/
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [self.thumbnails objectAtIndex:indexPath.row]]];
    cell.thumbnail.image = image;
    
    UIView *selectedView = [[UIView alloc]init];
    selectedView.layer.borderColor = [[UIColor whiteColor] CGColor];
    selectedView.layer.borderWidth = 2.0f;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView =  selectedView;
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"browse selected: %d", self.cellIndex == indexPath.row);
    if (indexPath.row > -1) {
        //self.selectionBox.layer.borderWidth = 2.0f;
        [self.browseTable setContentOffset:CGPointMake(0, 100*(indexPath.row-1) + 43) animated:YES];
        
        NSNumber *cellIndex = [NSNumber numberWithInt:indexPath.row];
        
        NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
        [userInfo setObject:cellIndex forKey:@"cellindex"];
        self.cellIndex = indexPath.row;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"browseSelect" object:nil userInfo:userInfo];
    }
    if (self.cellIndex == indexPath.row) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bringOutMetadata" object:nil userInfo:nil];
        MetadataViewController *viewController = [[MetadataViewController alloc] init];
        viewController.vtitle = [self.metadata objectAtIndex:self.cellIndex];
        viewController.transitioningDelegate = self;
        viewController.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"dragging");
    //self.selectionBox.layer.borderWidth = 0.0f;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPresent = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPresent = NO;
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGSize sizeOfScreen = self.view.bounds.size;
    
    if (self.isPresent) {
        toViewController.view.frame = containerView.frame;
        [containerView addSubview:toViewController.view];
        toViewController.view.alpha = 0.5;
        toViewController.view.frame = CGRectMake(2, -1024, sizeOfScreen.height, 1024);
        
        [UIView animateWithDuration:0.7 animations:^{
            toViewController.view.frame = CGRectMake(2, 0,sizeOfScreen.height, 1024);
            toViewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        fromViewController.view.frame = containerView.frame;
        [containerView addSubview:fromViewController.view];
        fromViewController.view.frame = CGRectMake(2, 0, sizeOfScreen.height, 1024);
        
        [UIView animateWithDuration:0.7 animations:^{
            fromViewController.view.frame = CGRectMake(2, -1024, sizeOfScreen.height, 1024);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeBrowseView:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)openMetadata:(UITapGestureRecognizer *)sender {
    
}

- (IBAction)onBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
