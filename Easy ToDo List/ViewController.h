//
//  ViewController.h
//  Easy ToDo List
//
//  Created by Martin Denci on 25/09/2016.
//  Copyright © 2016 Martin Denci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "TaskTableViewCell.h"
#import "AddTaskViewController.h"


@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddTaskViewControllerDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)reorderButton:(UIBarButtonItem *)sender;
- (IBAction)addButton:(UIButton *)sender;

-(void)createTask:(int)numberOfTask;

@end

