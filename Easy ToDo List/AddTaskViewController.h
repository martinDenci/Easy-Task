//
//  AddTaskViewController.h
//  Easy ToDo List
//
//  Created by Martin Denci on 25/09/2016.
//  Copyright © 2016 Martin Denci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol AddTaskViewControllerDelegate <NSObject>

@required
-(void)saveTask:(Task *)task;

@end

@interface AddTaskViewController : UIViewController

@property (nonatomic, weak) id <AddTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *addTaskTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *addDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *addTaskDAtePicker;


- (IBAction)addTaskSaveButton:(UIButton *)sender;
- (IBAction)addTaskCancelButton:(UIBarButtonItem *)sender;
@end
