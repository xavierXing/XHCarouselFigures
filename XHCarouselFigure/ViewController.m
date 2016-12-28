//
//  ViewController.m
//  XHCarouselFigure
//
//  Created by 邢浩 on 2016/12/27.
//  Copyright © 2016年 邢浩. All rights reserved.
//

#import "ViewController.h"
#import "CarouselFigure.h"
@interface ViewController ()<CarouselFigureDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    CarouselFigure * CF = [[CarouselFigure alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 200)];
    CF.images = @[[UIImage imageNamed:@"0"],[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"],[UIImage imageNamed:@"5"]];
    CF.cfDelegate = self;
    [self.view addSubview:CF];
}
- (void)clickCarouselFigureEvent {
    NSLog(@"this is a click event");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
