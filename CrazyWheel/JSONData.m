//
//  JSONData.m
//  CrazyWheel
//
//  Created by NSSimpleApps on 09.03.15.
//  Copyright (c) 2015 NSSimpleApps. All rights reserved.
//

#import "JSONData.h"

@implementation JSONData

- (instancetype)init {
    
    return [self initWithDictionary:@{}];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        
        self.ID = dictionary[@"id"];
        self.title = dictionary[@"title"];
        self.text = dictionary[@"text"];
    }
    return self;
}

- (BOOL)isEqualTo:(JSONData*)otherData {
    
    return ([self.ID isEqualToNumber:otherData.ID]) && ([self.title isEqualToString:otherData.title]);
}

@end
