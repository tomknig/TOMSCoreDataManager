//
//  CollectionViewController.m
//  TOMSCoreDataManagerExample
//
//  Created by Tom König on 09/06/14.
//  Copyright (c) 2014 TomKnig. All rights reserved.
//

#import "CollectionViewController.h"
#import "Person.h"
#import "RestClient.h"

@implementation CollectionViewController

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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self insertRandomObject];
    });
}

#pragma mark - Cell Configuration

- (void)configureCell:(id)cell
         forIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *collectionViewCell = (UICollectionViewCell *)cell;
    NSManagedObject *object = [self.coreDataFetchController objectAtIndexPath:indexPath];
    
    if ([object isKindOfClass:[Person class]]) {
        Person *person = (Person *)object;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 320, 42)];
        UILabel *detailTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 21, 320, 42)];
        
        textLabel.text = person.name;
        detailTextLabel.text = person.objectId;
        
        [collectionViewCell addSubview:textLabel];
        [collectionViewCell addSubview:detailTextLabel];
    }
}

#pragma mark - TOMSCoreDataViewDataSource - Required

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
    return @[[NSSortDescriptor sortDescriptorWithKey:[Person toms_uniqueIdentifier] ascending:NO]];;
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
