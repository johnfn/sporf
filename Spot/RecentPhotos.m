//
//  RecentPhotos.m
//  Spot
//
//  Created by Grant Mathews on 2/12/13.
//  Copyright (c) 2013 johnfn. All rights reserved.
//

#import "RecentPhotos.h"
#import "FlickrFetcher.h"

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
    
    if ([mutablePhotos containsObject:photo]) {
        return;
    }
    
    [mutablePhotos addObject:photo];
    
    [defaults setObject:mutablePhotos forKey:DEFAULTS_PHOTO_KEY];
}

+ (NSArray*)getRecentPhotos {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults objectForKey:DEFAULTS_PHOTO_KEY];
}

+ (NSURL*)urlOfPhotoWithIndex:(int)index {
    NSDictionary *photoDict = [RecentPhotos getRecentPhotos][index];
    return [FlickrFetcher urlForPhoto:photoDict format:FlickrPhotoFormatLarge];
}

@end
