//
//  NSDictionary+Verified.m
//
//  Created by alexruperez on 08/05/13.
//  Copyright (c) 2013 alexruperez. All rights reserved.
//

#import "NSDictionary+Verified.h"

@implementation NSDictionary (Verified)

- (id)verifiedObjectForKey:(id)aKey
{
    if ([self objectForKey:aKey] && ![[self objectForKey:aKey] isKindOfClass:[NSNull class]]) return [self objectForKey:aKey];
    return nil;
}

- (BOOL)checkKey:(NSString *)key className:(NSString *)className
{
    BOOL success = NO;
    id obj = self[key];
    if ( obj != nil ) {
        if ( obj != (id)[NSNull null] ) {
            success = YES;
        }
        else {
            NSLog(@"Warning! %@: %@ section is empty.", className, key);
        }
    }
    else {
        NSLog(@"Warning! %@: %@ section is not found.", className, key);
    }
    
    return success;
}

@end