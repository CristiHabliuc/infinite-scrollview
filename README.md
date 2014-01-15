infinite-scrollview
===================

A clean, simple implementation of an infinite paging UIScrollView in a single subclass

Usage
-----

Drag and drop the CHInfinitePagingScrollView folder containing the source files into your project, and then use the subclass by instantiating it in code or using it in Interface Builder.

Code
----

```objc
CHInfinitePagingScrollView *scrollView = [[CHInfinitePagingScrollView alloc] initWithFrame:frame];
[self.view addSubview:scrollView];

// add subviews to it
// ...
```

Interface Builder
---

Add a scroll view to the target parent view, then go to the Identity Inspector and set the scroll view's class to `CHInfinitePagingScrollView`, then use it as you would a regular scroll view byt adding subviews to it in Interface Builder or in code. It will handle things from there.

