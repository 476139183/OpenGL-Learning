//
//  help_TextureInfo.h
//  OpenGLES_Ch3_1
//
//  Created by wxiao on 2018/12/6.
//

#ifndef help_TextureInfo_h
#define help_TextureInfo_h


@interface GLKTextureInfo : NSObject <NSCopying> {
@private
	GLuint                      name;
	GLenum                      target;
	GLuint                      width;
	GLuint                      height;
	GLuint                      depth;
	GLKTextureInfoAlphaState    alphaState;
	GLKTextureInfoOrigin        textureOrigin;
	BOOL                        containsMipmaps;
	GLuint                      mimapLevelCount;
	GLuint                      arrayLength;
}

@property (readonly) GLuint                     name;
@property (readonly) GLenum                     target;
@property (readonly) GLuint                     width;
@property (readonly) GLuint                     height;
@property (readonly) GLuint                     depth;
@property (readonly) GLKTextureInfoAlphaState   alphaState;
@property (readonly) GLKTextureInfoOrigin       textureOrigin;
@property (readonly) BOOL                       containsMipmaps;
@property (readonly) GLuint                     mimapLevelCount;
@property (readonly) GLuint                     arrayLength;

@end

#pragma mark -
#pragma mark GLKTextureLoader
#pragma mark -

typedef void (^GLKTextureLoaderCallback) (GLKTextureInfo * __nullable textureInfo, NSError * __nullable outError);


OPENGL_DEPRECATED(10.8,10.14) OPENGLES_DEPRECATED(ios(5.0,12.0), tvos(9.0,12.0))
@interface GLKTextureLoader : NSObject

#pragma mark Synchronous Methods

/*
 Synchronously load an image from disk into an OpenGL texture.
 Returns the generated texture object when the operation is complete, or the operation terminates with an error (returning nil).
 Returned error can be queried via 'error', which is nil otherwise.
 */
+ (nullable GLKTextureInfo *)textureWithContentsOfFile:(NSString *)path                                       /* File path of image. */
											   options:(nullable NSDictionary<NSString*, NSNumber*> *)options /* Options that control how the image is loaded. */
												 error:(NSError * __nullable * __nullable)outError;           /* Error description. */

+ (nullable GLKTextureInfo *)textureWithContentsOfURL:(NSURL *)url                                           /* The URL from which to read. */
											  options:(nullable NSDictionary<NSString*, NSNumber*> *)options /* Options that control how the image is loaded. */
												error:(NSError * __nullable * __nullable)outError;           /* Error description. */

/*
 Synchronously load a named texture asset from a given bundled into an OpenGL texture
 Returns the generated texture object when the operation is complete, or the operation terminates with an error (returning nil).
 Returned error can be queried via 'error', which is nil otherwise.
 */
+ (nullable GLKTextureInfo *)textureWithName:(NSString *)name                                       /* The asset name */
								 scaleFactor:(CGFloat)scaleFactor                                   /* scale factor of asset to be retrieved */
									  bundle:(nullable NSBundle*)bundle                             /* The bundle where the named texture is located */
									 options:(nullable NSDictionary<NSString*, NSNumber*> *)options /* Options that control how the image is loaded. */
									   error:(NSError * __nullable * __nullable)outError;           /* Error description. */

/*
 Synchronously create a texture from data residing in memory.
 Returns the generated texture object when the operation is complete, or the operation terminates with an error (returning nil).
 Returned error can be queried via 'error', which is nil otherwise.
 */
+ (nullable GLKTextureInfo *)textureWithContentsOfData:(NSData *)data                                         /* NSData containing image contents. */
											   options:(nullable NSDictionary<NSString*, NSNumber*> *)options /* Options that control how the image is loaded. */
												 error:(NSError * __nullable * __nullable)outError;           /* Error description. */

/*
 Synchronously create a texture from a CGImageRef.
 Returns the generated texture object when the operation is complete, or the operation terminates with an error (returning nil).
 Returned error can be queried via 'error', which is nil otherwise.
 */
