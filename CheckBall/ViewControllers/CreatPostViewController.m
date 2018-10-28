//
//  CreatPostViewController.m
//  CheckBall
//
//  Created by Tauqeer Ahmed on 23/10/2018.
//  Copyright © 2018 plego. All rights reserved.
//

#import "CreatPostViewController.h"

@interface CreatPostViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myImage;

@end

@implementation CreatPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.myImage roundTheView];
    
}
- (IBAction)btnCloseTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (IBAction)btnShareTapped:(id)sender {

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
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
