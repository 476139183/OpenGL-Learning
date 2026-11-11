//
//  ViewController.m
//  OpenGLES_Ch3_3
//

#import "OpenGLES_Ch3_3ViewController.h"
#import "AGLKVertexAttribArrayBuffer.h"
#import "AGLKContext.h"

@interface GLKEffectPropertyTexture (AGLKAdditions)

///
- (void)aglkSetParameter:(GLenum)parameterID value:(GLint)value;
   
@end


///
@implementation GLKEffectPropertyTexture (AGLKAdditions)

///
- (void)aglkSetParameter:(GLenum)parameterID value:(GLint)value {
	
	/// 绑定纹理
   	glBindTexture(self.target, self.name);

	///
   	glTexParameteri(
				   	self.target,
				   	parameterID,
				   	value);
}
   
@end


///
@implementation OpenGLES_Ch3_3ViewController

@synthesize baseEffect;
@synthesize vertexBuffer;
@synthesize shouldUseLinearFilter;
@synthesize shouldAnimate;
@synthesize shouldRepeatTexture;
@synthesize sCoordinateOffset;

/////////////////////////////////////////////////////////////////
// This data type is used to store information for each vertex
typedef struct {
   GLKVector3  positionCoords;
   GLKVector2  textureCoords;
}
SceneVertex;

/////////////////////////////////////////////////////////////////
// Define vertex data for a triangle to use in example
static SceneVertex vertices[] = {
   {{-0.5f, -0.5f, 0.0f}, {0.0f, 0.0f}}, // lower left corner
   {{ 0.5f, -0.5f, 0.0f}, {1.0f, 0.0f}}, // lower right corner
   {{-0.5f,  0.5f, 0.0f}, {0.0f, 1.0f}}, // upper left corner
};

/////////////////////////////////////////////////////////////////
/// Define defualt vertex data to reset vertices when needed
///
static const SceneVertex defaultVertices[] = {
   {{-0.5f, -0.5f, 0.0f}, {0.0f, 0.0f}},
   {{ 0.5f, -0.5f, 0.0f}, {1.0f, 0.0f}},
   {{-0.5f,  0.5f, 0.0f}, {0.0f, 1.0f}},
};

/////////////////////////////////////////////////////////////////
/// Provide storage for the vectors that control the direction
/// and distance that each vertex moves per update when animated
///
static GLKVector3 movementVectors[3] = {
   {-0.02f,  -0.01f, 0.0f},
   {0.01f,  -0.005f, 0.0f},
   {-0.01f,   0.01f, 0.0f},
};


/////////////////////////////////////////////////////////////////
/// Update the current OpenGL ES context texture wrapping mode
///
- (void)updateTextureParameters {
	
   	[self.baseEffect.texture2d0 aglkSetParameter:GL_TEXTURE_WRAP_S
										   value:(self.shouldRepeatTexture ?
												  GL_REPEAT : GL_CLAMP_TO_EDGE)];
   
   	[self.baseEffect.texture2d0 aglkSetParameter:GL_TEXTURE_MAG_FILTER
										   value:(self.shouldUseLinearFilter ?
												  GL_LINEAR : GL_NEAREST)];
}


/////////////////////////////////////////////////////////////////
// Update the positions of vertex data to create a bouncing 
/// animation
///
- (void)updateAnimatedVertexPositions {
	
	/// Animate the triangles vertex positions
	/// 开启动画
	if(shouldAnimate) {
		// by convention, 'i' is current vertex index
      	int i;
		///
      	for(i = 0; i < 3; i++) {
         	vertices[i].positionCoords.x += movementVectors[i].x;
         	if(vertices[i].positionCoords.x >= 1.0f ||
            	vertices[i].positionCoords.x <= -1.0f) {
            	movementVectors[i].x = -movementVectors[i].x;
         	}
         	vertices[i].positionCoords.y += movementVectors[i].y;
         	if(vertices[i].positionCoords.y >= 1.0f ||
            vertices[i].positionCoords.y <= -1.0f) {
            	movementVectors[i].y = -movementVectors[i].y;
         	}
         	vertices[i].positionCoords.z += movementVectors[i].z;
			
         	if(vertices[i].positionCoords.z >= 1.0f || vertices[i].positionCoords.z <= -1.0f) {
            movementVectors[i].z = -movementVectors[i].z;
         	}
      	}
	}
	// Restore the triangle vertex positions to defaults
   	else {
		// by convention, 'i' is current vertex index
      	int i;
      
		for(i = 0; i < 3; i++) {
			vertices[i].positionCoords.x = defaultVertices[i].positionCoords.x;
			vertices[i].positionCoords.y = defaultVertices[i].positionCoords.y;
			vertices[i].positionCoords.z = defaultVertices[i].positionCoords.z;
		}
   	}
	// Adjust the S texture coordinates to slide texture and
	// reveal effect of texture repeat vs. clamp behavior
   	{
		// 'i' is current vertex index
		int i;
      	for(i = 0; i < 3; i++) {
			vertices[i].textureCoords.s = (defaultVertices[i].textureCoords.s + sCoordinateOffset);
		}
   }
}


/////////////////////////////////////////////////////////////////
// Called automatically at rate defined by view controller’s
// preferredFramesPerSecond property
/// 刷新 更新
- (void)update {
	/// 更新图形
   	[self updateAnimatedVertexPositions];
	/// 更新纹理
   	[self updateTextureParameters];
	
	/// 重置刷新数据
   	[vertexBuffer reinitWithAttribStride:sizeof(SceneVertex)
							numberOfVertices:sizeof(vertices) / sizeof(SceneVertex)
								   bytes:vertices];
}


