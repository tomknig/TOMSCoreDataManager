//
//  TableViewController.m
//  TOMSCoreDataManagerExample
//
//  Created by Tom König on 09/06/14.
//  Copyright (c) 2014 TomKnig. All rights reserved.
//

#import "TableViewController.h"
#import "Person.h"
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
    Person *steve = [Person toms_newObjectFromDictionary:@{
                                                           @"name" : [NSString stringWithFormat:@"Steve_%d", arc4random() % 100]
                                                           }
                                               inContext:self.managedObjectContext];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        steve.name = @"TOM";
    });
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
    
    if ([object isKindOfClass:[Person class]]) {
        Person *person = (Person *)object;
        tableViewCell.textLabel.text = person.name;
        tableViewCell.detailTextLabel.text = person.objectId;
    }
}

#pragma mark - TOMSCoreDataViewDataSource - Requiered

- (NSString *)modelName
{
    return @"Model";
}

- (NSString *)entityName
{
    return @"Person";
}

- (NSString *)cellIdentifierForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const cellIdentifier = @"Cell";
    return cellIdentifier;
}

- (NSArray *)defaultSortDescriptors
{
    return @[[NSSortDescriptor sortDescriptorWithKey:[Person toms_uniqueIdentifier] ascending:NO]];
}

- (NSPredicate *)defaultPredicate
{
    return [NSPredicate predicateWithFormat:@"name.length > 0"];
}

#pragma mark - TOMSCoreDataViewDataSource - Optional

- (Class)backingRESTClientClass
{
    return [RestClient class];
}

@end
