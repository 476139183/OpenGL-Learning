//
//  ViewController.m
//  OPenGLES-Demo
//
//  Created by 王潇 on 16/10/27.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "ViewController.h"
#import "Demo1ViewController.h"
#import "Demo2ViewController.h"
#import "Demo3ViewController.h"
#import "Section2Demo1Controller.h"
#import "Section4Demo1Controller.h"
#import "TESTViewController.h"
#import "Shader1Controller.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

/// 列表
@property (nonatomic, strong) UITableView		*tableView;
///
@property (nonatomic, strong) NSArray			*titles;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.titles = @[@"Section1",					// 0
					@"Section1-Demo1",
					@"Section1-Demo2",
					@"Section1-Demo3",
					@"Section2-Demo1",
					@"Section2-Demo2",
					@"Shader1Controller",];
	
	/// 初始化界面
	[self setupView];
}

/// 初始化界面
- (void)setupView {
	
	/// 控制器背景色
	self.view.backgroundColor = [UIColor whiteColor];
	
	/// 创建列表
	self.tableView = ({
		UITableView *tableView 	= [[UITableView alloc] initWithFrame:self.view.bounds
															   style:UITableViewStyleGrouped];
		tableView.delegate 		= self;
		tableView.dataSource 	= self;
		tableView.estimatedSectionHeaderHeight = 0;
		
		[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
		[self.view addSubview:tableView];
		tableView;
	});
	
}

#pragma mark - UITableViewDataSource
///
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.titles.count;
}

///
- (UITableViewCell *)tableView:(UITableView *)tableView
		 						cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
	cell.textLabel.text = self.titles[indexPath.row];
	return cell;
}

#pragma mark - UITableViewDelegate
/// 点击列表
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	switch (indexPath.row) {
		case 0: {
			TESTViewController *demoVC = [[TESTViewController alloc] init];
//			Demo1ViewController *demoVC = [[Demo1ViewController alloc] init];
			[self.navigationController pushViewController:demoVC animated:YES];
		}
			break;
			
		case 1: {
			Demo2ViewController *demoVC = [[Demo2ViewController alloc] init];
			[self.navigationController pushViewController:demoVC animated:YES];
		}
			break;
			
		case 2: {
			Demo3ViewController *demoVC = [[Demo3ViewController alloc] init];
			[self.navigationController pushViewController:demoVC animated:YES];
		}
			break;
		case 3: {
			Section2Demo1Controller *demoVC = [[Section2Demo1Controller alloc] init];
			[self.navigationController pushViewController:demoVC animated:YES];
		}
			break;
		
		case 4: {
			Section4Demo1Controller *demoVC = [[Section4Demo1Controller alloc] init];
			[self.navigationController pushViewController:demoVC animated:YES];
		}
			break;

		case 6: {
			Shader1Controller *shaderVC = [Shader1Controller new];
			[self.navigationController pushViewController:shaderVC animated:YES];
		}
			
		default:
			break;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 0.1;
}


@end
