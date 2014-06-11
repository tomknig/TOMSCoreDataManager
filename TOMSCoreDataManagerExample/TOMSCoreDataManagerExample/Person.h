//
//  Person.h
//  TOMSCoreDataManagerExample
//
//  Created by Tom König on 11/06/14.
//  Copyright (c) 2014 TomKnig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <TOMSCoreDataManager/NSManagedObject+TOMSHelper.h>

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * objectId;

@end
