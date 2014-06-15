//
//  UIColor+randomColor.m
//  MotionProject
//
//  Created by Asaf Fisher on 6/11/14.
//  Copyright (c) 2014 Asaf Fisher. All rights reserved.
//

#import "UIColor+randomColor.h"

@implementation UIColor (randomColor)
+(UIColor *)randomColor{
    CGFloat red = rand()%256/256.f;
    CGFloat blue = rand()%256/256.f;
    CGFloat green = rand()%256/256.f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}
@end
