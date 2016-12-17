//
//  Task.m
//  Easy ToDo List
//
//  Created by Martin Denci on 27/09/2016.
//  Copyright © 2016 Martin Denci. All rights reserved.
//

#import "Task.h"



@interface Task ()

@end


@implementation Task


-(void)setTaskDate:(NSDate *)taskDate {
    if(_taskDate != taskDate) {
        _taskDate = taskDate;
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:taskDate];
        
        _taskDayInt =  (NSInteger *) [dateComponents day];
        _taskMonthInt = (NSInteger *) [dateComponents month];
        _taskYearInt = (NSInteger *) [dateComponents year];
        
    }
}

-(NSString *)taskDay
{
    _taskDay = [NSString stringWithFormat:@"%ld", (long int) self.taskDayInt];
    
    return _taskDay;
}
-(NSString *)taskMonth
{
    _taskMonth = [NSString stringWithFormat:@"%ld", (long int) self.taskMonthInt];
    
    return _taskMonth;
}
-(NSString *)taskYear
{
    _taskYear = [NSString stringWithFormat:@"%ld", (long int) self.taskYearInt];
    
    return _taskYear;
}


@end
