//
//  AGLKView.h
//  
//

#import <UIKit/UIKit.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@class EAGLContext;
@protocol AGLKViewDelegate;


/////////////////////////////////////////////////////////////////
// Type for depth buffer formats.
typedef enum {
	AGLKViewDrawableDepthFormatNone = 0,
	AGLKViewDrawableDepthFormat16,
} AGLKViewDrawableDepthFormat;


/////////////////////////////////////////////////////////////////
// This subclass of the Cocoa Touch UIView class uses OpenGL ES
// to render pixel data into a Frame Buffer that shares pixel
// color storage with a Core Animation Layer.
@interface AGLKView : UIView {
   EAGLContext   *context;
   GLuint        defaultFrameBuffer;
   GLuint        colorRenderBuffer;
   GLuint        depthRenderBuffer;
   GLint         drawableWidth;
   GLint         drawableHeight;
}

@property (nonatomic, weak) IBOutlet id	<AGLKViewDelegate> 	delegate;
/// 上下文？
@property (nonatomic, strong) EAGLContext 					*context;
/// 绘制宽度
@property (nonatomic, readonly) NSInteger 					drawableWidth;
/// 绘制高度
@property (nonatomic, readonly) NSInteger 					drawableHeight;
/// 帧数???
@property (nonatomic) AGLKViewDrawableDepthFormat			drawableDepthFormat;

- (void)display;

@end


#pragma mark - AGLKViewDelegate

@protocol AGLKViewDelegate <NSObject>

@required
- (void)glkView:(AGLKView *)view drawInRect:(CGRect)rect;

@end
