//
//  BMViewController.m
//  BiblioMania
//
//  Created by Владимир on 15.01.14.
//  Copyright (c) 2014 V. All rights reserved.
//

#import "BMViewController.h"
#import <RaptureXML/RXMLElement.h>

@interface BMViewController () <YSKSpeechRecognitionViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *speakButton;
@property(nonatomic, retain) YSKSpeechRecognitionViewController *recognizerViewController;
@property (nonatomic, strong) NSMutableArray *bibliaContent;
@end

@implementation BMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) startSpeechRecognition
{
    self.recognizerViewController = [[YSKSpeechRecognitionViewController alloc] initWithLangauge:@"ru-RU" model:@"general"];
    self.recognizerViewController.delegate = self;
    
    [self presentViewController:self.recognizerViewController animated:YES completion:^{}];
    
    [self.recognizerViewController start];

}

#pragma mark - YSK delegate methods

- (void) speechRecognitionViewController:(YSKSpeechRecognitionViewController *)speechRecognitionViewController didFailWithError:(NSError *)error
{
    NSLog(@"Fail with error: %@", error.localizedDescription);
}

- (void)speechRecognitionViewController:(YSKSpeechRecognitionViewController *)speechRecognitionViewController didFinishWithResult:(NSString *)result
{
    NSLog(@"Result: %@", result);
}

#pragma mark - actions

- (IBAction)startButtonPressed:(UIButton *)sender {
    [self startSpeechRecognition];
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
    id plist = [NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListMutableContainersAndLeaves format:&format error:&error];
    if (!error)
    {
        _bibliaContent = plist;
    }
    else
    {
        NSLog(@"error: %@", error);
    }
}

- (IBAction)showButtonPressed:(id)sender {
    
}

//- (void) XMLtoPlist
//{
//    NSMutableArray *content = [NSMutableArray array];
//    NSError *error = nil;
//    RXMLElement *bible = [RXMLElement elementFromXMLFile:@"biblia.xml"];
//    [bible iterate:@"BOOK" usingBlock:^(RXMLElement *book) {
//        NSMutableDictionary *bookDict = [NSMutableDictionary dictionary];
//        NSMutableArray *chapters = [NSMutableArray array];
//        [bookDict setObject:[book attribute:@"name"] forKey:@"name"];
//        [book iterate:@"CHAPTER" usingBlock:^(RXMLElement *chapter) {
//            NSMutableArray *lines = [NSMutableArray array];
//            [chapter iterate:@"LINE" usingBlock:^(RXMLElement *line) {
//                [lines addObject:[line text]];
//            }];
//            [chapters addObject:lines];
//        }];
//        [bookDict setObject:chapters forKey:@"chapters"];
//        [content addObject:bookDict];
//    }];
//    NSData *representation = [NSPropertyListSerialization dataWithPropertyList:content
//                                                                        format:NSPropertyListBinaryFormat_v1_0
//                                                                       options:0
//                                                                         error:&error];
//    if (!error)
//    {
//        BOOL ok = [representation writeToFile:[NSHomeDirectory() stringByAppendingFormat:@"/biblia.bplist"] atomically:YES];
//        if (ok)
//        {
//            NSLog(@"ok!");
//        }
//        else
//        {
//            NSLog(@"error writing to file");
//        }
//    }
//    else
//    {
//        NSLog(@"error: %@", error);
//    }
//    
//}

@end
