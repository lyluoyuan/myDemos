//
//  JYSlideSegmentController.m
//  JYSlideSegmentController
//
//  Created by Alvin on 14-3-16.
//  Copyright (c) 2014年 Alvin. All rights reserved.
//

#import "JYSlideSegmentController.h"
#import "UIColor+CrossFade.h"

#define SEGMENT_BAR_HEIGHT 38
#define INDICATOR_HEIGHT 3

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

NSString * const segmentBarItemID = @"JYSegmentBarItem";

@interface JYSegmentBarItem : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@end


@implementation JYSegmentBarItem

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self.contentView addSubview:self.titleLabel];
  }
  return self;
}

- (UILabel *)titleLabel
{
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
    _titleLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
      _titleLabel.textColor = UIColorFromRGB(0x999999);
      _titleLabel.tag = 100;
  }
  return _titleLabel;
}

@end

@interface JYSlideSegmentController ()
<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate> {
    CGFloat _lastContentOffset;
}

@property (nonatomic, strong, readwrite) UICollectionView *segmentBar;
@property (nonatomic, strong, readwrite) UIScrollView *slideView;
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;
@property (nonatomic, strong, readwrite) UIView *indicator;
@property (nonatomic, strong) UIView *indicatorBgView;

@property (nonatomic, strong) UICollectionViewFlowLayout *segmentBarLayout;

@property (nonatomic, assign) CGFloat leftRightPadding;
@property (nonatomic, assign) CGFloat totalWidth;

@property (nonatomic, copy) NSMutableArray *widthArray;

- (void)reset;

@end

@implementation JYSlideSegmentController
@synthesize viewControllers = _viewControllers;

- (instancetype)initWithViewControllers:(NSArray *)viewControllers
{
  self = [super init];
  if (self) {
    _viewControllers = [viewControllers copy];
    _selectedIndex = NSNotFound;
      _leftRightPadding = 10;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self setupSubviews];
  [self reset];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  CGSize conentSize = CGSizeMake(self.view.frame.size.width * self.viewControllers.count, 0);
  [self.slideView setContentSize:conentSize];
}

#pragma mark - Setup
- (void)setupSubviews
{
  // iOS7 set layout
  if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
  }
  [self.view addSubview:self.segmentBar];
  [self.view addSubview:self.slideView];
  [self.segmentBar registerClass:[JYSegmentBarItem class] forCellWithReuseIdentifier:segmentBarItemID];
  [self.segmentBar addSubview:self.indicatorBgView];
}

#pragma mark - Property
- (UIScrollView *)slideView
{
  if (!_slideView) {
    CGRect frame = self.view.bounds;
    frame.size.height -= _segmentBar.frame.size.height;
    frame.origin.y = CGRectGetMaxY(_segmentBar.frame);
    _slideView = [[UIScrollView alloc] initWithFrame:frame];
    [_slideView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth
                                     | UIViewAutoresizingFlexibleHeight)];
    [_slideView setShowsHorizontalScrollIndicator:NO];
    [_slideView setShowsVerticalScrollIndicator:NO];
    [_slideView setPagingEnabled:YES];
    [_slideView setBounces:NO];
    [_slideView setDelegate:self];
  }
  return _slideView;
}

- (UICollectionView *)segmentBar
{
  if (!_segmentBar) {
    CGRect frame = self.view.bounds;
    frame.size.height = SEGMENT_BAR_HEIGHT;
    _segmentBar = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:self.segmentBarLayout];
      _segmentBar.backgroundColor = _bgTabColor == nil ? [UIColor whiteColor] : _bgTabColor;
    _segmentBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _segmentBar.delegate = self;
    _segmentBar.dataSource = self;
      _segmentBar.showsHorizontalScrollIndicator = NO;
//    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, _totalWidth, 1)];
//    [separator setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
//    [separator setBackgroundColor:UIColorFromRGB(0xaaaaaa)];
//    [_segmentBar addSubview:separator];
  }
  return _segmentBar;
}

- (UIView *)indicatorBgView
{
  if (!_indicatorBgView) {
    CGRect frame = CGRectMake(0, self.segmentBar.frame.size.height - INDICATOR_HEIGHT,
                              self.view.frame.size.width, INDICATOR_HEIGHT);
    _indicatorBgView = [[UIView alloc] initWithFrame:frame];
    _indicatorBgView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    _indicatorBgView.backgroundColor = [UIColor clearColor];
    [_indicatorBgView addSubview:self.indicator];
  }
  return _indicatorBgView;
}

