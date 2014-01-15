//
//  CHTestViewController.m
//  InfinitePagingScrollViewDemo
//
//  Created by Cristi Habliuc on 15/01/14.
//  Copyright (c) 2014 Cristi Habliuc. All rights reserved.
//

#import "CHTestViewController.h"
#import "CHInfinitePagingScrollView.h"


@interface CHTestViewController () <UIScrollViewDelegate>

// Remember to also set the Class of this outlet to CHInfinitePagingScrollView as well in the Identity Inspector
@property (strong, nonatomic) IBOutlet CHInfinitePagingScrollView *scrollView;

@end

@implementation CHTestViewController

#pragma mark - UIScrollViewDelegate

// implement a bit of the UIScrollViewDelegate to illustrate that it still works as it should
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging: called in delegate");
}

#pragma mark - VC

- (UIView *)generateViewWithBackgroundColor:(UIColor *)color
{
    UIView* view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = color;
    return view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSMutableArray* views = [NSMutableArray array];
    
    {
        UIView* view = [self generateViewWithBackgroundColor:[UIColor redColor]];
        [views addObject:view];
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 20)];
        label.center = CGPointMake(self.scrollView.frame.size.width/2, self.scrollView.frame.size.height/2);
        label.text = @"First screen";
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
    }
    
    [views addObject:[self generateViewWithBackgroundColor:[UIColor blueColor]]];
    [views addObject:[self generateViewWithBackgroundColor:[UIColor greenColor]]];
    [views addObject:[self generateViewWithBackgroundColor:[UIColor yellowColor]]];
    [views addObject:[self generateViewWithBackgroundColor:[UIColor orangeColor]]];

    for (NSInteger i = 0; i < [views count]; i++) {
        UIView* view = views[i];
        view.frame = CGRectMake(i*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:view];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
