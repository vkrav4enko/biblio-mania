//
//  BMLibraryAPI.h
//  BiblioMania
//
//  Created by Владимир on 23.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMSegment.h"

@interface BMLibraryAPI : NSObject

+ (BMLibraryAPI *)sharedInstance;

- (BMSegment *) getRandomSegment;
- (BMSegment *) getSegmentBySearch: (NSString *) search;

@end
