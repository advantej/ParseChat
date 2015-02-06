//
//  ChatCell.h
//  ParseChat
//
//  Created by Tejas Lagvankar on 2/5/15.
//  Copyright (c) 2015 Yahoo!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chat.h"

@interface ChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *chatMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

- (void) setChat:(Chat *) chat;

@end
