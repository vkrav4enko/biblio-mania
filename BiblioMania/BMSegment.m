//
//  BMSegment.m
//  BiblioMania
//
//  Created by Владимир on 23.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "BMSegment.h"

@interface BMSegment ()

@end

@implementation BMSegment

- (id)initWithText:(NSString *)text
{
    self = [super init];
    if (self)
    {
        _text = text;
    }
    return self;
}

@end
