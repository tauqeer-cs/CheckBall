//
//  MessageListingViewController.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 23/07/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "MessageListingViewController.h"
#import "MessageListingTableViewCell.h"
//#import "ChatViewController.h"
#import "FriendTableViewCell.h"
#import "AcceptRejectTableViewCell.h"
#import "ChatViewController.h"

@interface MessageListingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MessageListingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Conversations";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MessageListingTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellMessage"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellFriend"];
    
    self.tableView.rowHeight = 75;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            
            sectionName = @"Messages";
            break;
        case 1:
            sectionName = @"Friends";
            break;
            // ...
        default:
            break;
    }
    return sectionName;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    
    
    return 4;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    

    MessageListingTableViewCell *currentCell = [tableView dequeueReusableCellWithIdentifier:@"cellMessage"];
    
    if (indexPath.section == 1) {
        
        
        AcceptRejectTableViewCell * friendCell = [tableView dequeueReusableCellWithIdentifier:@"cellFriend"];;
        
        [friendCell.btnMessage removeFromSuperview];
        
        
        return friendCell;
        
    }
    [currentCell.btnMessage addTarget:self action:@selector(messageTapped:) forControlEvents:UIControlEventTouchUpInside];
    

    
    return currentCell;
    
}

-(void)messageTapped:(UIButton *)button
{
    
    
    ChatViewController *chatVC = [ChatViewController new];
    chatVC.title = @"";
    [self.navigationController pushViewController:chatVC animated:true];
    
    
    
    return;
    
    //ChatViewController *chatView = [[ChatViewController alloc] initWithNibName:@"ChatViewController" bundle:nil];
    
    //[self.navigationController showViewController:chatView sender:self];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