- (UIView *)indicator
{
  if (!_indicator) {
      int count = self.viewControllers == nil ? 1 : self.viewControllers.count;
    CGFloat width = self.view.frame.size.width / count - self.indicatorInsets.left - self.indicatorInsets.right;
    CGRect frame = CGRectMake(self.indicatorInsets.left, 0, width, INDICATOR_HEIGHT);
    _indicator = [[UIView alloc] initWithFrame:frame];
    _indicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
      _indicator.backgroundColor = self.indicatorColor == nil ? [UIColor greenColor] : self.indicatorColor;
  }
  return _indicator;
}

- (void)setIndicatorInsets:(UIEdgeInsets)indicatorInsets
{
  _indicatorInsets = indicatorInsets;
  CGRect frame = _indicator.frame;
  frame.origin.x = _indicatorInsets.left;
  CGFloat width = self.view.frame.size.width / self.viewControllers.count - _indicatorInsets.left - _indicatorInsets.right;
  frame.size.width = width;
    frame.size.height = INDICATOR_HEIGHT;
  _indicator.frame = frame;
}

- (UICollectionViewFlowLayout *)segmentBarLayout
{
  if (!_segmentBarLayout) {
    _segmentBarLayout = [[UICollectionViewFlowLayout alloc] init];
    _segmentBarLayout.itemSize = CGSizeMake(self.view.frame.size.width / self.viewControllers.count, SEGMENT_BAR_HEIGHT);
    _segmentBarLayout.sectionInset = UIEdgeInsetsZero;
    _segmentBarLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _segmentBarLayout.minimumLineSpacing = 0;
    _segmentBarLayout.minimumInteritemSpacing = 0;
  }
  return _segmentBarLayout;
}

- (void)setupViewControllers {
//    CGRect rect = self.slideView.bounds;
    _widthArray = [NSMutableArray new];
    _totalWidth = 0;
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
//        [self addChildViewController:viewController];
//        [viewController willMoveToParentViewController:self];
//        [self.slideView addSubview:viewController.view];
//        CGRect rect = self.slideView.bounds;
//        viewController.view.frame = CGRectMake(idx * rect.size.width, 0, rect.size.width, rect.size.height);
//        [viewController didMoveToParentViewController:self];
        
        UILabel * label = [[UILabel alloc] init];
        [label setTranslatesAutoresizingMaskIntoConstraints:NO];
//            label.font = self.buttonBarView.labelFont;
        label.font = [label.font fontWithSize:_maxFontSize];
        [label setText:viewController.title];
//        [label sizeToFit];
        CGFloat width = [label intrinsicContentSize].width + _leftRightPadding*2;
        _totalWidth += width;
        [_widthArray addObject:@(width)];
    }];
    if(_totalWidth < self.view.frame.size.width) {
        CGFloat paddingAdd = (self.view.frame.size.width - _totalWidth) / (self.viewControllers.count);
        for (int i = 0; i < _widthArray.count; i++) {
            _widthArray[i] = @([_widthArray[i] floatValue]+ paddingAdd);
        }
        _totalWidth = self.view.frame.size.width;
    }
    CGSize conentSize = CGSizeMake(self.view.frame.size.width * self.viewControllers.count, 0);
    [self.slideView setContentSize:conentSize];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_widthArray != nil && _indicator != nil && _widthArray.count > selectedIndex) {
        CGRect frame = _indicator.frame;
        frame.size.width = [_widthArray[selectedIndex] floatValue];
        [_indicator setFrame:frame];
    }
  if (_selectedIndex == selectedIndex || self.viewControllers == nil) {
    return;
  }

  NSParameterAssert(selectedIndex >= 0 && selectedIndex < self.viewControllers.count);

  UIViewController *toSelectController = [self.viewControllers objectAtIndex:selectedIndex];

  // Add selected view controller as child view controller
  if (!toSelectController.parentViewController) {
    [self addChildViewController:toSelectController];
    CGRect rect = self.slideView.bounds;
    rect.origin.x = rect.size.width * selectedIndex;
    toSelectController.view.frame = rect;
    [toSelectController willMoveToParentViewController:self];
    [self.slideView addSubview:toSelectController.view];
    [toSelectController didMoveToParentViewController:self];
  }
  _selectedIndex = selectedIndex;
    
    [_segmentBar scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.segmentBar reloadData];
}

