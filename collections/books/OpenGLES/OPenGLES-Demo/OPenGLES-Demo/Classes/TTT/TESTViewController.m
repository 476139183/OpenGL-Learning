//
//  TESTViewController.m
//  OPenGLES-Demo
//
//  Created by 王潇 on 2019/5/21.
//  Copyright © 2019 王潇. All rights reserved.
//

#import "TESTViewController.h"
#import "TESTView.h"

@interface TESTViewController ()

@property (nonatomic, strong) UIView *testView;

@end

@implementation TESTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
//	self.testView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 30, 30)];
//	self.testView.backgroundColor = [UIColor redColor];
//
//	[self.view addSubview:self.testView];
	
	///
//	[self.view addSubview:[TESTView vview]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	NSLog(@"=== 开始");
	[UIView animateWithDuration:20 animations:^{
		[TESTView vview].frame = CGRectMake(300, 400, 30, 30);
		NSLog(@"====AAA!Q");
	} completion:^(BOOL finished) {
		NSLog(@"====AAA!Q222");
		[TESTView vview].frame = CGRectMake(300, 400, 100, 100);
	}];
	
}

- (void)dealloc {
	NSLog(@"+====== HHHHH");
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
