//
//  RestClient.m
//  TOMSCoreDataManagerExample
//
//  Created by Tom König on 09/06/14.
//  Copyright (c) 2014 TomKnig. All rights reserved.
//

#import "RestClient.h"

#define kRestApiBaseURL @"https://..."

@implementation RestClient

- (id)init
{
    self = [super initWithBaseURL:[NSURL URLWithString:kRestApiBaseURL]];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

- (id)representationOrArrayOfRepresentationsFromResponseObject:(id)responseObject
{
    return responseObject;
}

- (NSDictionary *)attributesForRepresentation:(NSDictionary *)representation
                                     ofEntity:(NSEntityDescription *)entity
                                 fromResponse:(NSHTTPURLResponse *)response
{
    NSMutableDictionary *mutablePropertyValues = [[super attributesForRepresentation:representation ofEntity:entity fromResponse:response] mutableCopy];
    return mutablePropertyValues;
}

- (BOOL)shouldFetchRemoteAttributeValuesForObjectWithID:(NSManagedObjectID *)objectID
                                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}

- (BOOL)shouldFetchRemoteValuesForRelationship:(NSRelationshipDescription *)relationship
                               forObjectWithID:(NSManagedObjectID *)objectID
                        inManagedObjectContext:(NSManagedObjectContext *)context
{
    return NO;
}

@end
