//
//  JSONData.h
//  CrazyWheel
//
//  Created by NSSimpleApps on 09.03.15.
//  Copyright (c) 2015 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONData : NSObject

@property (copy, nonatomic) NSNumber* ID;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *text;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (BOOL)isEqualTo:(JSONData*)otherData;

//+ (NSArray *)arrayForJSONArray:(NSArray *)jsonArray;

@end
