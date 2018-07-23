//
//  FeedListViewController.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 22/07/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "FeedListViewController.h"
#import "VideoCollectionViewCell.h"
#import "MessageListingViewController.h"

@interface FeedListViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageIcon;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation FeedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"message-small-list"] style:UIBarButtonItemStylePlain target:self action:@selector(messageButtonTapped)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SideMenuButton"] style:UIBarButtonItemStylePlain target:self action:@selector(messageButtonTapped)];

    
    
    self.containerView.layer.borderColor = [UIColor grayColor].CGColor;
    self.containerView.layer.borderWidth = 1.0;
    [self.smallImageIcon roundTheView];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"VideoCollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:@"cellVideoNews"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"NewsItemCollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:@"cellNewsText"];
    
    self.containerView.layer.cornerRadius = 10;
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    [imageView setFrame:CGRectMake(0, 5, 30, 30)];
    
    
    UIView* titleView;
    
    if (IS_IPHONE_5) {
        titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        
        
    }
    else if (IS_IPHONE_6) {
        titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 44)];
        
        
    }
    else
    {
        titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 44)];
    }

    [titleView addSubview:imageView];
    //[titleView setBackgroundColor:[UIColor yellowColor]];
    
    
    UIView * lineFrame = [UIView new];
    [lineFrame setFrame:CGRectMake(0, 42, titleView.frame.size.width, 1)];
    [lineFrame setBackgroundColor:[UIColor whiteColor]];
    
    [titleView addSubview:lineFrame];
    
    UITextField * currentTextField = [UITextField new];
    [currentTextField setFrame:CGRectMake(40, 0, titleView.frame.size.width-40, 44)];
    currentTextField.placeholder = @"Search";
    [titleView addSubview:currentTextField];
    currentTextField.delegate = self;
    currentTextField.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = titleView;
    
    

    //
    
    
    
}

-(void)messageButtonTapped
{
    
    MessageListingViewController * destination = [[MessageListingViewController alloc] initWithNibName:@"MessageListingViewController" bundle:nil];
    
    
    [self.navigationController showViewController:destination sender:self];
    

    //messageButtonTapped
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    
    return 4;
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VideoCollectionViewCell *currentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellVideoNews" forIndexPath:indexPath];
    
    if (indexPath.row % 2 == 1) {
        
        currentCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellNewsText" forIndexPath:indexPath];
        
    }
    return currentCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 1) {
        
           return CGSizeMake(self.collectionView.frame.size.width-24, 120);
    }
    
    return CGSizeMake(self.collectionView.frame.size.width-24, 190);
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
