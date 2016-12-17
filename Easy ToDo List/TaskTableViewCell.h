//
//  TaskTableViewCell.h
//  Easy ToDo List
//
//  Created by Martin Denci on 25/09/2016.
//  Copyright © 2016 Martin Denci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *TaskTitle;
@property (weak, nonatomic) IBOutlet UILabel *TaskDescription;
@property (weak, nonatomic) IBOutlet UIImageView *TaskCategory;
@property (weak, nonatomic) IBOutlet UILabel *TaskDay;
@property (weak, nonatomic) IBOutlet UILabel *TaskMonth;


@end
