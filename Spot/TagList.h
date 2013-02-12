//
//  TagList.h
//  Spot
//
//  Created by Grant Mathews on 2/11/13.
//  Copyright (c) 2013 johnfn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagList : NSObject
- (NSArray*)uniqueTags;
- (int)numPhotosWithTag:(NSString*)tag;
@end
