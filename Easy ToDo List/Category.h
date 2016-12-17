//
//  Category.h
//  Easy ToDo List
//
//  Created by Martin Denci on 01/11/2016.
//  Copyright © 2016 Martin Denci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Category : NSObject

@property (nonatomic, readonly) UIImage *categoryImage;
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, copy) NSString *categoryImageName;

-(id)initCategoryWithName:(NSString *)categoryName imageName:(NSString *)imageName;

@end
