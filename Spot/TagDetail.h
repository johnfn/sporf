//
//  TagDetail.h
//  Spot
//
//  Created by Grant Mathews on 2/11/13.
//  Copyright (c) 2013 johnfn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface TagDetail : NSObject
- (id)initWithTagName:(NSString*)tag; //designated initializer
- (NSArray*)photoNames;
- (Photo*)photoAtIndex:(int)index;
@end
