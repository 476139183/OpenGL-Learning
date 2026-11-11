//
//  help_glkViewController.h
//  OPenGLES-Demo
//
//  Created by 王潇 on 2019/5/16.
//  Copyright © 2019 王潇. All rights reserved.
//

#ifndef help_glkViewController_h
#define help_glkViewController_h


//// GLKViewController类是支持OpenGL ES特有的行为和动画时的UIViewController的内建子类。
@interface GLKViewController : UIViewController <NSCoding, GLKViewDelegate>

@property (nullable, nonatomic, assign) id <GLKViewControllerDelegate> delegate;

/// 用于设置每秒进行更新和绘图的所需帧数。默认值为30
@property (nonatomic) NSInteger preferredFramesPerSecond;

/*
 The actual frames per second that was decided upon given the value for preferredFramesPerSecond
 and the screen for which the GLKView resides. The value chosen will be as close to
 preferredFramesPerSecond as possible, without exceeding the screen's refresh rate. This value
 does not account for dropped frames, so it is not a measurement of your statistical frames per
 second. It is the static value for which updates will take place.
 */
@property (nonatomic, readonly) NSInteger framesPerSecond;

/*
 Used to pause and resume the controller.
 */
@property (nonatomic, getter=isPaused) BOOL paused;

/*
 The total number of frames displayed since drawing began.
 */
@property (nonatomic, readonly) NSInteger framesDisplayed;

/*
 Time interval since properties.
 */
@property (nonatomic, readonly) NSTimeInterval timeSinceFirstResume;
@property (nonatomic, readonly) NSTimeInterval timeSinceLastResume;
@property (nonatomic, readonly) NSTimeInterval timeSinceLastUpdate;
@property (nonatomic, readonly) NSTimeInterval timeSinceLastDraw;

/*
 If true, the controller will pause when the application recevies a willResignActive notification.
 If false, the controller will not pause and it is expected that some other mechanism will pause
 the controller when necessary.
 The default is true.
 */
@property (nonatomic) BOOL pauseOnWillResignActive;

/*
 If true, the controller will resume when the application recevies a didBecomeActive notification.
 If false, the controller will not resume and it is expected that some other mechanism will resume
 the controller when necessary.
 The default is true.
 */
@property (nonatomic) BOOL resumeOnDidBecomeActive;

@end

#pragma mark -
#pragma mark GLKViewControllerDelegate
#pragma mark -

@protocol GLKViewControllerDelegate <NSObject>

@required
/*
 Required method for implementing GLKViewControllerDelegate. This update method variant should be used
 when not subclassing GLKViewController. This method will not be called if the GLKViewController object
 has been subclassed and implements -(void)update.
 */
- (void)glkViewControllerUpdate:(GLKViewController *)controller;

@optional
/*
 Delegate method that gets called when the pause state changes.
 */
- (void)glkViewController:(GLKViewController *)controller willPause:(BOOL)pause;

@end
NS_ASSUME_NONNULL_END


#endif /* help_glkViewController_h */
