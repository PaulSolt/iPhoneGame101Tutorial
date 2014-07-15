//
//  Store.m
//  GameMenus101 - 4.2
//
//  Created by Paul on 4/14/14.
//  Copyright (c) 2014 Paul Solt. All rights reserved.
//

#import "Store.h"

static NSString *const kGoldenEgg = @"goldenEgg";
static NSString *const kWhiteEgg = @"whiteEgg";

@implementation Store

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if(self) {
        
        _goldenEggCount = [aDecoder decodeIntForKey:kGoldenEgg];
        _whiteEggCount = [aDecoder decodeIntForKey:kWhiteEgg];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    // save data
    [aCoder encodeInt:_goldenEggCount forKey:kGoldenEgg];
    [aCoder encodeInt:_whiteEggCount forKey:kWhiteEgg];
    
}

@end
