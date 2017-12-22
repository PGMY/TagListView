//
//  ViewController.m
//  TagListView
//
//  Created by PGMY on 2017/12/22.
//  Copyright © 2017年 PGMY. All rights reserved.
//

#import "ViewController.h"
#import "TagListView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TagListView *tagListView = [[TagListView alloc] initWithFrame:CGRectMake(10, 50, 300, 500)];
    [tagListView setupTags:[@[@"ああああああああああああ",@"いいいいいい",@"ううううううううううううううううううううう",@"ええええええ",@"おおおおおおお",@"かか",@"きききき",@"くく",@"け"] mutableCopy]];
    [self.view addSubview:tagListView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
