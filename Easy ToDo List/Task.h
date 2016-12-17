//
//  Task.h
//  Easy ToDo List
//
//  Created by Martin Denci on 27/09/2016.
//  Copyright © 2016 Martin Denci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Defines.h"
#import "Category.h"

@interface Task : NSObject

@property (nonatomic, copy) NSString *taskName;
@property (nonatomic, copy) NSString *taskDescription;
@property (nonatomic, strong) NSDate *taskDate;
@property (nonatomic, copy) NSString *taskDay;
@property (nonatomic, copy) NSString *taskMonth;
@property (nonatomic, copy) NSString *taskYear;
@property (nonatomic, readonly) NSInteger *taskDayInt;
@property (nonatomic, readonly) NSInteger *taskMonthInt;
@property (nonatomic, readonly) NSInteger *taskYearInt;
@property (nonatomic, strong) Category *taskCategory;
@property (nonatomic) BOOL isCompleted;
@property (nonatomic) BOOL hasPriority;

@end
