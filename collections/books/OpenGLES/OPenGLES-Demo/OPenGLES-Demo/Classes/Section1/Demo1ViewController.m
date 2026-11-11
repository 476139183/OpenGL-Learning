//
//  Demo1ViewController.m
//  OPenGLES-Demo
//
//  Created by 王潇 on 16/10/27.
//  Copyright © 2016年 王潇. All rights reserved.
//

#import "Demo1ViewController.h"

@interface Demo1ViewController ()

@property (nonatomic, strong) NSString		*testString;

@end

@implementation Demo1ViewController

/// 1. 定义C结构体 SceneVertex
/// 用来保存一个 GLKVector3 类型的成员 positionCoords
/// GLKit 的 GLKVector3 类型保存了3个坐标: X、Y 和 Z
typedef struct {
	GLKVector3  positionCoords;
}
SceneVertex;

/// 2. vertices 变量是一个用定点数据初始化的普通C数组, 这个变量用来定义一个三角形。
/// 默认用于一个OpenGL上下文的可见坐标系是分别沿着X、Y、Z轴 从-1.0延伸到1.0的。
static const SceneVertex vertices[] = {
	/// X  , Y    , Z
	{{-1.0f, -0.5f, 0.0}}, // lower left corner
	{{ 1.0f, -0.5f, 0.0}}, // lower right corner
	{{-0.0f,  0.5f, 1.0}}  // upper left corner
};


/// 加载View
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.testString = @"testString";
	
	/// 3. -viewDidLoad 方法会将继承的view属性的值转换为GLKView类型。
	GLKView *view = (GLKView *)self.view;
	NSAssert([view isKindOfClass:[GLKView class]],
			 @"View controller's view is not a GLKView");

	/// 4. 设置 OPenGL ES API 版本
	view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
	
	/// 5. 设置当前上下文
	/// 一个应用可以使用多个上下文。 EAGLContext +setCurrentContext: 方法会为接下来的 OpenGL ES 运算设置将会用到的上下文。
	[EAGLContext setCurrentContext:view.context];
	
	// Create a base effect that provides standard OpenGL ES 2.0
	// Shading Language programs and set constants to be used for
	// all subsequent rendering
	/// GLKBaseEffect旨在简化当今许多OpenGL应用程序常见的视觉效果
	self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
//    self.baseEffect.lightModelTwoSided = GL_TRUE;
//    self.baseEffect.colorMaterialEnabled = GL_TRUE;
	self.baseEffect.constantColor = GLKVector4Make(
												   1.0f, // Red
												   .0f, // Green
												   .0f, // Blue
												   1.0f);// Alpha
	
	// Set the background color stored in the current context
	/// glClearColor() 函数设置当前OpenGL ES 的上下文的 清除颜色。
	glClearColor(0.0f, 1.0f, 0.0f, 1.0f); // background color
	
	// Generate, bind, and initialize contents of a buffer to be
	// stored in GPU memory
	// STEP 1
	/// 为缓存生成一个独一无二的标识符
	glGenBuffers(1, &vertexBufferID);
	/// 为接下来的运算绑定缓存
	glBindBuffer(GL_ARRAY_BUFFER,  // STEP 2
				 vertexBufferID);
	/// 复制数据到缓存中
	glBufferData(                  // STEP 3
				 GL_ARRAY_BUFFER,  // Initialize buffer contents
				 sizeof(vertices), // Number of bytes to copy
				 vertices,         // Address of bytes to copy
				 GL_STATIC_DRAW);  // Hint: cache in GPU memory
}

/////////////////////////////////////////////////////////////////
// GLKView delegate method: Called by the view controller's view
// whenever Cocoa Touch asks the view controller's view to
// draw itself. (In this case, render into a frame buffer that
// shares memory with a Core Animation Layer)
/// -glkView:drawInRect: 方法是 GLKView类的委托方法。
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
	[self.baseEffect prepareToDraw];
	
	// Clear Frame Buffer (erase previous drawing)
	/// 调用 glClear() 函数来设置当前绑定的帧缓存的像素颜色渲染缓存中的每一个像素的颜色为当前使用
	/// glClearColor() 函数设置的值。
	glClear(GL_COLOR_BUFFER_BIT);
	
	// Enable use of positions from bound vertex buffer
	/// 通过调用 glEnableVertexAttribArray() 来启动定点缓存渲染操作。
	/// OpenGL ES 锁支持的每一个渲染操作都可以单独地使用保存在当前OpenGL ES 上下文中的设置来开启或关闭。
	glEnableVertexAttribArray(GLKVertexAttribPosition);							// STEP 4
	
	/// glVertexAttribPointer() 函数会告诉 OpenGL ES定点数据在哪里, 以及怎么解释为每个定点保存的数据。
	glVertexAttribPointer(          // STEP 5
						  GLKVertexAttribPosition,
						  3,                   // three components per vertex
						  GL_FLOAT,            // data is floating point
						  GL_FALSE,            // no fixed point scaling
						  sizeof(SceneVertex), // no gaps in data
						  NULL);               // NULL tells GPU to start at
	// beginning of bound buffer
	
	// Draw triangles using the first three vertices in the
	// currently bound vertex buffer
	/// 通过调用 glDrawArrays() 来执行绘图。
	glDrawArrays(GL_TRIANGLES,      // STEP 6
				 0,  // Start with first vertex in currently bound buffer
				 3); // Use three vertices from currently bound buffer
}


/////////////////////////////////////////////////////////////////
// Called when the view controller's view has been unloaded
// Perform clean-up that is possible when you know the view
// controller's view won't be asked to draw again soon.
- (void)viewDidUnload {
	[super viewDidUnload];
	
	// Make the view's context current
	GLKView *view = (GLKView *)self.view;
	[EAGLContext setCurrentContext:view.context];
	
	// Delete buffers that aren't needed when view is unloaded
	if (0 != vertexBufferID) {
		// STEP 7
		/// 删除不再需要的定点缓存和上下文。
		glDeleteBuffers (1, &vertexBufferID);
		/// 设置 vertexBufferID 为 0 避免了在对应的缓存被删除以后还使用其无效的标识符。
		vertexBufferID = 0;
	}
	
	// Stop using the context created in -viewDidLoad
	((GLKView *)self.view).context = nil;
	[EAGLContext setCurrentContext:nil];
}

@end
