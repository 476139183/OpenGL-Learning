//
//  AGLKVertexAttribArrayBuffer.m
//  
//

#import "AGLKVertexAttribArrayBuffer.h"

@interface AGLKVertexAttribArrayBuffer ()

/// typedef intptr_t GLsizeiptr;
/// 据字节数量
@property (nonatomic, assign) GLsizeiptr bufferSizeBytes;
/// typedef int32_t  GLsizei;
@property (nonatomic, assign) GLsizei stride;

@end


@implementation AGLKVertexAttribArrayBuffer

@synthesize name;
@synthesize bufferSizeBytes;
@synthesize stride;


/////////////////////////////////////////////////////////////////
// This method creates a vertex attribute array buffer in
// the current OpenGL ES context for the thread upon which this 
// method is called.
- (id)initWithAttribStride:(GLsizei)aStride
		  numberOfVertices:(GLsizei)count
					 bytes:(const GLvoid *)dataPtr
					 usage:(GLenum)usage {
	
   	NSParameterAssert(0 < aStride);
   	NSAssert((0 < count && NULL != dataPtr) || (0 == count && NULL == dataPtr),
      										@"data must not be NULL or count > 0");
      
   if(nil != (self = [super init])) {
      	stride = aStride;
      	bufferSizeBytes = stride * count;

	   	/// 创建缓存对象并且返回缓存对象的标示符
      	glGenBuffers(1, &name);
	   	/// 将缓存对象绑定到相应的缓存上。
      	glBindBuffer(GL_ARRAY_BUFFER, self.name);
	   	/// 把顶点数据从cpu内存复制到gpu内存
      	glBufferData(
         	GL_ARRAY_BUFFER,  // Initialize buffer contents
         	bufferSizeBytes,  // Number of bytes to copy
         	dataPtr,          // Address of bytes to copy
         	usage);           // Hint: cache in GPU memory
         
      NSAssert(0 != name, @"Failed to generate name");
   }
   return self;
}   


/////////////////////////////////////////////////////////////////
// This method loads the data stored by the receiver.
- (void)reinitWithAttribStride:(GLsizei)aStride
			  numberOfVertices:(GLsizei)count
						 bytes:(const GLvoid *)dataPtr {

   	NSParameterAssert(0 < aStride);
   	NSParameterAssert(0 < count);
   	NSParameterAssert(NULL != dataPtr);
	NSAssert(0 != name, @"Invalid name");

   	self.stride 			= aStride;
   	self.bufferSizeBytes = aStride * count;
	
	/// 将缓存对象绑定到相应的缓存上。
	glBindBuffer(GL_ARRAY_BUFFER, self.name);
	/// 把顶点数据从cpu内存复制到gpu内存
   	glBufferData(
      		GL_ARRAY_BUFFER,  // Initialize buffer contents
      		bufferSizeBytes,  // Number of bytes to copy
      		dataPtr,          // Address of bytes to copy
      		GL_DYNAMIC_DRAW);
}


/////////////////////////////////////////////////////////////////
// A vertex attribute array buffer must be prepared when your 
// application wants to use the buffer to render any geometry. 
// When your application prepares an buffer, some OpenGL ES state
// is altered to allow bind the buffer and configure pointers.
- (void)prepareToDrawWithAttrib:(GLuint)index
				numberOfCoordinates:(GLint)count
				   attribOffset:(GLsizeiptr)offset
				   shouldEnable:(BOOL)shouldEnable {

	///
   	NSParameterAssert((0 < count) && (count < 4));
	NSParameterAssert(offset < self.stride);
   	NSAssert(0 != name, @"Invalid name");

	/// 将缓存对象绑定到相应的缓存上。
   	glBindBuffer(GL_ARRAY_BUFFER, self.name);

   	if(shouldEnable) {
		/// 启用顶点属性，OpenGL是个状态机，我们通常见到的
		/// glEnable - glDisable函数就是通知OpenGL开启/关闭某种状态的，
		/// 譬如光照、深度检测等等(我的理解是相当于声明一个buffer)
      	glEnableVertexAttribArray(index);
   	}

	/// 设置合适的格式从buffer里面读取数据
   	glVertexAttribPointer(index,               // Identifies the attribute to use
						  count,               // number of coordinates for attribute
						  GL_FLOAT,            // data is floating point
						  GL_FALSE,            // no fixed point scaling
						  (self.stride),       // total num bytes stored per vertex
						  NULL + offset);      // offset from start of each vertex to
						// first coord for attribute
#ifdef DEBUG
   {  // Report any errors 
      GLenum error = glGetError();
      if(GL_NO_ERROR != error) {
         NSLog(@"GL Error: 0x%x", error);
      }
   }
#endif
}


/////////////////////////////////////////////////////////////////
// Submits the drawing command identified by mode and instructs
// OpenGL ES to use count vertices from the buffer starting from
// the vertex at index first. Vertex indices start at 0.
- (void)drawArrayWithMode:(GLenum)mode
		 	startVertexIndex:(GLint)first
		 	numberOfVertices:(GLsizei)count {
	
   NSAssert(self.bufferSizeBytes >= ((first + count) * self.stride),
      						@"Attempt to draw more vertex data than available.");
	/// 绘制
   	glDrawArrays(mode, first, count); // Step 6
}


/////////////////////////////////////////////////////////////////
// Submits the drawing command identified by mode and instructs
// OpenGL ES to use count vertices from previously prepared 
// buffers starting from the vertex at index first in the 
// prepared buffers
+ (void)drawPreparedArraysWithMode:(GLenum)mode
				  startVertexIndex:(GLint)first
				  numberOfVertices:(GLsizei)count {
	// Step 6
   	glDrawArrays(mode, first, count);
}


/////////////////////////////////////////////////////////////////
// This method deletes the receiver's buffer from the current
// Context when the receiver is deallocated.
- (void)dealloc {
    // Delete buffer from current context
    if (0 != name) {
        glDeleteBuffers (1, &name); // Step 7 
        name = 0;
    }
}

@end


