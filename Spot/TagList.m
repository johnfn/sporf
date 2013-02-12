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
@end

@implementation TagList

@synthesize pictures = _pictures;
@synthesize uniqueTags = _uniqueTags;

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
            }
        }
        
        _uniqueTags = [result allObjects];
    }
    
    return _uniqueTags;
}

- (NSArray*)pictures {
    if (!_pictures) {
        _pictures = [FlickrFetcher stanfordPhotos];
    }
    
    return _pictures;
}

@end
