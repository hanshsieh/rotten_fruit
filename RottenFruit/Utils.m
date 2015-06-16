//
//  Utils.m
//  RottenFruit
//
//  Created by Chu-An Hsieh on 6/16/15.
//  Copyright (c) 2015 Chu-An Hsieh. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+ (void)fadeInImage:(UIImageView *)imageView toImage:(UIImage *)toImage duration:(NSTimeInterval)duration {
    [UIView transitionWithView:imageView
                      duration:duration
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        imageView.image = toImage;
                    } completion:nil];
}
@end
