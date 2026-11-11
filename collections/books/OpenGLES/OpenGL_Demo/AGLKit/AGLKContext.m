//
//  GLKContext.m
//  
//

#import "AGLKContext.h"

@implementation AGLKContext

/////////////////////////////////////////////////////////////////
// This method sets the clear (background) RGBA color.
// The clear color is undefined until this method is called.
- (void)setClearColor:(GLKVector4)clearColorRGBA {
   clearColor = clearColorRGBA;
   
   NSAssert(self == [[self class] currentContext],
      @"Receiving context required to be current context");
	
	/// glClearColor()就是用来设置这个"底色"的，即所谓的背景颜色。
	/// glClearColor()只起到Set的作用，并不Clear任何。
   	glClearColor(
      	clearColorRGBA.r,
      	clearColorRGBA.g,
      	clearColorRGBA.b,
      	clearColorRGBA.a);
}


/////////////////////////////////////////////////////////////////
// Returns the clear (background) color set via -setClearColor:.
// If no clear color has been set via -setClearColor:, the 
// return clear color is undefined.
/// 获取【底色】
- (GLKVector4)clearColor {
   return clearColor;
}


/////////////////////////////////////////////////////////////////
// This method instructs OpenGL ES to set all data in the
// current Context's Render Buffer(s) identified by mask to
// colors (values) specified via -setClearColor: and/or
// OpenGL ES functions for each Render Buffer type.
- (void)clear:(GLbitfield)mask {
   NSAssert(self == [[self class] currentContext], @"Receiving context required to be current context");
	
	/// glClear()是用来清除屏幕颜色，即将屏幕的所有像素点都还原为"底色"。
   	glClear(mask);
}


/////////////////////////////////////////////////////////////////
/// 启用某种功能
- (void)enable:(GLenum)capability; {
   NSAssert(self == [[self class] currentContext], @"Receiving context required to be current context");
   	/// glEnable 用于启用各种功能。功能由参数决定。
	/// 与glDisable相对应。
	/// glDisable是用来关闭的。两个函数参数取值是一至的。
	glEnable(capability);
}


/////////////////////////////////////////////////////////////////
/// 关闭某种功能
- (void)disable:(GLenum)capability; {
   	NSAssert(self == [[self class] currentContext], @"Receiving context required to be current context");
   	glDisable(capability);
}


/////////////////////////////////////////////////////////////////
/// 设置 源因子 和 目标因子
- (void)setBlendSourceFunction:(GLenum)sfactor destinationFunction:(GLenum)dfactor; {
	/// 设置 源因子 和 目标因子 
	glBlendFunc(sfactor, dfactor);
}
  
@end
