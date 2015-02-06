//
//  Chat.m
//  ParseChat
//
//  Created by Tejas Lagvankar on 2/5/15.
//  Copyright (c) 2015 Yahoo!. All rights reserved.
//

#import "Chat.h"

@implementation Chat

- (id)initWithDictionary:(NSDictionary *)dictionary {

    self = [super init];

    if (self) {
        self.text = dictionary[@"text"];
        self.user = dictionary[@"user"];
    }

    return self;
}

+ (NSArray *)chatsWithArray:(NSArray *)array {

    NSMutableArray *chats = [NSMutableArray array];
    for (NSDictionary *dictionary in array) {
        Chat *chat = [[Chat alloc] initWithDictionary:dictionary];
        [chats addObject:chat];
    }
    return chats;
}

@end
