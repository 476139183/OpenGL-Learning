//
//  AGLKTextureLoader.h
//  OpenGLES_Ch3_2
//

#import <GLKit/GLKit.h>

#pragma mark -AGLKTextureInfo

@interface AGLKTextureInfo : NSObject {
@private
   GLuint name;
   GLenum target;
   GLuint width;
   GLuint height;
}

/// 缓存缓存标识
@property (readonly) GLuint name;
/// 
@property (readonly) GLenum target;
/// 纹理图像的 宽度
@property (readonly) GLuint width;
/// 纹理图像的 高度
@property (readonly) GLuint height;

@end


#pragma mark -AGLKTextureLoader

@interface AGLKTextureLoader : NSObject

/**
 <#Description#>

 @param cgImage <#cgImage description#>
 @param options <#options description#>
 @param outError <#outError description#>
 @return <#return value description#>
 */
+ (AGLKTextureInfo *)textureWithCGImage:(CGImageRef)cgImage
								options:(NSDictionary *)options
								  error:(NSError **)outError;
   
@end
