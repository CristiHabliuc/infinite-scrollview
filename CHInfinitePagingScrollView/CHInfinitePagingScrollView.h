//
//  CHInfinitePagingScrollView.h
//  InfinitePagingScrollViewDemo
//
//  Created by Cristi Habliuc on 09/01/14.
//  Copyright (c) 2014 Cristi Habliuc. All rights reserved.
//
//  This is a subclass of UIScrollView that behaves like an infinite paged scroll view.
//  Scrolling past the last page would basically bring in the first page and so on.
//
//  This is accomplished by making the subclass its own UIScrollViewDelegate and handling the necessary
//  methods in order to achieve this behaviour.
//  You can safely set a delegate for this subclass, which would have the scroll view callbacks forwarded
//  after being handled for this purpose first.


#import <UIKit/UIKit.h>


@interface CHInfinitePagingScrollView : UIScrollView

@end
