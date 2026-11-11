//
//  help_Context.h
//  OpenGLES_Ch3_1
//
//  Created by wxiao on 2018/12/6.
//

#ifndef help_Context_h
#define help_Context_h

/************************************************************************/
/* EAGL Enumerated values                                               */
/************************************************************************/

/* EAGL rendering API */
typedef NS_ENUM(NSUInteger, EAGLRenderingAPI)
{
	kEAGLRenderingAPIOpenGLES1 = 1,
	kEAGLRenderingAPIOpenGLES2 = 2,
	kEAGLRenderingAPIOpenGLES3 = 3,
};

NS_ASSUME_NONNULL_BEGIN

/************************************************************************/
/* EAGL Functions                                                       */
/************************************************************************/

EAGL_EXTERN void EAGLGetVersion(unsigned int* major, unsigned int* minor) OPENGLES_DEPRECATED(ios(2.0, 12.0), tvos(9.0, 12.0));

/************************************************************************/
/* EAGL Sharegroup                                                      */
/************************************************************************/

EAGL_EXTERN_CLASS
@interface EAGLSharegroup : NSObject
{
	@package
	struct _EAGLSharegroupPrivate *_private;
}

@property (nullable, copy, nonatomic) NSString* debugLabel NS_AVAILABLE_IOS(6_0);

@end

/************************************************************************/
/* EAGL Context                                                         */
/************************************************************************/

EAGL_EXTERN_CLASS
OPENGLES_DEPRECATED(ios(2.0, 12.0), tvos(9.0, 12.0))
@interface EAGLContext : NSObject {
@public
	struct _EAGLContextPrivate *_private;
}

- (nullable instancetype) init NS_UNAVAILABLE;
- (nullable instancetype) initWithAPI:(EAGLRenderingAPI) api;
- (nullable instancetype) initWithAPI:(EAGLRenderingAPI) api sharegroup:(EAGLSharegroup*) sharegroup NS_DESIGNATED_INITIALIZER;

/// 设置当前上下文
+ (BOOL)setCurrentContext:(nullable EAGLContext*)context;
/// 获取当前上下文
+ (nullable EAGLContext*)currentContext;

/// 设置 API
@property (readonly) EAGLRenderingAPI   API;
@property (nonnull, readonly) EAGLSharegroup*    sharegroup;

@property (nullable, copy, nonatomic) NSString *debugLabel NS_AVAILABLE_IOS(6_0);
@property (getter=isMultiThreaded, nonatomic) BOOL multiThreaded NS_AVAILABLE_IOS(7_1);
@end


#endif /* help_Context_h */
