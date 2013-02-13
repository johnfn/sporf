//
//  Photo.h
//  Spot
//
//  Created by Grant Mathews on 2/12/13.
//  Copyright (c) 2013 johnfn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

- (Photo*)initWithDictionary:(NSDictionary*)dict;

- (NSURL*)url;
- (NSString*)detail;
- (NSString*)title;

@end
