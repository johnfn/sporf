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
#define MAX_NUM_RECENT_PHOTOS 5

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
    
    while (mutablePhotos.count > MAX_NUM_RECENT_PHOTOS) {
        [mutablePhotos removeObjectAtIndex:0];
    }
    
    [mutablePhotos addObject:photo];
    
    [defaults setObject:mutablePhotos forKey:DEFAULTS_PHOTO_KEY];
}

+ (NSString*)titleOfPhotoWithIndex:(int)index {
    NSDictionary *photoDict = [RecentPhotos getRecentPhotos][index];
    
    return [photoDict objectForKey:@"title"];
}

+ (NSString*)descriptionOfPhotoWithIndex:(int)index {
    NSDictionary *photoDict = [RecentPhotos getRecentPhotos][index];
    NSDictionary *descDict = [photoDict objectForKey:@"description"];
    
    return [descDict objectForKey:@"_content"];
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
