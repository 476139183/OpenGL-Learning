//
//  AGLKVertexAttribArrayBuffer.h
//  
//

#import <GLKit/GLKit.h>

@class AGLKElementIndexArrayBuffer;

/////////////////////////////////////////////////////////////////
// 
typedef enum {
    AGLKVertexAttribPosition = GLKVertexAttribPosition,
    AGLKVertexAttribNormal = GLKVertexAttribNormal,
    AGLKVertexAttribColor = GLKVertexAttribColor,
    AGLKVertexAttribTexCoord0 = GLKVertexAttribTexCoord0,
    AGLKVertexAttribTexCoord1 = GLKVertexAttribTexCoord1,
} AGLKVertexAttrib;


///
@interface AGLKVertexAttribArrayBuffer : NSObject {
   GLsizei      stride;
   GLsizeiptr   bufferSizeBytes;
   GLuint       name;
}

/// typedef uint32_t GLuint;
@property (nonatomic, readonly) GLuint 			name;

@property (nonatomic, readonly) GLsizeiptr   	bufferSizeBytes;

@property (nonatomic, readonly) GLsizei			stride;

#pragma mark - Init Method

/**
 <#Description#>

 @param stride <#stride description#>
 @param count <#count description#>
 @param dataPtr <#dataPtr description#>
 @param usage <#usage description#>
 @return <#return value description#>
 */
- (id)initWithAttribStride:(GLsizei)stride
		  numberOfVertices:(GLsizei)count
					 bytes:(const GLvoid *)dataPtr
					 usage:(GLenum)usage;

- (void)reinitWithAttribStride:(GLsizei)stride
			  numberOfVertices:(GLsizei)count
						 bytes:(const GLvoid *)dataPtr;

#pragma mark - Draw Method

+ (void)drawPreparedArraysWithMode:(GLenum)mode
				  startVertexIndex:(GLint)first
				  numberOfVertices:(GLsizei)count;



- (void)prepareToDrawWithAttrib:(GLuint)index
				numberOfCoordinates:(GLint)count
				   attribOffset:(GLsizeiptr)offset
				   shouldEnable:(BOOL)shouldEnable;

- (void)drawArrayWithMode:(GLenum)mode
		 	startVertexIndex:(GLint)first
		 	numberOfVertices:(GLsizei)count;
   

   
@end
