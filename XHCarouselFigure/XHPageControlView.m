//
//  XHPageControlView.m
//  XHCarouselFigure
//
//  Created by 邢浩 on 2016/12/27.
//  Copyright © 2016年 邢浩. All rights reserved.
//
#define dotWidth 10
#define dotHeight 10

#import "XHPageControlView.h"
@interface XHPageControlView (){
    UIImage * _active;/**激活位置图标*/
    UIImage * _inactive;/**未激活位置图标*/
}
@end

@implementation XHPageControlView
#pragma mark -override
- (void)setCurrentPage:(NSInteger)currentPage {
    [super setCurrentPage:currentPage];
    [self updateDots];
}
#pragma mark -custom override
- (instancetype)initWithFrame:(CGRect)frame
              WithActiveImage:(UIImage *)active
            WithInactiveImage:(UIImage *)inactive {
    self = [super initWithFrame:frame];
    if (self) {
        _active = active;
        _inactive = inactive;
    }
    return self;
}
#pragma mark -private targets
- (void)updateDots {
    for (int i = 0; i < self.subviews.count; i++) {
        UIView* dot = [self.subviews objectAtIndex:i];
        if (dot.subviews.count == 0) {
            UIImageView * backDot = [[UIImageView alloc] init];
            backDot.frame = dot.bounds;
            [dot addSubview:backDot];
        }
        UIImageView * bridgeView = dot.subviews[0];
        if (i == self.currentPage) {
            bridgeView.frame = CGRectMake(0, -1, 10, 10);
            bridgeView.image = _active;
            
        }
        else {
            bridgeView.frame = CGRectMake(0, 0, 7, 7);
            bridgeView.image = _inactive;
        }
    }
}
@end
