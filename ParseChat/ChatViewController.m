//
//  ChatViewController.m
//  ParseChat
//
//  Created by Tejas Lagvankar on 2/5/15.
//  Copyright (c) 2015 Yahoo!. All rights reserved.
//

#import "ChatViewController.h"
#import "Parse.h"
#import "ChatCell.h"

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *chatText;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *chats;

@property (nonatomic, strong) ChatCell *dummyCell;

- (void) reloadChats;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.chats = [NSArray array];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    [self.tableView registerNib:[UINib nibWithNibName:@"ChatCell" bundle:nil] forCellReuseIdentifier:@"ChatCell"];

    [self reloadChats];
}

#pragma mark - UI Bindings

- (IBAction)onSendChat:(id)sender {
    PFObject *message = [PFObject objectWithClassName:@"Message"];
    message[@"text"] = self.chatText.text;
    message[@"user"] = [PFUser currentUser];
    [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (succeeded) {
//            // The object has been saved.
//        } else {
//            // There was a problem, check error.description
//        }

        self.chatText.text = @"";
        [self reloadChats];
    }];
}

#pragma mark - TableView Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chats.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
    [cell setChat:self.chats[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self configureCell:self.dummyCell forRowAtIndexPath:indexPath];
    [self.dummyCell layoutIfNeeded];

    CGSize size = [self.dummyCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1;
}

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[ChatCell class]])
    {
        ChatCell *textCell = (ChatCell *)cell;
        [textCell setChat:self.chats[indexPath.row]];
    }
}
- (ChatCell *)dummyCell {

    if (!_dummyCell) {
        _dummyCell = [self.tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
    }
    return _dummyCell;

}



#pragma mark - Private methods

- (void)reloadChats {

    PFQuery *query = [PFQuery queryWithClassName:@"Message"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d chats.", objects.count);
            self.chats = [Chat chatsWithArray:objects];

            [self.tableView reloadData];

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
