// 
//  SKAnswer.m
//  StackKit
//
//  Created by Dave DeLong on 1/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SKAnswer.h"
#import "SKConstants_Internal.h"
#import "SKObject+Private.h"
#import "SKQuestion.h"

@implementation SKAnswer 

@dynamic accepted;
@dynamic question;

+ (NSDictionary *)APIAttributeToPropertyMapping {
    static NSDictionary *mapping = nil;
    if (!mapping) {
        mapping = [[super APIAttributeToPropertyMapping] mutableCopy];
        [(NSMutableDictionary *)mapping addEntriesFromDictionary:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                  @"postID", SKAPIAnswer_ID, // inherited from SKPost
                                                                  @"accepted", SKAPIAccepted,
                                                                  @"question", SKAPIQuestion_ID,
                                                                  nil]];
    }
    return mapping;
}

+ (NSString *) apiResponseDataKey {
	return @"answers";
}

+ (NSString *) apiResponseUniqueIDKey {
	return SKAPIAnswer_ID;
}

- (NSNumber *) answerID {
    return [self postID];
}

- (id)transformValueToMerge:(id)value forRelationship:(NSString *)relationship {
    if ([relationship isEqual:@"question"]) {
        return [SKQuestion objectMergedWithDictionary:[NSDictionary dictionaryWithObject:value forKey:SKAPIQuestion_ID] inSite:[self site]];
    }
    return [super transformValueToMerge:value forRelationship:relationship];
}

@end
