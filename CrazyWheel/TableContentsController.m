//
//  DataController.m
//  CrazyWheel
//
//  Created by NSSimpleApps on 04.03.15.
//  Copyright (c) 2015 NSSimpleApps. All rights reserved.
//

#import "TableContentsController.h"
#import "NSJSONSerialization+NSArrayWithData.h"
#import "JSONData.h"

@interface TableContentsController ()

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) NSURLSession* URLSession;

@property (strong, nonatomic) NSArray* currentArrayOfData;

@end

@implementation TableContentsController

- (NSURLSession *)URLSession {
    
    if (!_URLSession) {
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfig.allowsCellularAccess = NO;
        [sessionConfig setHTTPAdditionalHeaders:@{@"Accept": @"application/json"}];
        sessionConfig.timeoutIntervalForRequest = 30.0;
        sessionConfig.timeoutIntervalForResource = 60.0;
        sessionConfig.HTTPMaximumConnectionsPerHost = 1;
        
        _URLSession = [NSURLSession sessionWithConfiguration:sessionConfig];
    }
    return _URLSession;
}

- (void)startUpdatingWithTimeInterval:(NSTimeInterval)timeInterval URL:(NSURL*)URL {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                  target:self
                                                selector:@selector(pullDataFromURL)
                                                userInfo:@{@"URL": URL}
                                                 repeats:YES];
}

- (void)pullDataFromURL {
    
    NSURLSessionDataTask *URLSessionDataTask =
    [self.URLSession dataTaskWithURL:[self.timer.userInfo valueForKey:@"URL"]
                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                   
                       if (error) {
                           
                           NSLog(@"%@", error);
                       } else {
                           
                           NSMutableIndexSet *indexesForInsert = [NSMutableIndexSet new];
                           NSMutableIndexSet *indexesForReload = [NSMutableIndexSet new];
                           NSMutableIndexSet *indexesForDelete = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.currentArrayOfData.count)];
                           
                           NSArray *newArrayOfData = [NSJSONSerialization arrayWithData:data];
                           [newArrayOfData enumerateObjectsUsingBlock:^(NSDictionary *newDictionary, NSUInteger newIndex, BOOL *stop) {
                               
                               JSONData *newData = [[JSONData alloc] initWithDictionary:newDictionary];
                               
                               __block BOOL foundNewDataInCurrentData = NO;
                               [self.currentArrayOfData enumerateObjectsUsingBlock:^(NSDictionary *currentDictionary, NSUInteger currentIndex, BOOL *innerStop) {
                                   
                                   JSONData *currentData = [[JSONData alloc] initWithDictionary:currentDictionary];
                                   
                                   foundNewDataInCurrentData = [newData isEqualTo:currentData];
                                   
                                   if (foundNewDataInCurrentData) {
                                       
                                       [indexesForDelete removeIndex:currentIndex];
                                       
                                       if (![newData.text isEqualToString:currentData.text]) {
                                           [indexesForReload addIndex:currentIndex];
                                       }
                                       
                                       *innerStop = YES;
                                   }
                               }];
                               
                               if (!foundNewDataInCurrentData) {
                                   [indexesForInsert addIndex:newIndex];
                               }
                           }];
                           
                           self.currentArrayOfData = [newArrayOfData copy];
                           
                           dispatch_sync(dispatch_get_main_queue(), ^{
                               
                               [self.delegate controllerWillChangeContent];
                               [self.delegate changeContentWithIndexesForDelete:indexesForDelete
                                                               indexesForInsert:indexesForInsert
                                                               indexesForReload:indexesForReload];
                               [self.delegate controllerDidChangeContent];
                           });
                       }
                   }];
    [URLSessionDataTask resume];
}

- (void)stopUpdating {
    
    [self.timer invalidate];
    self.timer = nil;
}

- (JSONData*)JSONDataAtIndex:(NSInteger)index {
    
    NSDictionary * dict = self.currentArrayOfData[index];
    
    return [[JSONData alloc] initWithDictionary:dict];
}

- (NSInteger)count {
    
    return [self.currentArrayOfData count];
}

- (void)dealloc {
    
    [self stopUpdating];
}
@end
