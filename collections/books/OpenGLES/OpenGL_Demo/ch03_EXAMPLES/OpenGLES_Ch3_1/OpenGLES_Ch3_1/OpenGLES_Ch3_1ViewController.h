//
//  OpenGLES_Ch3_1ViewController.h
//  OpenGLES_Ch3_1
//

#import <GLKit/GLKit.h>

@class AGLKVertexAttribArrayBuffer;


@interface OpenGLES_Ch3_1ViewController : GLKViewController

/// 基础效果
@property (strong, nonatomic) GLKBaseEffect  *baseEffect;
/// 缓存
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer	*vertexBuffer;

@end
