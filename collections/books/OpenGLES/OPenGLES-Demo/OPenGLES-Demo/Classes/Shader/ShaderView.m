//
//  ShaderView.m
//  OPenGLES-Demo
//
//  Created by 王潇 on 2019/5/22.
//  Copyright © 2019 王潇. All rights reserved.
//

#import "ShaderView.h"
#import <OpenGLES/ES3/gl.h>

@interface ShaderView ()

/// 
@property (nonatomic, strong) CAEAGLLayer		*myLayer;
/// 图层
@property (nonatomic, strong) EAGLContext		*myContext;


@end

@implementation ShaderView

/// 设置 layer
+ (Class)layerClass {
	return [CAEAGLLayer class];
}

///
- (void)layoutSubviews {
	[super layoutSubviews];
	
	
}

/// 设置 layer
- (void)setupLayer {
	
	/// 获取 当前layer
	self.myLayer = (CAEAGLLayer *)self.layer;

	///
	self.contentScaleFactor = [UIScreen mainScreen].scale;
	self.myLayer.opaque = YES;
	
	/// 设置 绘制属性
	self.myLayer.drawableProperties = @{kEAGLDrawablePropertyRetainedBacking : @(NO),
										kEAGLDrawablePropertyColorFormat : kEAGLColorFormatRGBA8};
	
}

/// 设置上下文
- (void)setupContent {
	
	/// 创建上下文 设置API版本
	EAGLContext *content = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
	
	[EAGLContext setCurrentContext:content];
	
	self.myContext = content;
}


@end
