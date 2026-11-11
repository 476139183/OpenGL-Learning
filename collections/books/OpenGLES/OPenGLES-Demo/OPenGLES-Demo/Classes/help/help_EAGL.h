//
//  help_EAGL.h
//  OPenGLES-Demo
//
//  Created by 王潇 on 2019/5/18.
//  Copyright © 2019 王潇. All rights reserved.
//

#ifndef help_EAGL_h
#define help_EAGL_h

/************************************************************************/
/* EAGL API Version                                                     */
/************************************************************************/
#define EAGL_MAJOR_VERSION   1
#define EAGL_MINOR_VERSION   0


/************************************************************************/
/* EAGL Enumerated values                                               */
/************************************************************************/

/* EAGL rendering API */
typedef NS_ENUM(NSUInteger, EAGLRenderingAPI) {
	kEAGLRenderingAPIOpenGLES1 = 1,
	kEAGLRenderingAPIOpenGLES2 = 2,
	kEAGLRenderingAPIOpenGLES3 = 3,
};

NS_ASSUME_NONNULL_BEGIN

/************************************************************************/
/* EAGL Functions                                                       */
/************************************************************************/

EAGL_EXTERN void EAGLGetVersion(unsigned int* major, unsigned int* minor);

/************************************************************************/
/* EAGL Sharegroup                                                      */
/************************************************************************/

EAGL_EXTERN_CLASS
@interface EAGLSharegroup : NSObject {
	@package
	struct _EAGLSharegroupPrivate *_private;
}

@property (nullable, copy, nonatomic) NSString* debugLabel;

@end

/************************************************************************/
/* EAGL Context                                                         */
/************************************************************************/

//// 
@interface EAGLContext : NSObject {
@public
	struct _EAGLContextPrivate *_private;
}

+ (nullable EAGLContext*)currentContext;
- (nullable instancetype)init;
- (nullable instancetype)initWithAPI:(EAGLRenderingAPI)api;
- (nullable instancetype)initWithAPI:(EAGLRenderingAPI)api
						   sharegroup:(EAGLSharegroup*)sharegroup;
///
+ (BOOL)setCurrentContext:(nullable EAGLContext*)context;

///
@property (readonly) EAGLRenderingAPI   API;

@property (nonnull, readonly) EAGLSharegroup*    sharegroup;

@property (nullable, copy, nonatomic) NSString* debugLabel;

@property (getter=isMultiThreaded, nonatomic) BOOL multiThreaded;

@end

NS_ASSUME_NONNULL_END

#endif /* help_EAGL_h */
