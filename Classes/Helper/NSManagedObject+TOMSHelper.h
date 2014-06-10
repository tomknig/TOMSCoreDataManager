//
//  NSManagedObject+TOMSHelper.h
//  TOMSCoreDataManager
//
//  Created by Tom König on 09/06/14.
//  Copyright (c) 2014 TomKnig. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (TOMSHelper)

+ (instancetype)objectForUniqueIdentifier:(NSString *)uniqueIdentifier
                                inContext:(NSManagedObjectContext *)context;

+ (instancetype)newObjectFromDictionary:(NSDictionary *)dictionary
                              inContext:(NSManagedObjectContext *)context;

+ (instancetype)newObjectFromDictionary:(NSDictionary *)dictionary
                              inContext:(NSManagedObjectContext *)context
                        autoSaveContext:(BOOL)autoSave;

+ (NSArray *)objectsForPredicate:(NSPredicate *)predicate
                 sortDescriptors:(NSArray *)sortDescriptors
                       inContext:(NSManagedObjectContext *)context;

+ (NSArray *)objectsForPredicate:(NSPredicate *)predicate
                       inContext:(NSManagedObjectContext *)context;

//The following may be overridden
+ (NSString *)uniqueIdentifier;

+ (BOOL)shouldAutoGenerateGloballyUniqueIdentifiers;

@end
