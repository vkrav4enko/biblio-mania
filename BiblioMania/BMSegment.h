//
//  BMSegment.h
//  BiblioMania
//
//  Created by Владимир on 23.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMSegment : NSObject
@property (nonatomic, copy, readonly) NSString *text;

- (id) initWithText: (NSString *) text;

@end
