;
//
//  ADScrollView.m
//  DemoAdvertisement
//
//  Created by zhangshaoyu on 14-7-16.
//  Copyright (c) 2014年 zhangshaoyu. All rights reserved.
//

#import "ADScrollView.h"

@implementation ADScrollView

@synthesize delegate;
@synthesize imageSelected;

#pragma mark - 初始化方法
- (id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr TitleArray:(NSArray *)titArr
{
    if ((self = [super initWithFrame:rect]))
    {
        self.userInteractionEnabled = YES;
        
        if (titArr && 0 != titArr.count)
        {
            // 标题数组
            titleArray = titArr;
        }
        viewSize = rect;
        
        // 创建滚动广告栏
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, viewSize.size.width, viewSize.size.height)];
        [self addSubview:scrollView];
        [scrollView setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.1]];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        
        // 说明文字层
        noteView = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.bounds.size.height - 33.0,self.bounds.size.width,33.0)];
        [self addSubview:noteView];
        
        [noteView setBackgroundColor:UIColorHex_Alpha(0x000000, 0.6)];
        noteView.userInteractionEnabled = NO;
        
        // 标题
        noteTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 33.0)];
        [noteTitle setBackgroundColor:[UIColor clearColor]];
        [noteTitle setTextAlignment:NSTextAlignmentCenter];
        [noteTitle setTextColor:UIColorHex(0xdadada)];
        [noteTitle setFont:[UIFont systemFontOfSize:13.0]];
        [noteView addSubview:noteTitle];
        
        // 广告分页ceng
        pageControl = [[UIPageControl alloc] init];
        [self addSubview:pageControl];
        
        // 重置广告栏信息
        if (imgArr && 0 != imgArr.count)
        {
            [self resetScrollViewInfo:imgArr];
        }
        
        // 初始化计时器
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1*NSEC_PER_SEC, 0);
        kSelf;
        dispatch_source_set_event_handler(_timer, ^{
            [mySelf timerCallScroll];
        });
        dispatch_resume(_timer);
    }
	return self;
}

- (void)resetScrollViewInfo:(NSArray *)images
{
    // 图片数组 原数+2，前后各+1
    if (images.count <= 1) {//当只图片数小于1张时不能滑动
        scrollView.scrollEnabled = NO;
    }else{
        scrollView.scrollEnabled = YES;
    }
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:images];
    [tempArray insertObject:[images objectAtIndex:([images count] - 1)] atIndex:0]; // +1 首个为原最后一个
    [tempArray addObject:[images objectAtIndex:0]]; // +1 最后一个为原首个
    imageArray = [NSArray arrayWithArray:tempArray];
    pageCount = [imageArray count];
    
    // 创建滚动广告栏
    scrollView.contentSize = CGSizeMake(viewSize.size.width * pageCount, viewSize.size.height);
    for (int i = 0; i < pageCount; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] init];
        [scrollView addSubview:imgView];
        NSString *urlStr = [imageArray objectAtIndex:i];
        
        if ([urlStr hasPrefix:@"http://"])
        {
            // 网络图片 请使用ego异步图片库
            NSURL *imageUrl = [NSURL URLWithString:urlStr];
            [imgView setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"detail_advert_default"] completed:nil];
        }else{
            UIImage *img = [UIImage imageNamed:[imageArray objectAtIndex:i]];
            [imgView setImage:img];
        }
        
        [imgView setFrame:CGRectMake(viewSize.size.width * i, 0.0, viewSize.size.width, viewSize.size.height)];
        imgView.tag = 100 + i - 1;
        
        // 点击手势
        UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
        [Tap setNumberOfTapsRequired:1];
        [Tap setNumberOfTouchesRequired:1];
        imgView.userInteractionEnabled = YES;
        [imgView addGestureRecognizer:Tap];
    }
    
    [scrollView setContentOffset:CGPointMake(viewSize.size.width, 0.0)];
    
    // 页码控制器
    float pageControlWidth = (pageCount - 2) * 10.0f + 40.f;
    float pagecontrolHeight = 20.0f;
    pageControl.frame = CGRectMake((self.frame.size.width - pageControlWidth)/2, self.bounds.size.height - pagecontrolHeight, pageControlWidth, pagecontrolHeight);
    pageControl.currentPage = 0;
    pageControl.numberOfPages = (pageCount - 2);
    pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"advert_point_icon"]];
    pageControl.currentPageIndicatorTintColor = kColorRed;
//    pageControl.userInteractionEnabled = YES;
//    [pageControl addTarget:self action:@selector(scrollToPage:) forControlEvents:UIControlEventValueChanged];
    [self setPageControlShow];
    
    [self resetNoteTitle];
}

- (void)resetNoteTitle
{
    if (titleArray && 0 != titleArray.count)
    {
        [noteTitle setText:[titleArray objectAtIndex:0]];
    }
}

- (void)setPageControlFrame
{
    if (PageControlCenter == _pageControlMode)
    {
        float pageControlWidth = (pageCount - 2) * 10.0 + 40.;
        pageControl.frame = CGRectMake((self.frame.size.width - pageControlWidth) / 2, pageControl.frame.origin.y, pageControlWidth, pageControl.frame.size.height);
    }
    else if (PageControlRight == _pageControlMode)
    {
        float pageControlWidth = (pageCount - 2) * 10.0 + 40.;
        pageControl.frame = CGRectMake((self.frame.size.width - pageControlWidth), pageControl.frame.origin.y, pageControlWidth, pageControl.frame.size.height);
    }
}

