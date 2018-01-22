//
//  SelectedAccountTypeViewController.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 11/28/17.
//  Copyright © 2017 plego. All rights reserved.
//

#import "SelectedAccountTypeViewController.h"
#import "SelectEmailViewController.h"

@interface SelectedAccountTypeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblAsAPrayer;
@property (weak, nonatomic) IBOutlet UILabel *lblAsAUser;

@property (weak, nonatomic) IBOutlet UILabel *lblAsAPrayerExplaination;
@property (weak, nonatomic) IBOutlet UILabel *lblAsAUserExplaination;
@property (weak, nonatomic) IBOutlet UIView *viewAsAPrayerExplaination;
@property (weak, nonatomic) IBOutlet UIView *viewAsAUserExplaination;


@property (nonatomic) BOOL isTrainer;

@end

@implementation SelectedAccountTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.viewAsAUserExplaination.layer.cornerRadius = 5.0;
    self.viewAsAPrayerExplaination.layer.cornerRadius = 5.0;
   
    self.lblAsAUser.text = @"As a Trainer";
    
    
    self.lblAsAUserExplaination.text = @"Loren ipsum dolor sit amet, consectetur adipiscing elit Quisque valutpat dui sit amet odio porttitor aliquam.";
    
    
    self.lblAsAPrayerExplaination.text = @"Loren ipsum dolor sit amet, consectetur adipiscing elit Quisque valutpat dui sit amet odio porttitor aliquam.";
    
   
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(trainerTapped)];
    [self.viewAsAPrayerExplaination addGestureRecognizer:singleFingerTap];
    
    
    
    UITapGestureRecognizer *singleFingerTap2 =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(playerTapped)];
    [self.viewAsAUserExplaination addGestureRecognizer:singleFingerTap2];
    
    
    
    
}

-(void)playerTapped{
 
    NSLog(@"");
    
    self.isTrainer = YES;
    
    [self performSegueWithIdentifier:@"segueEmail" sender:self];
}

-(void)trainerTapped{
    
    NSLog(@"");
    self.isTrainer = NO;
    
    [self performSegueWithIdentifier:@"segueEmail" sender:self];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if ([segue.identifier isEqualToString:@"segueEmail"]) {
        
        SelectEmailViewController * destination = (SelectEmailViewController *)segue.destinationViewController;
        destination.comingAsTrainer = self.isTrainer;
        
        
        if (self.signingWithFB) {
            
            destination.signingWithFB = self.signingWithFB;
            destination.fbAccount = self.fbAccount;
            destination.fbName = self.fbName;
            
            destination.fbEmail = self.fbEmail;
            
            
     
        }
        
    }
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
