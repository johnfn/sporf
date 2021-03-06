//
//  RecentPhotos.h
//  Spot
//
//  Created by Grant Mathews on 2/12/13.
//  Copyright (c) 2013 johnfn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface RecentPhotos : NSObject

+ (void)addPhoto:(NSDictionary*)photo;
+ (NSArray*)getRecentPhotos;

+ (Photo*)photoAtIndex:(int)index;

@end
