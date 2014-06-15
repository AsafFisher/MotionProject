//
//  TableViewController.m
//  MotionProject
//
//  Created by Asaf Fisher on 6/15/14.
//  Copyright (c) 2014 Asaf Fisher. All rights reserved.
//

#import "TableViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface TableViewController ()
@end

@implementation TableViewController
@synthesize motionManager,activityManager;
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.formater = [[NSDateFormatter alloc]init];
        [self.formater setDateFormat:@"dd/MM hh:mm:ss"];
        self.activityManager = [[CMMotionActivityManager alloc]init];
        if ([CMMotionActivityManager isActivityAvailable] == NO) {
            NSLog(@"Activity not avilable");
        }
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
     [self reloadTableViewData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

- (void)reloadTableViewData{
    NSDate *now = [NSDate date];
    NSDate *beforeWeek = [now dateByAddingTimeInterval:-3600*24*7];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [activityManager queryActivityStartingFromDate:beforeWeek toDate:now toQueue:queue withHandler:^(NSArray *activities, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        
        NSMutableArray *finalArray = [[NSMutableArray alloc]init];
        for (CMMotionActivity *motionActivity in activities) {
            if (motionActivity.automotive) {
                [finalArray addObject:motionActivity];
            }
        }
        self.tableArray = [NSArray arrayWithArray:finalArray];
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];

}

- (void)stopMonitorAccelerationActoin{
    [motionManager stopAccelerometerUpdates];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.tableArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CMMotionActivity *item = self.tableArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Driving at %@",[self.formater stringFromDate:item.startDate] ];
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