- (void)setViewControllers:(NSArray *)viewControllers
{
  // Need remove previous viewControllers
  for (UIViewController *vc in _viewControllers) {
    [vc removeFromParentViewController];
  }
  _viewControllers = [viewControllers copy];
  [self reset];
}

- (NSArray *)viewControllers
{
  return [_viewControllers copy];
}

- (UIViewController *)selectedViewController
{
  return self.viewControllers[self.selectedIndex];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  if ([_dataSource respondsToSelector:@selector(numberOfSectionsInslideSegment:)]) {
    return [_dataSource numberOfSectionsInslideSegment:collectionView];
  }
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  if ([_dataSource respondsToSelector:@selector(slideSegment:numberOfItemsInSection:)]) {
    return [_dataSource slideSegment:collectionView numberOfItemsInSection:section];
  }
  return self.viewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  if ([_dataSource respondsToSelector:@selector(slideSegment:cellForItemAtIndexPath:)]) {
    return [_dataSource slideSegment:collectionView cellForItemAtIndexPath:indexPath];
  }

  JYSegmentBarItem *segmentBarItem = [collectionView dequeueReusableCellWithReuseIdentifier:segmentBarItemID
                                                                                forIndexPath:indexPath];
    
  UIViewController *vc = self.viewControllers[indexPath.row];
  segmentBarItem.titleLabel.text = vc.title;
    segmentBarItem.backgroundColor = _bgTabColor == nil ? [UIColor clearColor] : _bgTabColor;
//    segmentBarItem.backgroundColor = [UIColor clearColor];
    if(self.indicatorColor != nil) {
        if(indexPath.row == _selectedIndex) {
            segmentBarItem.titleLabel.textColor = _titleColorSelected == nil ? self.indicatorColor : _titleColorSelected;
            if(_maxFontSize > 0) {
                segmentBarItem.titleLabel.font = [segmentBarItem.titleLabel.font fontWithSize:_maxFontSize];
            }
        } else {
            segmentBarItem.titleLabel.textColor = _titleColorNormal == nil ? UIColorFromRGB(0x999999) : _titleColorNormal;
            if(_minFontSize > 0) {
                segmentBarItem.titleLabel.font = [segmentBarItem.titleLabel.font fontWithSize:_minFontSize];
            }
        }
    }
    
  return segmentBarItem;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row < 0 || indexPath.row >= self.viewControllers.count) {
    return;
  }

  UIViewController *vc = self.viewControllers[indexPath.row];
  if ([_delegate respondsToSelector:@selector(slideSegment:didSelectedViewController:)]) {
    [_delegate slideSegment:collectionView didSelectedViewController:vc];
  }
  [self setSelectedIndex:indexPath.row];
  [self scrollToViewWithIndex:self.selectedIndex animated:YES];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row < 0 || indexPath.row >= self.viewControllers.count) {
    return NO;
  }

  BOOL flag = YES;
  UIViewController *vc = self.viewControllers[indexPath.row];
  if ([_delegate respondsToSelector:@selector(slideSegment:shouldSelectViewController:)]) {
    flag = [_delegate slideSegment:collectionView shouldSelectViewController:vc];
  }
  return flag;
}

