//
//  TagList.m
//  Spot
//
//  Created by Grant Mathews on 2/11/13.
//  Copyright (c) 2013 johnfn. All rights reserved.
//

#import "TagList.h"
#import "FlickrFetcher.h"

@interface TagList ()
@property (readonly, nonatomic) NSArray *tags;
@property (readonly, nonatomic) NSArray *pictures;
@property (readonly, nonatomic) NSArray *uniqueTags;
@property (nonatomic) NSMutableDictionary *tagToPhotoCount;
@end

@implementation TagList

@synthesize pictures = _pictures;
@synthesize uniqueTags = _uniqueTags;

- (void)addTagCount:(NSString*)tag {
    tag = [tag uppercaseString];
    
    if (!self.tagToPhotoCount) {
        self.tagToPhotoCount = [[NSMutableDictionary alloc] init];
    }
    
    int count = 0;
    if ([self.tagToPhotoCount objectForKey:tag] != nil) {
        count = [[self.tagToPhotoCount objectForKey:tag] intValue];
    }
    count += 1;
    
    [self.tagToPhotoCount setObject:[NSNumber numberWithInt:count] forKey:tag];
}

- (NSArray*)uniqueTags {
    if (!_uniqueTags) {
        NSMutableSet *result = [[NSMutableSet alloc] init];
        
        for (NSDictionary *d in self.pictures) {
            NSString* tagsForOneItem = [d objectForKey:@"tags"];
            NSArray* split = [tagsForOneItem componentsSeparatedByString:@" "];
            
            for (NSString *s in split) {
                if ([s isEqualToString:@"portrait"]  ||
                    [s isEqualToString:@"landscape"] ||
                    [s isEqualToString:@"cs193pspot"]) continue;
                
                [result addObject:[s capitalizedString]];
                [self addTagCount:s];
            }
        }
        
        _uniqueTags = [result allObjects];
    }
    
    return _uniqueTags;
}

- (int)numPhotosWithTag:(NSString *)tag {
    tag = [tag uppercaseString];
    
    if ([self.tagToPhotoCount objectForKey:tag] != nil) {
        return [[self.tagToPhotoCount objectForKey:tag] intValue];
    } else {
        return 0;
    }
}

- (NSArray*)pictures {
    if (!_pictures) {
        _pictures = [FlickrFetcher stanfordPhotos];
    }
    
    return _pictures;
}

@end
