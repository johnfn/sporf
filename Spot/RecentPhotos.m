//
//  RecentPhotos.m
//  Spot
//
//  Created by Grant Mathews on 2/12/13.
//  Copyright (c) 2013 johnfn. All rights reserved.
//

#import "RecentPhotos.h"

@implementation RecentPhotos

#define DEFAULTS_PHOTO_KEY @"photos"

+ (void)addPhoto:(NSDictionary *)photo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *photos = [defaults objectForKey:DEFAULTS_PHOTO_KEY];
    NSMutableArray *mutablePhotos;
    if (photos == nil) {
        mutablePhotos = [[NSMutableArray alloc] init];
    } else {
        mutablePhotos = [NSMutableArray arrayWithArray:photos];
    }
    [mutablePhotos addObject:photo];
    
    [defaults setObject:mutablePhotos forKey:DEFAULTS_PHOTO_KEY];
}

+ (NSArray*)getRecentPhotos {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults objectForKey:DEFAULTS_PHOTO_KEY];
}

@end
