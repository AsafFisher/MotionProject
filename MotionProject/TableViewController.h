//
//  TableViewController.h
//  MotionProject
//
//  Created by Asaf Fisher on 6/15/14.
//  Copyright (c) 2014 Asaf Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface TableViewController : UITableViewController
@property (nonatomic, strong)CMMotionManager *motionManager;
@property (nonatomic,strong) CMMotionActivityManager *activityManager;
@property (nonatomic,strong)NSArray* tableArray;
@property NSDateFormatter *formater;
@end