+ (nullable GLKTextureInfo *)textureWithCGImage:(CGImageRef)cgImage                                    /* CGImage reference. */
										options:(nullable NSDictionary<NSString*, NSNumber*> *)options /* Options that control how the image is loaded. */
										  error:(NSError * __nullable * __nullable)outError;           /* Error description. */

/*
 Synchronously load six images from disk into an OpenGL cubemap texture.
 Face ordering will always be interpreted as Right(+x), Left(-x), Top(+y), Bottom(-y), Front(+z), Back(-z).
 This coordinate system is left-handed if you think of yourself within the cube. The coordinate system is right-handed if you think of yourself outside of the cube.
 Returns the generated texture object when the operation is complete, or the operation terminates with an error (returning nil).
 Returned error can be queried via 'error' which is nil otherwise.
 */
+ (nullable GLKTextureInfo*)cubeMapWithContentsOfFiles:(NSArray<id> *)paths                                   /* An array of paths (NSStrings or NSURLs). */
											   options:(nullable NSDictionary<NSString*, NSNumber*> *)options /* Otions that control how the image is loaded. */
												 error:(NSError * __nullable * __nullable)outError;           /* Error description. */

/*
 Synchronously creates an OpenGL cubemap texture by splitting one image into six parts.
 Takes a single image file where height = 6 * width or width = 6 * height.
 The former (vertical orientation) is preferred to avoid image data extraction overhead.
 Face ordering will always be interpreted as Right(+x), Left(-x), Top(+y), Bottom(-y), Front(+z), Back(-z).
 This coordinate system is left-handed if you think of yourself within the cube. The coordinate system is right-handed if you think of yourself outside of the cube.
 Returns the generated texture object when the operation is complete, or the operation terminates with an error (returning nil).
 Returned error can be queried via 'error' which is nil otherwise.
 */
+ (nullable GLKTextureInfo*)cubeMapWithContentsOfFile:(NSString *)path                                       /* File path of image. */
											  options:(nullable NSDictionary<NSString*, NSNumber*> *)options /* Options that control how the image is loaded. */
												error:(NSError * __nullable * __nullable)outError;           /* Error description. */


+ (nullable GLKTextureInfo*)cubeMapWithContentsOfURL:(NSURL *)url                                           /* File path of image. */
											 options:(nullable NSDictionary<NSString*, NSNumber*> *)options /* Options that control how the image is loaded. */
											   error:(NSError * __nullable * __nullable)outError;           /* Error description. */

#pragma mark Asynchronous Methods

/*
 Internally creates a new shared context that will handle the texture creation operations.
 The sharegroup will be released upon releasing the GLKTextureLoader object.
 */
#if TARGET_OS_IPHONE
- (instancetype)initWithSharegroup:(EAGLSharegroup *)sharegroup;
#else
- (instancetype)initWithShareContext:(NSOpenGLContext *)context;
#endif

/*
 Asynchronously load an image from disk into an OpenGL texture.
 Invokes the block on the provided queue when the operation is complete. If queue is NULL, the main queue will be used.
 */
- (void)textureWithContentsOfFile:(NSString *)path                                       /* File path of image. */
						  options:(nullable NSDictionary<NSString*, NSNumber*> *)options /* Options that control how the image is loaded. */
							queue:(nullable dispatch_queue_t)queue                       /* Dispatch queue, or NULL to use the main queue. */
				completionHandler:(GLKTextureLoaderCallback)block;                       /* Block to be invoked on the above dispatch queue. */

- (void)textureWithContentsOfURL:(NSURL *)url                                           /* File path of image. */
						 options:(nullable NSDictionary<NSString*, NSNumber*> *)options /* Options that control how the image is loaded. */
						   queue:(nullable dispatch_queue_t)queue                       /* Dispatch queue, or NULL to use the main queue. */
			   completionHandler:(GLKTextureLoaderCallback)block;                       /* Block to be invoked on the above dispatch queue. */

/*
 Asynchronously load a named texture asset from a given bundled into an OpenGL texture
 Invokes the block on the provided queue when the operation is complete. If queue is NULL, the main queue will be used.
 */
