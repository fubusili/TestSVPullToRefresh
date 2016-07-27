//
//  SVPullToRefreshGifView.m
//  TestSVPullToRefresh
//
//  Created by hc_cyril on 16/7/26.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import "SVPullToRefreshGifView.h"
@interface SVPullToRefreshGifView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *animationImages;
@end

@implementation SVPullToRefreshGifView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

#pragma mark - public methods 


- (void)startLoading {

    if (self.animationImages .count == 0) return;
    
    [self.imageView stopAnimating];
    if (self.animationImages.count == 1) { // 单张图片
        self.imageView.image = [self.animationImages lastObject];
    } else { // 多张图片
        self.imageView.animationImages = self.animationImages;
        self.imageView.animationDuration = 0.15 * self.animationImages.count;//0.3
        [self.imageView startAnimating];
    }
    
}

- (void)stopLoading {
    
    [self.imageView stopAnimating];

}

#pragma mark - private methods
- (void)setupSubviews {

    [self addSubview:self.imageView];
    UIImage *image = [self.animationImages firstObject];
    CGFloat width = self.frame.size.height * image.size.width / image.size.height;
    CGRect imageViewFrame = CGRectMake((self.frame.size.width - width) / 2.0, 0, width, self.frame.size.height);
    self.imageView.frame = imageViewFrame;
}

#pragma mark - setter and getter
- (UIImageView *)imageView {

    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"re1"];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}
- (NSMutableArray *)animationImages {

    if (!_animationImages) {
        _animationImages = [NSMutableArray array];
        for (int i = 1; i < 10; i ++ ) {
            
//            NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"re%d",i] ofType:@"png"];
//            [_animationImages addObject:[UIImage imageWithContentsOfFile:path]];
            [_animationImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"re%d",i]]];
        }
//        [_animationImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"re%d",(int)pow(2, 0)]]];
//        [_animationImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"re%d",(int)pow(2, 2)]]];
//        [_animationImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"re%d",(int)pow(2, 3)]]];
    }
    return _animationImages;
}

@end
