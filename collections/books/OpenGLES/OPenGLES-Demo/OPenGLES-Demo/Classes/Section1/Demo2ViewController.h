//
//  Demo2ViewController.h
//  OPenGLES-Demo
//
//  Created by 王潇 on 2019/5/15.
//  Copyright © 2019 王潇. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "AGLKViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface Demo2ViewController : AGLKViewController
{
	GLuint vertexBufferID;
}

@property (strong, nonatomic) GLKBaseEffect *baseEffect;

@end

NS_ASSUME_NONNULL_END