#pragma merk - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UILabel * label = [[UILabel alloc] init];
//    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
////    label.font = self.buttonBarView.labelFont;
//    UIViewController *vc = self.viewControllers[indexPath.row];
//    [label setText:vc.title];
//    CGSize labelSize = [label intrinsicContentSize];
    
    return CGSizeMake([_widthArray[indexPath.row] floatValue], collectionView.frame.size.height);
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  if (scrollView == self.slideView) {
    // set indicator frame
    
      CGFloat ratio = abs((int)(scrollView.contentOffset.x - _selectedIndex*scrollView.frame.size.width))/scrollView.frame.size.width;
      int step = (int)ratio;
      int current = scrollView.contentOffset.x - _selectedIndex*scrollView.frame.size.width > 0 ? MIN(_viewControllers.count-1, _selectedIndex+step) : MAX(0, _selectedIndex-step);
      int nextIndex = scrollView.contentOffset.x - _selectedIndex*scrollView.frame.size.width > 0 ? MIN(_viewControllers.count-1, _selectedIndex+1+step) : MAX(0, _selectedIndex-1-step);
      ratio = ratio - step;
      
      CGFloat left = 0;
      for (int i =0 ; i < current; i++) {
          left += [_widthArray[i] floatValue];
      }
      
      CGFloat currentWidth = [_widthArray[current] floatValue];
      CGFloat nextWidth = [_widthArray[nextIndex] floatValue];
      CGRect frame = self.indicator.frame;
      
      frame.origin.x = MAX(0, left + ratio* (scrollView.contentOffset.x - _selectedIndex*scrollView.frame.size.width > 0 ? currentWidth : -nextWidth));
      frame.size.width = currentWidth + (nextWidth - currentWidth)*ratio;
      self.indicator.frame = frame;
      
      
      if(_titleColorSelected!=nil && _titleColorNormal!=nil && _minFontSize > 0 && _maxFontSize > 0) {
          if(current == nextIndex) return;
          UICollectionViewCell* cell = [_segmentBar cellForItemAtIndexPath:[NSIndexPath indexPathForRow:nextIndex inSection:0]];
          UIView* v = [cell viewWithTag:100];
          if(v != nil) {
              UILabel* label = (UILabel*)v;
              label.textColor = [UIColor colorForFadeBetweenFirstColor:_titleColorNormal secondColor:_titleColorSelected atRatio:ratio];
              label.font = [label.font fontWithSize:_minFontSize + (_maxFontSize - _minFontSize)*ratio];
          }
          cell = [_segmentBar cellForItemAtIndexPath:[NSIndexPath indexPathForRow:current inSection:0]];
          v = [cell viewWithTag:100];
          if(v != nil) {
              UILabel* label = (UILabel*)v;
              label.textColor = [UIColor colorForFadeBetweenFirstColor:_titleColorSelected secondColor:_titleColorNormal atRatio:ratio];
              label.font = [label.font fontWithSize:_maxFontSize - (_maxFontSize - _minFontSize)*ratio];
          }
      }
    
//    if (index >= 0 && index < self.viewControllers.count) {
//      [self setSelectedIndex:index];
//    }
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self stoppedScrolling:scrollView];
//    CGFloat percent = scrollView.contentOffset.x / scrollView.contentSize.width;
//    NSInteger index = ceilf(percent * self.viewControllers.count);
//    UICollectionViewCell* cell = [_segmentBar cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//    UIView* v = [cell viewWithTag:100];
//    if(v != nil) {
//        [UIView animateWithDuration:0.2 animations:^{
//            ((UILabel*)v).textColor = _titleColorSelected;
//        }];
//    }
//    cell = [_segmentBar cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0]];
//    UIView* v1 = [cell viewWithTag:100];
//    if(v1 != nil) {
//        ((UILabel*)v1).textColor = _titleColorNormal;
//    }
//    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self stoppedScrolling:scrollView];
    }
}

- (void)stoppedScrolling:(UIScrollView*)scrollView
{
    // done, do whatever
    CGFloat percent = scrollView.contentOffset.x / scrollView.contentSize.width;
    NSInteger index = ceilf(percent * self.viewControllers.count);
    if (index >= 0 && index < self.viewControllers.count) {
        [self setSelectedIndex:index];
    }
}

#pragma mark - Action
- (void)scrollToViewWithIndex:(NSInteger)index animated:(BOOL)animated
{
  CGRect rect = self.slideView.bounds;
  rect.origin.x = rect.size.width * index;
  [self.slideView setContentOffset:CGPointMake(rect.origin.x, rect.origin.y) animated:animated];
}

- (void)reset
{
    [self setupViewControllers];
    _selectedIndex = NSNotFound;
    _indicator.backgroundColor = self.indicatorColor == nil ? [UIColor greenColor] : self.indicatorColor;
  [self setSelectedIndex:0];
    [self scrollToViewWithIndex:0 animated:NO];
    
  [self.segmentBar reloadData];
}

- (void) reloadViewControllers:(NSArray*)viewControllers {
    _viewControllers = [viewControllers copy];
    _leftRightPadding = 10;
    [self reset];
}

@end
