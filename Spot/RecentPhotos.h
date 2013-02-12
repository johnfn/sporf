//
//  RecentPhotos.h
//  Spot
//
//  Created by Grant Mathews on 2/12/13.
//  Copyright (c) 2013 johnfn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentPhotos : NSObject

+ (void)addPhoto:(NSDictionary*)photo;
+ (NSArray*)getRecentPhotos;
+ (NSURL*)urlOfPhotoWithIndex:(int)index;
+ (NSString*)titleOfPhotoWithIndex:(int)index;
+ (NSString*)descriptionOfPhotoWithIndex:(int)index;

@end
