//
//  ViewController.m
//  Easy ToDo List
//
//  Created by Martin Denci on 25/09/2016.
//  Copyright © 2016 Martin Denci. All rights reserved.
//

#import "ViewController.h"
#import "Category.h"
#import "TaskTableViewHeaderFooterView.h"


// class for Section header

@interface TableSectionInfo : NSObject

@end

@interface TableSectionInfo ()

@property (nonatomic, copy) NSString *sectionTitle;
@property (nonatomic, strong) NSMutableArray *tasksByCategory;

@end

@implementation TableSectionInfo

-(void)setSectionTitle:(NSString *)sectionTitle andTasks:(Task *)task {
    if(![self.sectionTitle isEqualToString:sectionTitle]) {
        self.sectionTitle = sectionTitle;
    }
    
    if(!self.tasksByCategory) {
        self.tasksByCategory = [[NSMutableArray alloc] init];
    }
    [self.tasksByCategory addObject:task];
}

@end

//end class


@interface ViewController () 

@property (nonatomic, strong) NSMutableArray *tasks;
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSMutableArray *tasksOrdredByDate;
@property (nonatomic, strong) NSMutableArray *taskSortedByCategories;

@end

@implementation ViewController


// Lazy init

-(NSMutableArray *)tasks {

    if(!_tasks) {
        _tasks = [[NSMutableArray alloc] init];
    }
    return _tasks;
}

-(NSMutableArray *)categories {
    if(!_categories){
        _categories = [[NSMutableArray alloc] init];
    }
    
    return _categories;
}

-(NSMutableArray *)tasksOrdredByDate
{
    if(!_tasksOrdredByDate) {
        _tasksOrdredByDate = [[NSMutableArray alloc] init];
    }
    
    return _tasksOrdredByDate;
}

-(NSMutableArray *)taskSortedByCategories
{
    if(!_taskSortedByCategories) {
        _taskSortedByCategories = [[NSMutableArray alloc] init];
    }
    
    return _taskSortedByCategories;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TableSectionHeader" bundle:nil ] forHeaderFooterViewReuseIdentifier:@"TaskTableViewHeaderFooterView"];
    
    
    //Create categories
    [self createCategories];
    

    [self createTask:4];
    [self orderTasksByCategory:self.tasks];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController * nc = (UINavigationController *) segue.destinationViewController;
        if(nc.viewControllers.count && [nc.viewControllers.firstObject isKindOfClass:[AddTaskViewController class]]) {
            AddTaskViewController *vc = (AddTaskViewController *) nc.viewControllers.firstObject;
            vc.delegate = self;
        }
    }
}

#pragma mark - Helpers

-(void)createTask:(int)numberOfTask {
    
    for (int i = 0; i < numberOfTask; i++) {
        Task *task = [[Task alloc] init];
        task.taskName = [NSString stringWithFormat:@"Title %d", i];
        task.taskDescription = [NSString stringWithFormat:@"Description %d", i];
        task.taskDate = [NSDate date];
        if(i % 2)
            task.taskCategory = self.categories[0];
        else
            task.taskCategory = self.categories[1];
        [self.tasks addObject:task];
    }
    
    NSString *date = @"18-12-2016";
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    Task *task = [[Task alloc] init];
    task.taskName = [NSString stringWithFormat:@"Title"];
    task.taskDescription = [NSString stringWithFormat:@"Description"];
    task.taskCategory = self.categories[1];
    
    task.taskDate = [formatter dateFromString:date];
    [self.tasks addObject:task];
    
    date = @"23-12-2016";
    
    Task *task2 = [[Task alloc] init];
    task2.taskName = [NSString stringWithFormat:@"Title"];
    task2.taskDescription = [NSString stringWithFormat:@"Description"];
    task2.taskCategory = self.categories[1];
    
    task2.taskDate = [formatter dateFromString:date];
    [self.tasks addObject:task2];

    
}

-(void)createCategories {
    Category *cat1 = [[Category alloc] initCategoryWithName:@"Sport" imageName:@"sport.png"];
    [self.categories addObject:cat1];
    
    Category *cat2 = [[Category alloc] initCategoryWithName:@"Home" imageName:@"home.png"];
    [self.categories addObject:cat2];
    
    Category *cat3 = [[Category alloc] initCategoryWithName:@"Work" imageName:@"sport.png"];
    [self.categories addObject:cat3];
    
}

