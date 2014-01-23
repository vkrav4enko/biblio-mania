//
//  BMPersistencyManager.m
//  BiblioMania
//
//  Created by Владимир on 23.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "BMPersistencyManager.h"
#import "NSArray+RandomIndex.h"

@interface BMPersistencyManager ()
@property (nonatomic, strong) NSArray *bibleContent;
@end

@implementation BMPersistencyManager

- (id) init
{
    self = [super init];
    if (self)
    {
        [self loadData];
    }
    return self;
}

- (void) loadData
{
    NSData *plistData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bible" ofType:@"plist"]];
    if (!plistData)
    {
        NSLog(@"error reading from file");
        return;
    }
    NSPropertyListFormat format;
    NSError *error = nil;
    id plist = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListImmutable format:&format error:&error];
    if (!error)
    {
        _bibleContent = plist;
    }
    else
    {
        NSLog(@"error: %@", error);
    }
}

- (BMSegment *)getRandomSegment
{
    NSDictionary *randomBook = [_bibleContent objectAtIndex: _bibleContent.ri_randomIndex];
    NSArray *chapters = [randomBook objectForKey:@"chapters"];
    NSArray *randomChapter = [chapters objectAtIndex:chapters.ri_randomIndex];
    NSString *line = [randomChapter objectAtIndex:randomChapter.ri_randomIndex];
    
    //remove newline characters
    line = [[line componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "];
    
    [line enumerateSubstringsInRange:NSMakeRange(0, [line length])
                            options:NSStringEnumerationBySentences | NSStringEnumerationLocalized
                         usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
    {
        NSLog(@"Sentence: %@", substring);
    }];
    
    return [[BMSegment alloc] initWithText:line];
}

- (BMSegment *)getSegmentBySearch:(NSString *)search
{
    NSArray *arrayOfArrays = @[@[@[@1, @2, @3], @[@1, @2, @3], @[@1, @2, @3]], @[@[@1, @2, @3], @[@1, @2, @3], @[@1, @2, @3]], @[@[@1, @2, @3], @[@1, @2, @3], @[@1, @2, @3]]];
    
    NSPredicate * filter = [NSPredicate predicateWithFormat:@"SUBQUERY(SELF.chapters, $chapter, SUBQUERY($chapter, $line, $line CONTAINS[cd] %@).@count > 0).@count > 0", search];
   //filter = [NSPredicate predicateWithFormat:@"SUBQUERY(SELF, $a, $a.@count > 0).@count > 0"];
    NSArray * filtered = [_bibleContent filteredArrayUsingPredicate:filter];
    
    return nil;
}

@end
