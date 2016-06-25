//
//  ViewController.m
//  CollectionViewDemo
//
//  Created by rong on 16/6/21.
//  Copyright © 2016年 com.aihuo. All rights reserved.
//

#import "ViewController.h"
#import "CommonViewController.h"
#import "FlowViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"CollectionViewDemo";
}

- (IBAction)clickCommonBtn:(id)sender {
    CommonViewController *commonVC = [[CommonViewController alloc] init];
    [self.navigationController pushViewController:commonVC animated:YES];
}

- (IBAction)clickFlowBtn:(id)sender {
    FlowViewController *flowVC = [[FlowViewController alloc] init];
    [self.navigationController pushViewController:flowVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
