//
//  BMLibraryAPI.m
//  BiblioMania
//
//  Created by Владимир on 23.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "BMLibraryAPI.h"
#import "BMPersistencyManager.h"

@interface BMLibraryAPI ()
@property (nonatomic, strong) BMPersistencyManager *persistencyManager;
@end

@implementation BMLibraryAPI

+ (BMLibraryAPI *) sharedInstance
{
    static BMLibraryAPI * _sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[BMLibraryAPI alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _persistencyManager = [[BMPersistencyManager alloc] init];
    }
    return self;
}

- (BMSegment *)getRandomSegment
{
    return [_persistencyManager getRandomSegment];
}

- (BMSegment *)getSegmentBySearch:(NSString *)search
{
    return [_persistencyManager getSegmentBySearch:search];
}


@end
