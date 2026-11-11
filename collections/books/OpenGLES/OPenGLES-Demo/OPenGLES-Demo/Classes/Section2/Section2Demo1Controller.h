//
//  Section2Demo1Controller.h
//  OPenGLES-Demo
//
//  Created by 王潇 on 2019/5/15.
//  Copyright © 2019 王潇. All rights reserved.
//

#import <GLKit/GLKit.h>

@class AGLKVertexAttribArrayBuffer;

NS_ASSUME_NONNULL_BEGIN

@interface Section2Demo1Controller : GLKViewController

@property (strong, nonatomic) GLKBaseEffect  *baseEffect;

@property (strong, nonatomic) AGLKVertexAttribArrayBuffer	*vertexBuffer;

@end

NS_ASSUME_NONNULL_END
