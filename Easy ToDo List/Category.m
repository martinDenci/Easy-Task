//
//  Category.m
//  Easy ToDo List
//
//  Created by Martin Denci on 01/11/2016.
//  Copyright © 2016 Martin Denci. All rights reserved.
//

#import "Category.h"

@implementation Category

-(id)init
{
    self = [self initCategoryWithName:nil imageName:nil];
    
    return self;
}

-(id)initCategoryWithName:(NSString *)categoryName imageName:(NSString *)imageName
{
    self = [super init];
    
    if(self){
    
        _categoryName = categoryName;
        _categoryImageName = imageName;
        _categoryImage = [UIImage imageNamed:self.categoryImageName];
    }
    
    return self;
}

@end