-(void)orderTasksByCategory:(NSMutableArray *)tasks
{
    
    NSSortDescriptor *sorDataByDate = [NSSortDescriptor sortDescriptorWithKey:@"taskDate" ascending:YES];
    NSSortDescriptor *sorDataByName = [NSSortDescriptor sortDescriptorWithKey:@"taskName" ascending:YES];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *component = [cal components:NSCalendarUnitYear|NSCalendarUnitDay|NSCalendarUnitMonth fromDate:[NSDate date]];

    NSDate *today =  [cal dateFromComponents:component];
    
    
    NSDate *tomorrow = [cal dateByAddingUnit:NSCalendarUnitDay value:1 toDate:[NSDate date] options:0];
    NSDateComponents *component2 = [cal components:NSCalendarUnitYear|NSCalendarUnitDay|NSCalendarUnitMonth fromDate:tomorrow];
    NSDate *tomorrow2 = [cal dateFromComponents:component2];
    
    
    [tasks sortUsingDescriptors:@[sorDataByDate, sorDataByName]];
    
    TableSectionInfo *todaySection = [[TableSectionInfo alloc] init];
    TableSectionInfo *tomorrowSection = [[TableSectionInfo alloc] init];
    TableSectionInfo *upcomingSection = [[TableSectionInfo alloc] init];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString *currentDateString = [[NSString alloc] init];
    NSString *taskDateString = [[NSString alloc] init];
    currentDateString = [formatter stringFromDate:[NSDate date]];
    
    for(Task *task in tasks) {
        
        taskDateString = [formatter stringFromDate:task.taskDate];

        
        if([currentDateString isEqualToString:taskDateString]) {
            [todaySection setSectionTitle:@"Today" andTasks:task];
        } else {
            if([today compare:task.taskDate] == -1) {
                if([task.taskDate compare:tomorrow2] == 0) {
                    [tomorrowSection setSectionTitle:@"Tomorrow" andTasks:task];
                    
                } else {
                    [upcomingSection setSectionTitle:@"Upcoming" andTasks:task];
                }
            }
        }

    }
    
    [self saveTaskSortedByCategories:todaySection];
    [self saveTaskSortedByCategories:tomorrowSection];
    [self saveTaskSortedByCategories:upcomingSection];
    

}

-(void)saveTaskSortedByCategories:(TableSectionInfo *)taskInCategory {
    if([taskInCategory.tasksByCategory count] > 0){
        [self.taskSortedByCategories addObject:taskInCategory];

    }
   
}

#pragma mark - UITableViewDelegate



-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

    }];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self.tasks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    editAction.backgroundColor = [UIColor greenColor];
    deleteAction.backgroundColor = [UIColor redColor];

    return @[deleteAction, editAction];
}



#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.taskSortedByCategories count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TableSectionInfo *sectionTask = [[TableSectionInfo alloc] init];
    sectionTask = self.taskSortedByCategories[section];
    return [sectionTask.tasksByCategory count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TableSectionInfo *currentTableSection = [[TableSectionInfo alloc] init];
    currentTableSection = self.taskSortedByCategories[section];
    TaskTableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TaskTableViewHeaderFooterView"];
    header.TableSectionHeaderLabel.text = currentTableSection.sectionTitle;
    header.TableSectionHeaderLabel.textColor = [UIColor blackColor];
    header.contentView.backgroundColor = [UIColor redColor];
    
    
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TableSectionInfo *table = [[TableSectionInfo alloc] init];
    table = self.taskSortedByCategories[indexPath.section];
    Task *curentTask = table.tasksByCategory[indexPath.row];
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Task Cell" forIndexPath:indexPath];
    cell.TaskTitle.text = curentTask.taskName;
    cell.TaskDescription.text = curentTask.taskDescription;
    cell.TaskDay.text = [NSString stringWithFormat:@"%ld", (long int) curentTask.taskDayInt];
    cell.TaskMonth.text = [NSString stringWithFormat:@"%ld-%ld", (long int) curentTask.taskMonthInt, (long int)curentTask.taskYearInt];
    cell.TaskCategory.image = curentTask.taskCategory.categoryImage;
    return cell;
}

#pragma mark - AddTaskViewControllerDelegate

-(void)saveTask:(Task *)task {
    NSLog(@"dsdds");
    [self.tasks addObject:task];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

#pragma mark - IBAction

- (IBAction)reorderButton:(UIBarButtonItem *)sender {
    if(self.tableView.editing == YES) {
        [self.tableView setEditing:NO animated:YES];
    } else {
        [self.tableView setEditing:YES animated:YES];
    }
}

- (IBAction)addButton:(UIButton *)sender {
}
@end
