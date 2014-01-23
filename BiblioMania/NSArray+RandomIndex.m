//
//  NSArray+RandomIndex.m
//  BiblioMania
//
//  Created by Владимир on 23.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "NSArray+RandomIndex.h"

@implementation NSArray (RandomIndex)

- (int)ri_randomIndex
{
    return arc4random() % self.count;
}

@end
