//
//  CategoryViewController.m
//  yttablet
//
//  Created by Jessica Ko on 5/18/14.
//  Copyright (c) 2014 google. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryTableViewCell.h"
#import "BrowseViewController.h"
#import "UIView-JTViewToImage.h"

@interface CategoryViewController ()

@property (assign,nonatomic) BOOL isPresent;
@property (nonatomic, strong) NSMutableArray *thumbnails;
@property (nonatomic, strong) NSMutableArray *categories;
@property (assign,nonatomic) int selectedRow;

@end

@implementation CategoryViewController

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
    self.thumbnails = [NSMutableArray arrayWithObjects: @"video1.jpg",
                       @"video2.jpg",
                       @"video3.jpg",
                       @"video4.jpg",
                       @"video5.jpg",
                       @"video6.jpg",
                       @"video7.jpg",
                       @"video8.jpg",
                       @"video9.jpg",
                       @"video10.jpg",
                       @"video2.jpg",
                       @"video3.jpg",
                       nil];
    self.categories = [NSMutableArray arrayWithObjects: @"Recommended",
                       @"Watch it again",
                       @"Tastemade",
                       @"BeyonceVEVO",
                       @"Music",
                       @"Best of YouTube",
                       @"Jazz",
                       @"Foodies",
                       @"Comedy",
                       @"Entertainment",
                       nil];
    self.selectedRow = 0;
    self.categoryTable.delegate = self;
    [self.categoryTable registerNib:[UINib nibWithNibName:@"CategoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"CategoryTableViewCell"];
    [self.categoryTable reloadData];
    
    self.categoryTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.categoryTable.backgroundColor = [UIColor blackColor];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.categories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryTableViewCell *cell = (CategoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CategoryTableViewCell"];
    cell.nameCategory.text = [self.categories objectAtIndex:indexPath.row];
    cell.nameCategory.textColor = [UIColor whiteColor];
    cell.image1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [self.thumbnails objectAtIndex:indexPath.row]]];
    cell.image2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [self.thumbnails objectAtIndex:indexPath.row + 1]]];
    cell.image3.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [self.thumbnails objectAtIndex:indexPath.row + 2]]];
    cell.backgroundColor = [UIColor clearColor];
    UIView *selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [UIColor clearColor];
    selectedView.layer.borderColor = [[UIColor whiteColor] CGColor];
    selectedView.layer.borderWidth = 2.0f;
    cell.selectedBackgroundView =  selectedView;
    return cell;
}

- (void)viewDidAppear:(BOOL)animated {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.categoryTable selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSelectorOnMainThread:@selector(presentBrowseViewAtIndexPath:) withObject:indexPath waitUntilDone:NO];
}

- (void)presentBrowseViewAtIndexPath:(NSIndexPath *)indexPath {
    BrowseViewController *viewController = [[BrowseViewController alloc] init];
    viewController.transitioningDelegate = self;
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:viewController animated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enterCategory" object:nil userInfo:nil];
    self.selectedRow = (int)indexPath.row;
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
    return 0.0;
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
        toViewController.view.frame = CGRectMake(0, -150, sizeOfScreen.height, 280);

        UIImageView *fromView = [[UIImageView alloc] initWithFrame:CGRectMake(sizeOfScreen.width - 280, 0, 280, sizeOfScreen.height)];
        fromView.image = [self.view toImageWithScale:0 legacy:NO];
        [self.view addSubview:fromView];
        
        [UIView animateWithDuration:0.3 animations:^{
            toViewController.view.frame = CGRectMake(0, sizeOfScreen.width - 280, sizeOfScreen.height, 280);
            toViewController.view.alpha = 1;
            fromView.frame = CGRectMake(-280, 0, 280, sizeOfScreen.height);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
            [fromView removeFromSuperview];
        }];
    } else {
        fromViewController.view.frame = containerView.frame;
        [containerView addSubview:fromViewController.view];
        fromViewController.view.frame = CGRectMake(0, sizeOfScreen.width - 280,sizeOfScreen.height, 280);
        
        UIImageView *toView = [[UIImageView alloc] initWithFrame:CGRectMake(-280, 0, 280, sizeOfScreen.height)];
        toView.image = [self.view toImageWithScale:0 legacy:NO];
        [self.view addSubview:toView];

        [UIView animateWithDuration:0.3 animations:^{
            fromViewController.view.frame = CGRectMake(0, -280, sizeOfScreen.height, 280);
            toView.frame = CGRectMake(0, 0, 280, sizeOfScreen.height);
            [toView removeFromSuperview];
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

@end
