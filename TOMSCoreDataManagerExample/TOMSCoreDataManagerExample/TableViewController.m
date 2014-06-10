//
//  TableViewController.m
//  TOMSCoreDataManagerExample
//
//  Created by Tom König on 09/06/14.
//  Copyright (c) 2014 TomKnig. All rights reserved.
//

#import "TableViewController.h"
#import "FooClass.h"
#import "RestClient.h"

@implementation TableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self insertRandomObject];
}

- (void)insertRandomObject
{
    [FooClass newObjectFromDictionary:@{
                                        @"fooAttribute" : [NSString stringWithFormat:@"MuchRandom_%d", arc4random() % 100]
                                        }
                            inContext:self.managedObjectContext];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self insertRandomObject];
    });
}

#pragma mark - Cell Configuration

- (void)configureCell:(id)cell
         forIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tableViewCell = (UITableViewCell *)cell;
    NSManagedObject *object = [self.coreDataFetchController objectAtIndexPath:indexPath];
    
    if ([object isKindOfClass:[FooClass class]]) {
        FooClass *foo = (FooClass *)object;
        tableViewCell.textLabel.text = foo.fooAttribute;
        tableViewCell.detailTextLabel.text = foo.objectId;
    }
}

#pragma mark - TOMSCoreDataViewDataSource - Requiered

- (NSString *)modelName
{
    return @"FooModel";
}

- (NSString *)entityName
{
    return @"FooClass";
}

- (NSString *)cellIdentifierForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const cellIdentifier = @"Cell";
    return cellIdentifier;
}

- (NSArray *)defaultSortDescriptors
{
    return @[[NSSortDescriptor sortDescriptorWithKey:[FooClass uniqueIdentifier] ascending:NO]];
}

- (NSPredicate *)defaultPredicate
{
    return [NSPredicate predicateWithFormat:@"fooAttribute.length > 0"];
}

#pragma mark - TOMSCoreDataViewDataSource - Optional

- (Class)backingRESTClientClass
{
    return [RestClient class];
}

@end