/////////////////////////////////////////////////////////////////
// Called when the view controller's view is loaded
// Perform initialization before the view is asked to draw
- (void)viewDidLoad {
   [super viewDidLoad];
	
	/// 刷新频率 每分钟次数
   	self.preferredFramesPerSecond = 60;
   	self.shouldAnimate = YES;
   	self.shouldRepeatTexture = YES;

   	// Verify the type of view created automatically by the
   	// Interface Builder storyboard
	///
   	GLKView *view = (GLKView *)self.view;
   	NSAssert([view isKindOfClass:[GLKView class]],
      								@"View controller's view is not a GLKView");
   
   	/// 设置上下文
   	view.context = [[AGLKContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
   	[AGLKContext setCurrentContext:view.context];
   
   	// Create a base effect that provides standard OpenGL ES 2.0
   	// shading language programs and set constants to be used for
   	// all subsequent rendering
	/// 用于基于着色器的OpenGL渲染中的一个简单的照明和着色系统。
   	self.baseEffect = [[GLKBaseEffect alloc] init];
   	self.baseEffect.useConstantColor = GL_TRUE;
	/// 设置前景色
   	self.baseEffect.constantColor = GLKVector4Make(
												   1.0f, // Red
												   1.0f, // Green
												   1.0f, // Blue
												   1.0f);// Alpha
   
   	/// 设置背景色
   	((AGLKContext *)view.context).clearColor = GLKVector4Make(
															 0.0f, // Red
															 0.0f, // Green
															 0.0f, // Blue
															 1.0f);// Alpha
   
   	// Create vertex buffer containing vertices to draw
   	self.vertexBuffer = [[AGLKVertexAttribArrayBuffer alloc]
      initWithAttribStride:sizeof(SceneVertex)
      numberOfVertices:sizeof(vertices) / sizeof(SceneVertex)
      bytes:vertices
      usage:GL_DYNAMIC_DRAW];
   
   /// 设置纹理
   	CGImageRef imageRef = [[UIImage imageNamed:@"grid.png"] CGImage];
      
   	GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithCGImage:imageRef
															   options:nil
																 error:NULL];
	
	/// 设置要显示的纹理
	self.baseEffect.texture2d0.name = textureInfo.name;
	self.baseEffect.texture2d0.target = textureInfo.target;
}


/////////////////////////////////////////////////////////////////
// GLKView delegate method: Called by the view controller's view
// whenever Cocoa Touch asks the view controller's view to
// draw itself. (In this case, render into a frame buffer that
// shares memory with a Core Animation Layer)
/// 渲染
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {

	/// 准备
   	[self.baseEffect prepareToDraw];
   
   // Clear back frame buffer (erase previous drawing)
   [(AGLKContext *)view.context clear:GL_COLOR_BUFFER_BIT];
   
   [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribPosition
						  numberOfCoordinates:3
								 attribOffset:offsetof(SceneVertex, positionCoords)
								 shouldEnable:YES];

   [self.vertexBuffer prepareToDrawWithAttrib:GLKVertexAttribTexCoord0
						  numberOfCoordinates:2
								 attribOffset:offsetof(SceneVertex, textureCoords)
								 shouldEnable:YES];
      
   // Draw triangles using the first three vertices in the 
   // currently bound vertex buffer
   [self.vertexBuffer drawArrayWithMode:GL_TRIANGLES
					   startVertexIndex:0
					   numberOfVertices:3];
}


/////////////////////////////////////////////////////////////////
// Called when the view controller's view has been unloaded
// Perform clean-up that is possible when you know the view 
// controller's view won't be asked to draw again soon.
- (void)viewDidUnload {
   [super viewDidUnload];
   
   // Make the view's context current
   GLKView *view = (GLKView *)self.view;
   [AGLKContext setCurrentContext:view.context];
    
   // Delete buffers that aren't needed when view is unloaded
   self.vertexBuffer = nil;
   
   // Stop using the context created in -viewDidLoad
   ((GLKView *)self.view).context = nil;
   [EAGLContext setCurrentContext:nil];
}


/////////////////////////////////////////////////////////////////
// This method is called by a user interface object configured
// in Xcode and updates the value of the sCoordinateOffset 
// property to demonstrate how texture coordinates affect
// texture mapping to geometry
- (IBAction)takeSCoordinateOffsetFrom:(UISlider *)sender {
   self.sCoordinateOffset = [sender value];
}


/////////////////////////////////////////////////////////////////
// This method is called by a user interface object configured
// in Xcode and updates the value of the shouldRepeatTexture 
// property to demonstrate how textures are clamped or repeated
// when mapped to geometry with texture coordinates outside the
// range 0.0 to 1.0.
- (IBAction)takeShouldRepeatTextureFrom:(UISwitch *)sender {
   self.shouldRepeatTexture = [sender isOn];
}


/////////////////////////////////////////////////////////////////
// This method is called by a user interface object configured
// in Xcode and updates the value of the shouldAnimate 
// property to demonstrate how texture coordinates affect
/// texture mapping and visual distortion as geometry changes.
///
- (IBAction)takeShouldAnimateFrom:(UISwitch *)sender {
   self.shouldAnimate = [sender isOn];
}


/////////////////////////////////////////////////////////////////
/// This method is called by a user interface object configured
/// in Xcode and updates the value.
///
- (IBAction)takeShouldUseLinearFilterFrom:(UISwitch *)sender {
   self.shouldUseLinearFilter = [sender isOn];
}

@end
