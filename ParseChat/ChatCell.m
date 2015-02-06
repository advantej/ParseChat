//
//  ChatCell.m
//  ParseChat
//
//  Created by Tejas Lagvankar on 2/5/15.
//  Copyright (c) 2015 Yahoo!. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCell

- (void)awakeFromNib {
    // Initialization code
    self.chatMessageLabel.preferredMaxLayoutWidth = self.chatMessageLabel.frame.size.width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setChat:(Chat *)chat {
    self.chatMessageLabel.text = chat.text;
    self.userNameLabel.text = @"anonymous";
    if (chat.user != nil) {
        PFUser *user = chat.user;
        [user fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            self.userNameLabel.text = chat.user.username;
        }];
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.chatMessageLabel.preferredMaxLayoutWidth = self.chatMessageLabel.frame.size.width;
}


@end
