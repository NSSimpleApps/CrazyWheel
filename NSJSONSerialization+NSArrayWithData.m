//
//  NSJSONSerialization+NSArrayWithData.m
//  CrazyWheel
//
//  Created by NSSimpleApps on 09.03.15.
//  Copyright (c) 2015 NSSimpleApps. All rights reserved.
//

#import "NSJSONSerialization+NSArrayWithData.h"

@implementation NSJSONSerialization (NSArrayWithData)

+ (NSArray*)arrayWithData:(NSData*)data {
    
    if (!data) {
        
        return nil;
    }
    
    NSError *error = nil;
    
    NSArray *JSONArray = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    
    if (error) {
        
        return nil;
    }
    
    return JSONArray;
}

@end
