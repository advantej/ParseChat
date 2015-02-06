//
//  Chat.h
//  ParseChat
//
//  Created by Tejas Lagvankar on 2/5/15.
//  Copyright (c) 2015 Yahoo!. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chat : NSObject

@property (nonatomic, strong) NSString *text;

- (id) initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *) chatsWithArray:(NSArray *)array;

@end
