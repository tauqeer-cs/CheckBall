//
//  FriendsViewController.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 23/07/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "FriendsViewController.h"
#import "AcceptRejectTableViewCell.h"
#import "FriendTableViewCell.h"

@interface FriendsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AcceptRejectTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellAcceptReject"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellFriend"];
    
    self.title = @"Friends";
    
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
  
        return   @"Friend Request";
        
    }
    
  return   @"Your Friends";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex{
    
    
    return 4;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        
        UITableViewCell *currentCell = [tableView dequeueReusableCellWithIdentifier:@"cellAcceptReject"];
        
        return currentCell;
        
    }
    UITableViewCell *currentCell = [tableView dequeueReusableCellWithIdentifier:@"cellFriend"];
    return currentCell;
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
