//
//  PressViewController.m
//  DrawTest
//
//  Created by cheng on 15/1/11.
//  Copyright (c) 2015年 chengtz-iMac. All rights reserved.
//

#import "PressViewController.h"
#import "CircProgressBarView.h"
@interface PressViewController ()

@end

@implementation PressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //
        CircProgressBarView * view = [[CircProgressBarView alloc]initWithFrame:CGRectMake(0, 0, 400, 400)];
//        view.radius = 100.0;
//        view.lineWidth = 10.0;
//        [view initCircle];
    
    
    
    [self.view addSubview:view];
    [view setCurrentProgress:90.0 MaxProgress:100.0];
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
