//
//  Demo3ViewController.h
//  OPenGLES-Demo
//
//  Created by 王潇 on 2019/5/15.
//  Copyright © 2019 王潇. All rights reserved.
//

#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AGLKVertexAttribArrayBuffer;

@interface Demo3ViewController : GLKViewController {
	AGLKVertexAttribArrayBuffer *vertexBuffer;
}

/// 
@property (strong, nonatomic) GLKBaseEffect                     *baseEffect;

///
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer       *vertexBuffer;

@end

NS_ASSUME_NONNULL_END
