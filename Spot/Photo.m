//
//  Photo.m
//  Spot
//
//  Created by Grant Mathews on 2/12/13.
//  Copyright (c) 2013 johnfn. All rights reserved.
//

#import "Photo.h"
#import "FlickrFetcher.h"

@interface Photo()
@property (nonatomic, strong) NSDictionary* dict;
@end

@implementation Photo

- (Photo*)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    if (self) {
        self.dict = dict;
    }
    
    return self;
}

- (NSDictionary*)data {
    return self.dict;
}

- (NSURL*)url {
    return [FlickrFetcher urlForPhoto:self.dict format:FlickrPhotoFormatLarge];
}

- (NSString*)detail {
    NSDictionary *descDict = [self.dict objectForKey:@"description"];
    
    return [descDict objectForKey:@"_content"];
}

- (NSString*)title {
    return [self.dict objectForKey:@"title"];
}

@end
