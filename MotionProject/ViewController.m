//
//  ViewController.m
//  MotionProject
//
//  Created by Asaf Fisher on 6/11/14.
//  Copyright (c) 2014 Asaf Fisher. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+randomColor.h"
@interface ViewController ()
@property (nonatomic)BOOL help;
@end

@implementation ViewController
@synthesize motionManager;

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        motionManager = [[CMMotionManager alloc]init];
        self.help = NO;
    }
    return self;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    switch (motion) {
        case UIEventSubtypeMotionShake:{
            [UIView animateWithDuration:1.0 animations:^{
               self.view.backgroundColor = [UIColor randomColor];
            }];
        }
            
            break;
            
        default:
            break;
    }
}

- (IBAction)startMagnometerAccelerationAction:(id)sender{
    [motionManager setMagnetometerUpdateInterval:1];
    NSOperationQueue *queue;
    queue = [[NSOperationQueue alloc]init];
    [motionManager startMagnetometerUpdatesToQueue:queue withHandler:^(CMMagnetometerData *magnetometerData, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            [motionManager stopAccelerometerUpdates];
        }
        
        NSLog(@"%@",magnetometerData);
        
        
        
    }];
}

- (IBAction)startMonitorAccelerationAction:(id)sender{
    NSOperationQueue *queue;
    queue = [[NSOperationQueue alloc]init];
    
    [motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
            [motionManager stopAccelerometerUpdates];
        }
        
        NSLog(@"%@",accelerometerData);
        
        
        
    }];
}

- (IBAction)stopMonitorAccelerationActoin:(id)sender{
   [motionManager stopAccelerometerUpdates];
}

- (void)initialize
{
   // NSLog(@"%@",[self.motionManager gyroData]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
