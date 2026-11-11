//
//  TESTView.m
//  OPenGLES-Demo
//
//  Created by 王潇 on 2019/5/21.
//  Copyright © 2019 王潇. All rights reserved.
//

#import "TESTView.h"

@implementation TESTView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)vview {
	
	static TESTView *view;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		view = [[TESTView alloc] initWithFrame:CGRectMake(20, 100, 40, 40)];
		view.backgroundColor = [UIColor orangeColor];
	});
	return view;
}

- (void)dealloc {
	NSLog(@"asdd====");

}
@end
