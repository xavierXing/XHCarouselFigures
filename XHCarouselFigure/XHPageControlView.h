//
//  XHPageControlView.h
//  XHCarouselFigure
//
//  Created by 邢浩 on 2016/12/27.
//  Copyright © 2016年 邢浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHPageControlView : UIPageControl

/**
 自定义PageControl

 @param frame pageControl的大小
 @param active 激活位置的图标
 @param inactive 未激活位置的图标
 @return 返回自定义对象
 */
- (_Nonnull instancetype)initWithFrame:(CGRect)frame
              WithActiveImage:( UIImage * _Nonnull )active
            WithInactiveImage:( UIImage * _Nonnull )inactive;

@end
