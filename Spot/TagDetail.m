//
//  TagDetail.m
//  Spot
//
//  Created by Grant Mathews on 2/11/13.
//  Copyright (c) 2013 johnfn. All rights reserved.
//

#import "TagDetail.h"
#import "TagList.h"
#import "FlickrFetcher.h"

@interface TagDetail ()
@property (nonatomic) TagList *tagList;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSArray *photoNames;
@end

@implementation TagDetail

- (TagList*)tagList {
    if (!_tagList) {
        _tagList = [[TagList alloc] init];
    }
    
    return _tagList;
}

- (id)initWithTagName:(NSString*)tag {
    self = [super init];
    
    if (self) {
        self.photos = [self.tagList photosWithTag:tag];
    }

    return self;
}

- (Photo*)photoAtIndex:(int)index {
    return [[Photo alloc] initWithDictionary: [self.photos objectAtIndex:index]];
}

- (NSArray*)photoNames {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (NSDictionary *d in self.photos) {
        NSString* title = [d objectForKey:@"title"];
        
        [result addObject:title];
    }
    
    return result;
}

@end
