//
//  CollectionViewController.m
//  TOMSCoreDataManagerExample
//
//  Created by Tom König on 09/06/14.
//  Copyright (c) 2014 TomKnig. All rights reserved.
//

#import "CollectionViewController.h"
#import "FooClass.h"
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
    UICollectionViewCell *collectionViewCell = (UICollectionViewCell *)cell;
    NSManagedObject *object = [self.coreDataFetchController objectAtIndexPath:indexPath];
    
    if ([object isKindOfClass:[FooClass class]]) {
        FooClass *foo = (FooClass *)object;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 320, 42)];
        UILabel *detailTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 21, 320, 42)];
        
        textLabel.text = foo.fooAttribute;
        detailTextLabel.text = foo.objectId;
        
        [collectionViewCell addSubview:textLabel];
        [collectionViewCell addSubview:detailTextLabel];
    }
}

#pragma mark - TOMSCoreDataViewDataSource - Required

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
    return @[[NSSortDescriptor sortDescriptorWithKey:[FooClass uniqueIdentifier] ascending:NO]];;
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