- (void)setPageControlShow
{
    pageControl.hidden = !_showPageControl;
    pageControl.alpha = 1;//(_showPageControl ? 1.0 : 0.0);
}

//- (void)scrollToPage:(UIPageControl *)sender{
//    
//    NSInteger page = sender.currentPage;//获取当前pagecontroll的值
//    [scrollView setContentOffset:CGPointMake(kScreenWidth * page, 0)];//根据pagecontroll的值来改变scrollview的滚动位置，以此切换到指定的页面
//}

#pragma mark - set方法

- (void)setImageSources:(NSArray *)newimageSources
{
    if (newimageSources.count) {
        _imageSources = newimageSources;
    }else{
        return;
    }
    
    [self resetScrollViewInfo:_imageSources];
    
    if (_autoPlay)
    {
        [self autoPlayScroll];
    }
}

- (void)setTitleSources:(NSArray *)newtitleSources
{
    _titleSources = newtitleSources;
    
    titleArray = _titleSources;
    [self resetNoteTitle];
}

- (void)setPageControlMode:(PageControlMode)pagecontrolMode
{
    _pageControlMode = pagecontrolMode;
    [self setPageControlFrame];
}

- (void)setShowAlphaBground:(BOOL)showalphaBground
{
    _showAlphaBground = showalphaBground;
    noteView.hidden = !_showAlphaBground;
}

- (void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl = showPageControl;
    [self setPageControlShow];
}

- (void)setPageColor:(UIColor *)pageColor
{
    pageControl.pageIndicatorTintColor = pageColor;
}

-(void)setCurrentPageColor:(UIColor *)currentPageColor
{
    pageControl.currentPageIndicatorTintColor = currentPageColor;
}

- (void)setAutoPlay:(BOOL)newautoplay
{
    _autoPlay = newautoplay;
}

#pragma mark - 内存管理

- (void)dealloc
{

    if (scrollView)
    {
        scrollView = nil;
    }
    if (noteView)
    {
        noteView = nil;
    }
    if (noteTitle)
    {
        noteTitle = nil;
    }
    if (delegate)
    {
        delegate = nil;
    }
    if (pageControl)
    {
        pageControl = nil;
    }
    if (imageArray)
    {
        imageArray = nil;
    }
    if (titleArray)
    {
        titleArray=nil;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (imageArray && 0 != imageArray.count)
    {
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        currentPageIndex = page;
        
        pageControl.currentPage = (page - 1);
        int titleIndex = page - 1;
        if (titleIndex == [titleArray count])
        {
            titleIndex = 0;
        }
        
        if (titleIndex < 0)
        {
            titleIndex = [titleArray count] - 1;
        }
        
        [noteTitle setText:[titleArray objectAtIndex:titleIndex]];
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    if (imageArray && 0 != imageArray.count)
    {
        if (currentPageIndex == 0)
        {
            [_scrollView setContentOffset:CGPointMake(([imageArray count] - 2) * viewSize.size.width, 0.0)];
        }
        
        if (currentPageIndex == ([imageArray count] - 1))
        {
            [_scrollView setContentOffset:CGPointMake(viewSize.size.width, 0.0)];
        }
    }
}

#pragma mark - 手势点击

- (void)imagePressed:(UITapGestureRecognizer *)sender
{
    if ([delegate respondsToSelector:@selector(ADScrollerViewDidClicked:)])
    {
        [delegate ADScrollerViewDidClicked:sender.view.tag];
    }
    
    if (self.imageSelected)
    {
        self.imageSelected(sender, sender.view.tag - 100 >= 0 ? sender.view.tag - 100 : 0);
    }
}

#pragma mark - 自动播放

- (void)timerCallScroll
{
    kSelf;
    dispatch_async(dispatch_get_main_queue(), ^{
        [mySelf autoPlayScroll];
    });
}

- (void)autoPlayScroll
{
    if (!_isADNeedsPlay || imageArray.count == 1) {
        return;
    }
    
    if (imageArray && 0 != imageArray.count)
    {
        // 超出范围时，重置
        if (currentPageIndex == ([imageArray count] - 1))
        {
            currentPageIndex = 0;
            [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0.0)];
        }
        // 自动播放scroll
        [scrollView setContentOffset:CGPointMake(currentPageIndex * scrollView.frame.size.width, 0.0) animated:YES];
        
        // 设置页码 拼宝首页滚动广告，pageControl 会来回闪烁一次在定格，问题出在这里， 卜增彦 2014.12.15留 （设置当前页面所致）
//        pageControl.currentPage = (currentPageIndex - 1);
        
        // 设置标题
        int titleIndex = currentPageIndex - 1;
        if (titleIndex == [titleArray count])
        {
            titleIndex = 0;
        }
        if (titleIndex < 0)
        {
            titleIndex = [titleArray count] - 1;
        }
        [noteTitle setText:[titleArray objectAtIndex:titleIndex]];
        currentPageIndex++;
    }
}

#pragma mark - 播放与停止
/// 重新播放
- (void)startPlayAD
{
    /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _timer = [NSTimer scheduledTimerWithTimeInterval:2
                                                  target:self
                                                selector:@selector(timerCallScroll)
                                                userInfo:nil
                                                 repeats:YES] ;
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
     */
    _isADNeedsPlay = YES;
}

/// 停止播放
- (void)stopPlayAD
{
    /*
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
     */
    _isADNeedsPlay = NO;
}

@end
