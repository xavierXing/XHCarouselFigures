//
//  CarouselFigure.m
//  XHCarouselFigure
//
//  Created by 邢浩 on 2016/12/27.
//  Copyright © 2016年 邢浩. All rights reserved.
//

#define width self.bounds.size.width
#define height self.bounds.size.height

#import "CarouselFigure.h"
#import "XHPageControlView.h"
@interface CarouselFigure ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView * CarouselFigureScrollow;/**轮播图*/
@property(nonatomic, strong)XHPageControlView * pageControlView;/**圆点图*/
@property(nonatomic, strong)NSTimer * CarouselFigureTimer;/**轮播图计时器*/

@end

static const NSInteger imageBtnCount = 3;/**轮播图-3张图作为基本轮播概念*/

@implementation CarouselFigure
#pragma mark -此界面消失时将变量||控件至为nil
- (void)dealloc {
    _CarouselFigureTimer = nil;
    _pageControlView = nil;
    _CarouselFigureScrollow = nil;
    [self closeTimer];
}

#pragma mark -override
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _CarouselFigureScrollow.frame = self.bounds;
    _CarouselFigureScrollow.contentSize = CGSizeMake(width * imageBtnCount, height);
    for (int i = 0; i < imageBtnCount; i++) {
        UIButton * imageBtn = _CarouselFigureScrollow.subviews[i];
        [imageBtn addTarget:self action:@selector(btnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        imageBtn.frame = CGRectMake(i * width, 0, width, height);
    }
    _CarouselFigureScrollow.contentOffset = CGPointMake(width, 0);
    _pageControlView.frame = CGRectMake(width / 2 - 50, height - 25, 100, 20);
}
#pragma mark -private targets
- (void)addSubviews {
    [self addSubview:self.CarouselFigureScrollow];
    [self addSubview:self.pageControlView];
}
- (void)setImgaeContent {/**设置图片内容*/
    for (int i = 0; i < imageBtnCount; i++) {
        UIButton * imageBtn = _CarouselFigureScrollow.subviews[i];
        NSInteger index = _pageControlView.currentPage;
        
        if (i == 0) {
            index--;
        } else if (i == 2) {
            index++;
        }
        
        if (index < 0) {
            index = _pageControlView.numberOfPages - 1;
        } else if (index == _pageControlView.numberOfPages) {
            index = 0;
        }
        imageBtn.tag = index;
        [imageBtn setBackgroundImage:self.images[index] forState:UIControlStateNormal];
        [imageBtn setBackgroundImage:self.images[index] forState:UIControlStateHighlighted];
    }
}
- (void)startTimer {/**开启定时器*/
    [[NSRunLoop mainRunLoop]addTimer:self.CarouselFigureTimer forMode:NSRunLoopCommonModes];
}
- (void)closeTimer {/**关闭定时器*/
    [_CarouselFigureTimer invalidate];
    _CarouselFigureTimer = nil;
}
- (void)recoverTimer {/**恢复定时器*/
    [_CarouselFigureTimer setFireDate:[NSDate distantPast]];
}
- (void)stopTimer {/**暂停定时器*/
    [_CarouselFigureTimer setFireDate:[NSDate distantFuture]];
}

- (void)updateImageContent {
    [self setImgaeContent];
    _CarouselFigureScrollow.contentOffset = CGPointMake(width, 0);
}
#pragma mark -按钮 targets
- (void)btnClickEvent:(id)sender {
    if (self.cfDelegate &&
        [self.cfDelegate conformsToProtocol:@protocol(CarouselFigureDelegate)] &&
        [self.cfDelegate respondsToSelector:@selector(clickCarouselFigureEvent)]) {
        [self.cfDelegate clickCarouselFigureEvent];
    }
}
#pragma mark -定时器 targets
- (void)timerEvent {
    [_CarouselFigureScrollow setContentOffset:CGPointMake(2 * width, 0) animated:YES];
}
#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPageNumber = 0;
    CGFloat minOffset = MAXFLOAT;
    for (int i = 0; i < imageBtnCount; i++) {
        UIButton * imageBtn = _CarouselFigureScrollow.subviews[i];
        CGFloat offset = 0;
        offset = ABS(imageBtn.frame.origin.x - _CarouselFigureScrollow.contentOffset.x);
        if (offset < minOffset) {
            minOffset = offset;
            currentPageNumber = imageBtn.tag;
        }
    }
    _pageControlView.currentPage = currentPageNumber;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self recoverTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateImageContent];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updateImageContent];
}
#pragma mark -属性 - getter
- (UIScrollView *)CarouselFigureScrollow {
    if (!_CarouselFigureScrollow) {
        _CarouselFigureScrollow = [[UIScrollView alloc] init];
        _CarouselFigureScrollow.delegate = self;
        _CarouselFigureScrollow.showsVerticalScrollIndicator = NO;
        _CarouselFigureScrollow.showsHorizontalScrollIndicator = NO;
        _CarouselFigureScrollow.pagingEnabled = YES;
        _CarouselFigureScrollow.bounces = NO;
        
        for (int i = 0; i < imageBtnCount; i++) {
            UIButton * imageBtn = [[UIButton alloc] init];
            [_CarouselFigureScrollow addSubview:imageBtn];
        }
    }
    return _CarouselFigureScrollow;
}
- (XHPageControlView *)pageControlView {
    if (!_pageControlView) {
        _pageControlView = [[XHPageControlView alloc] initWithFrame:CGRectMake(width / 2 - 50, height - 25, 100, 20) WithActiveImage:[UIImage imageNamed:@"英文"] WithInactiveImage:[UIImage imageNamed:@"中文"]];
        _pageControlView.currentPageIndicatorTintColor= [UIColor clearColor];
        _pageControlView.pageIndicatorTintColor = [UIColor clearColor];
        _pageControlView.layer.cornerRadius = 10.f;
        _pageControlView.backgroundColor = [UIColor blackColor];
        _pageControlView.alpha = 0.3f;
    }
    return _pageControlView;
}
- (NSTimer *)CarouselFigureTimer {
    if (!_CarouselFigureTimer) {
        _CarouselFigureTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    }
    return _CarouselFigureTimer;
}
#pragma mark -属性 - setter
- (void)setImages:(NSArray *)images {
    _images = images;
    _pageControlView.numberOfPages = images.count;
    _pageControlView.currentPage = 0;
    [self setImgaeContent];
    [self startTimer];
}
@end
