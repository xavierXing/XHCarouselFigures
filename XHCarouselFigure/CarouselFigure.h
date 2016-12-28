//
//  CarouselFigure.h
//  XHCarouselFigure
//
//  Created by 邢浩 on 2016/12/27.
//  Copyright © 2016年 邢浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarouselFigureDelegate <NSObject>

- (void)clickCarouselFigureEvent;/**点击轮播图图片触发的事件*/

@end

@interface CarouselFigure : UIView

@property(nonatomic, strong)NSArray * images;/**图片资源*/
@property(nonatomic, weak)id<CarouselFigureDelegate> cfDelegate;/**CarouselFigure代理*/

@end
