//
//  Demo1ViewController.h
//  OPenGLES-Demo
//
//  Created by 王潇 on 16/10/27.
//  Copyright © 2016年 王潇. All rights reserved.
//

/// 1. 导入GLKit框架
/// GLKit框架的设计目标是为了简化基于OpenGL或者OpenGL ES的应用开发。
#import <GLKit/GLKit.h>

/// 2. 继承自 GLKViewController
/// GLKViewController 继承自 UIViewController
/// GLKViewController 会自动地重新设置 OpenGL ES 和应用的GLKView实例以响应设备的方向变化
/// 可视化过渡效果, 例如淡出和淡入效果。
@interface Demo1ViewController : GLKViewController {

	/// 3. 声明 vertexBufferID 变量用于保存盛放本例中用到的定点数据的缓存的OpenGL ES 标识符。
	GLuint vertexBufferID;
}

/// 4. 声明 GLKBaseEffect 指针
/// GLKBaseEffect 类的存在是为了简化OpenGLES 的很多常用操作。
/// GLKBaseEffect 隐藏了iOS设备支持的多个OpenGL ES版本之间的差异。
/// 在应用中使用 GLKBaseEffect 能减少需要编写的代码量。
@property (strong, nonatomic) GLKBaseEffect *baseEffect;

@end
