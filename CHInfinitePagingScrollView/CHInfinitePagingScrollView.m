//
//  CHInfinitePagingScrollView.m
//  InfinitePagingScrollViewDemo
//
//  Created by Cristi Habliuc on 09/01/14.
//  Copyright (c) 2014 Cristi Habliuc. All rights reserved.
//


#import "CHInfinitePagingScrollView.h"


@interface CHInfinitePagingScrollView () <UIScrollViewDelegate>

/*! This class is also taking control as its own delegate, so we'll be handling all methods and pass them on to the original delegate, if set */
@property (weak, nonatomic) id<UIScrollViewDelegate> forwardedDelegate;

/*! Where the dragging started, used to determine drag direction */
@property (nonatomic) CGFloat dragStartOffsetX;

/*! Set this to YES in order to temporarily disable scrolling events handling (use it in order to change the scroll view's offset without it triggering the infinite scrolling handling */
@property (nonatomic) BOOL disableScrollingHandling;

@end


@implementation CHInfinitePagingScrollView

#pragma mark - Object

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [super setDelegate:self];
        self.pagingEnabled = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [super setDelegate:self];
        self.pagingEnabled = YES;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [super setDelegate:self];
        self.pagingEnabled = YES;
    }
    return self;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.dragStartOffsetX = scrollView.contentOffset.x;
    
    if ([self.forwardedDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.forwardedDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.dragStartOffsetX = 0;

    if ([self.forwardedDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.forwardedDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.disableScrollingHandling) {
        CGFloat offsetX = scrollView.contentOffset.x;
        
        CGFloat minX = 0; // x-position of the first page
        CGFloat maxX = ([self.subviews count])*self.frame.size.width; // x-position of the last page
        CGFloat width = self.frame.size.width;
        
        UIView* firstView = self.subviews[0];
        CGRect frame = firstView.frame;
        
        if (self.dragging) {
            if (offsetX < width && offsetX >= 0 && frame.origin.x != minX) {
                frame.origin.x = minX;
                firstView.frame = frame;
            } else if (offsetX < 0) {
                frame.origin.x = maxX;
                firstView.frame = frame;
                self.disableScrollingHandling = YES;
                self.contentOffset = CGPointMake(maxX + (offsetX), 0);
                self.disableScrollingHandling = NO;
            } else if (offsetX > self.contentSize.width - width*2 && offsetX <= self.contentSize.width - width && frame.origin.x != maxX) {
                frame.origin.x = maxX;
                firstView.frame = frame;
            } else if (offsetX > self.contentSize.width - width) {
                frame.origin.x = minX;
                firstView.frame = frame;
                self.disableScrollingHandling = YES;
                self.contentOffset = CGPointMake(0 + (offsetX - (maxX)), 0);
                self.disableScrollingHandling = NO;
            }
            
        }
    }

    if ([self.forwardedDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.forwardedDelegate scrollViewDidScroll:scrollView];
    }
}

#pragma mark Forwarding the rest of the methods

/*
 
 A more reliable way to forward the rest of the delegate methods would be to create a proxy delegate which tests the selectors dynamically, but for this simple case I stayed to manually calling the rest of the methods to keep a single class in this scenario.
 
 */

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.forwardedDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.forwardedDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    if ([self.forwardedDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.forwardedDelegate scrollViewShouldScrollToTop:scrollView];
    }
    return NO;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    if ([self.forwardedDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.forwardedDelegate scrollViewDidScrollToTop:scrollView];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if ([self.forwardedDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.forwardedDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self.forwardedDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.forwardedDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if ([self.forwardedDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.forwardedDelegate viewForZoomingInScrollView:scrollView];
    }
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    if ([self.forwardedDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.forwardedDelegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if ([self.forwardedDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.forwardedDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if ([self.forwardedDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.forwardedDelegate scrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if ([self.forwardedDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.forwardedDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

#pragma mark - UIView

- (void)layoutSubviews
{
    // update the content size to be number of subviews + 1 (reserve a place for the first view when we'll switch it)
    self.contentSize = CGSizeMake(([self.subviews count]+1)*self.frame.size.width, self.frame.size.height);
    self.pagingEnabled = YES;
}

#pragma mark - Overrides

- (void)setDelegate:(id<UIScrollViewDelegate>)delegate
{
    // we're going to keep the scroll view's delegate as ourselves. We'll forward the invocations as needed after handling
    self.forwardedDelegate = delegate;
}

@end
