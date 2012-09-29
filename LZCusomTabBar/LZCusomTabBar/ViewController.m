//
//  ViewController.m
//  LZCusomTabBar
//
//  Created by lin zheng on 9/18/12.
//  Copyright (c) 2012 yasofon. All rights reserved.
//

#import "ViewController.h"
#import "CustomTabBar.h"
#import "CustomTabBarItem.h"

@interface ViewController ()
@property (strong, nonatomic) CustomTabBar *tabBar;
@property (strong, nonatomic) NSArray *viewControllers;
@property (strong, nonatomic) NSArray *items;

- (void)addControllerViews;
@end

@implementation ViewController
@synthesize tabBar = _tabBar;
@synthesize viewControllers = _viewControllers;
@synthesize items = _items;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIViewController *discoverVC = [[UIViewController alloc] init];
    UINavigationController *discoverNav = [[UINavigationController alloc] initWithRootViewController:discoverVC];
    [discoverVC.view setBackgroundColor:[UIColor yellowColor]];
    [[discoverNav navigationBar] setBarStyle:UIBarStyleBlack];
    
    CustomTabBarItem  *discoverItem = [[CustomTabBarItem alloc]init];
    discoverItem.selectedImgStr = @"tab_bar_discover_selected.png";
    discoverItem.unSelectedImgStr = @"tab_bar_discover_unselected.png";
    discoverItem.width = 72.0;
    discoverItem.height = 40;
    
    UIViewController *profileVC = [[UIViewController alloc] init];
    UINavigationController *profileNav = [[UINavigationController alloc] initWithRootViewController:profileVC];
    [[profileNav navigationBar] setBarStyle:UIBarStyleBlack];
    [profileVC.view setBackgroundColor:[UIColor redColor]];
    
    CustomTabBarItem *profileItem = [[CustomTabBarItem alloc]init];
    profileItem.selectedImgStr = @"tab_bar_profile_selected.png";
    profileItem.unSelectedImgStr = @"tab_bar_profile_unselected.png";
    profileItem.width = 70.0;
    profileItem.height = 40.0;
    
    UIViewController *notificationsVC = [[UIViewController alloc] init];
    UINavigationController *notificationsNav = [[UINavigationController alloc] initWithRootViewController:notificationsVC];
    [notificationsVC.view setBackgroundColor:[UIColor greenColor]];
    
    CustomTabBarItem *notificationItem = [[CustomTabBarItem alloc]init];
    notificationItem.selectedImgStr = @"tab_bar_message_selected.png";
    notificationItem.unSelectedImgStr = @"tab_bar_message_unselected.png";
    notificationItem.width = 70.0;
    notificationItem.height = 60.0;
    
    UIViewController *mediaVC = [[UIViewController alloc] init];
    UINavigationController *mediaNav = [[UINavigationController alloc]
                                        initWithRootViewController:mediaVC];
    [mediaVC.view setBackgroundColor:[UIColor blueColor]];
    
    CustomTabBarItem *mediaItem = [[CustomTabBarItem alloc]init];
    mediaItem.selectedImgStr = @"tab_bar_media_selected.png";
    mediaItem.unSelectedImgStr = @"tab_bar_media_unselected.png";
    mediaItem.width = 108.0;
    mediaItem.height = 40.0;
    
    self.viewControllers = [NSArray arrayWithObjects:discoverNav,profileNav,notificationsNav,mediaNav, nil];
    NSArray *items = [NSArray arrayWithObjects:discoverItem,profileItem,notificationItem,mediaItem, nil];

    self.tabBar = [[CustomTabBar alloc]initIrigularBarWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0) backgroundImage:nil backgroundColor:[UIColor grayColor] items:items];
    self.tabBar.delegate = self;
    self.tabBar.frame = CGRectMake(0.0, self.view.frame.size.height - self.tabBar.frame.size.height, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
    [self addControllerViews];
    [self.view addSubview:self.tabBar];
    
    [self.tabBar setItemBadgeNum:19 atIndex:0];
    [self.tabBar setItemBadgeNum:119 atIndex:1];
    [self.tabBar setItemBadgeNum:9 atIndex:2];
    [self.tabBar setItemBadgeNum:0 atIndex:3];
    
    [self.tabBar selectItemAtIndex:1];
}

- (void)tabBar:(CustomTabBar *)tabBar selectedAtIndex:(NSUInteger)index
{
    UINavigationController *controller = (UINavigationController *)[self.viewControllers objectAtIndex:index];
    [self.view bringSubviewToFront:controller.view];
}

- (void)addControllerViews
{
    if (self.viewControllers != nil && [self.viewControllers count] > 0) {
        for (UIViewController *controller in self.viewControllers) {
            float height = self.view.frame.size.height - self.tabBar.frame.size.height;
            controller.view.frame = CGRectMake(0.0, 0.0, 320, height);
            [self.view addSubview:controller.view];
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
