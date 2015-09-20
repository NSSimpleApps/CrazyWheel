//
//  NSJSONSerialization+ArrayWithData.m
//  CrazyWheel
//
//  Created by NSSimpleApps on 20.09.15.
//  Copyright © 2015 NSSimpleApps. All rights reserved.
//

#import "NSJSONSerialization+ArrayWithData.h"

@implementation NSJSONSerialization (ArrayWithData)

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
