//
//  FirstViewController.m
//  DittyDemo
//
//  Created by Zero.D.Saber on 04/05/2017.
//  Copyright © 2017 Zero.D.Saber. All rights reserved.
//

#import "FirstViewController.h"
#import "DittyViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dittyAction:(id)sender
{
    DittyViewController *ditty = [DittyViewController new];
    [self presentViewController:ditty animated:YES completion:nil];
}

@end