- (void)textureWithName:(NSString *)name                                       /* The asset name */
			scaleFactor:(CGFloat)scaleFactor                                   /* scale factor of asset to be retrieved */
				 bundle:(nullable NSBundle*)bundle                             /* The bundle where the named texture is located */
				options:(nullable NSDictionary<NSString*, NSNumber*> *)options /* Options that control how the image is loaded. */
				  queue:(nullable dispatch_queue_t)queue                       /* Dispatch queue, or NULL to use the main queue. */
	  completionHandler:(GLKTextureLoaderCallback)block;                       /* Block to be invoked on the above dispatch queue. */

/*
 Asynchronously create a texture from data residing in memory.
 Invokes the block on the provided queue when the operation is complete. If queue is NULL, the main queue will be used.
 */
- (void)textureWithContentsOfData:(NSData *)data                                         /* NSData containing image contents. */
						  options:(nullable NSDictionary<NSString*, NSNumber*> *)options /* Options that control how the image is loaded. */
							queue:(nullable dispatch_queue_t)queue                       /* Dispatch queue, or NULL to use the main queue. */
				completionHandler:(GLKTextureLoaderCallback)block;                       /* Block to be invoked on the above dispatch queue. */

/*
 Asynchronously create a texture from a CGImageRef.
 Invokes the block on the provided queue when the operation is complete. If queue is NULL, the main queue will be used.
 */
- (void)textureWithCGImage:(CGImageRef)cgImage                                    /* CGImage reference. */
				   options:(nullable NSDictionary<NSString*, NSNumber*> *)options /* Options that control how the image is loaded. */
					 queue:(nullable dispatch_queue_t)queue                       /* Dispatch queue, or NULL to use the main queue. */
		 completionHandler:(GLKTextureLoaderCallback)block;                       /* Block to be invoked on the above dispatch queue. */


/*
 Asynchronously load six images from disk into an OpenGL cubemap texture.
 Face ordering will always be interpreted as Right(+x), Left(-x), Top(+y), Bottom(-y), Front(+z), Back(-z).
 This coordinate system is left-handed if you think of yourself within the cube. The coordinate system is right-handed if you think of yourself outside of the cube.
 Invokes the block on the provided queue when the operation is complete. If queue is NULL, the main queue will be used.
 */
- (void)cubeMapWithContentsOfFiles:(NSArray<id> *)paths                                   /* An array of paths (NSStrings or NSURLs). */
						   options:(nullable NSDictionary<NSString*, NSNumber*> *)options /* Options that control how the image is loaded. */
							 queue:(nullable dispatch_queue_t)queue                       /* Dispatch queue, or NULL to use the main queue. */
				 completionHandler:(GLKTextureLoaderCallback)block;                       /* Block to be invoked on the above dispatch queue. */


/*
 Asynchronously creates an OpenGL cubemap texture by splitting one image into six parts.
 Takes a single image file where height = 6 * width or width = 6 * height.
 The former (vertical orientation) is preferred to avoid image data extraction overhead.
 Face ordering will always be interpreted as Right(+x), Left(-x), Top(+y), Bottom(-y), Front(+z), Back(-z).
 This coordinate system is left-handed if you think of yourself within the cube. The coordinate system is right-handed if you think of yourself outside of the cube.
 Invokes the block on the provided queue when the operation is complete. If queue is NULL, the main queue will be used.
 */
- (void)cubeMapWithContentsOfFile:(NSString *)path                                       /* File path of image. */
						  options:(nullable NSDictionary<NSString*, NSNumber*> *)options /* Options that control how the image is loaded. */
							queue:(nullable dispatch_queue_t)queue                       /* Dispatch queue, or NULL to use the main queue. */
				completionHandler:(GLKTextureLoaderCallback)block;                       /* Block to be invoked on the above dispatch queue. */


- (void)cubeMapWithContentsOfURL:(NSURL *)url                                           /* File path of image. */
						 options:(nullable NSDictionary<NSString*, NSNumber*> *)options /* Options that control how the image is loaded. */
						   queue:(nullable dispatch_queue_t)queue                       /* Dispatch queue, or NULL to use the main queue. */
			   completionHandler:(GLKTextureLoaderCallback)block;                       /* Block to be invoked on the above dispatch queue. */

@end


#endif /* help_TextureInfo_h */
