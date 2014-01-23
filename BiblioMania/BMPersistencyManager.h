//
//  BMPersistencyManager.h
//  BiblioMania
//
//  Created by Владимир on 23.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMSegment.h"

@interface BMPersistencyManager : NSObject

- (BMSegment *) getRandomSegment;
- (BMSegment *) getSegmentBySearch: (NSString *) search;

@end
