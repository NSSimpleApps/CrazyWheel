//
//  DataController.h
//  CrazyWheel
//
//  Created by NSSimpleApps on 04.03.15.
//  Copyright (c) 2015 NSSimpleApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableContentsControllerDelegate <NSObject>

@required

- (void)controllerWillChangeContent;
- (void)controllerDidChangeContent;
 
- (void)changeContentWithIndexesForDelete:(NSIndexSet *)indexesForDelete
                         indexesForInsert:(NSIndexSet *)indexesForInsert
                         indexesForReload:(NSIndexSet *)indexesForReload;

@end

@class JSONData;

@interface TableContentsController : NSObject

@property (weak, nonatomic) id<TableContentsControllerDelegate> delegate;

- (void)startUpdatingWithTimeInterval:(NSTimeInterval)timeInterval URL:(NSURL*)URL;

- (void)stopUpdating;

- (JSONData*)JSONDataAtIndex:(NSInteger)index;

@property (NS_NONATOMIC_IOSONLY, readonly) NSInteger count;

@end
