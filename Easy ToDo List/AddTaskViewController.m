//
//  AddTaskViewController.m
//  Easy ToDo List
//
//  Created by Martin Denci on 25/09/2016.
//  Copyright © 2016 Martin Denci. All rights reserved.
//

#import "AddTaskViewController.h"
#import "Task.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Helpers

-(Task *)createTask {
    Task *task = [[Task alloc] init];
    task.taskName = self.addTaskTitleTextField.text;
    task.taskDescription = self.addDescriptionTextView.text;
    task.taskDate = self.addTaskDAtePicker.date;
    
    return  task;
}

- (IBAction)addTaskSaveButton:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(saveTask:)]) {
        [self.delegate saveTask:[self createTask]];
    }
        
}

- (IBAction)addTaskCancelButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
