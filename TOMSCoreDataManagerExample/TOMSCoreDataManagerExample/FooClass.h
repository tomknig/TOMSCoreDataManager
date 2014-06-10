//
//  FooClass.h
//  TOMSCoreDataManagerExample
//
//  Created by Tom König on 09/06/14.
//  Copyright (c) 2014 TomKnig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface FooClass : NSManagedObject

@property (nonatomic, retain) NSString * fooAttribute;
@property (nonatomic, retain) NSString * objectId;

@end
