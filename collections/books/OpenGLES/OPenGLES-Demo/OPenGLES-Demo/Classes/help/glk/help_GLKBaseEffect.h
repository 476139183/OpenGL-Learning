//
//  help_GLKBaseEffect.h
//  OPenGLES-Demo
//
//  Created by 王潇 on 2019/5/18.
//  Copyright © 2019 王潇. All rights reserved.
//

#ifndef help_GLKBaseEffect_h
#define help_GLKBaseEffect_h



@class GLKEffectPropertyTexture;

NS_ASSUME_NONNULL_BEGIN

OPENGL_DEPRECATED(10.8,10.14) OPENGLES_DEPRECATED(ios(5.0,12.0), tvos(9.0,12.0))
@interface GLKBaseEffect : NSObject <GLKNamedEffect> {
@protected
	
	// Switches to turn effect features on and off
	GLboolean                           _colorMaterialEnabled;
	GLboolean                           _fogEnabled;
	
	// Modelview, projection, texture and derived matrices for transformation
	GLKEffectPropertyTransform          *_transform;
	
	// Lights
	GLKLightingType                     _lightingType;
	GLKEffectPropertyLight              *_light0, *_light1, *_light2;
	
	// Material for lighting
	GLKEffectPropertyMaterial           *_material;
	
	// GL Texture Names
	GLKEffectPropertyTexture            *_texture2d0, *_texture2d1;
	
	// Texture ordering array
	NSArray                             *_textureOrder;
	
	// Constant color (fixed color value to supplant the use of the "color" named vertex attrib array)
	GLKVector4                          _constantColor;
	
	// Fog
	GLKEffectPropertyFog                *_fog;
	
	// Label for effect
	NSString                            *_label;
}

// Sync all effect changes for consistent state when drawing
- (void) prepareToDraw;


// Properties                                                                                         // Default Value

/// 一个布尔值，指示在计算灯光与材质的交互时是否使用颜色顶点属性。
/// https://blog.csdn.net/tianxiawuzhei/article/details/50113763
/// OpenGL - 关于顶点属性的理解 https://www.jianshu.com/p/12b0c198c2e0
@property (nonatomic, assign)         GLboolean                          colorMaterialEnabled;        // GL_FALSE
@property (nonatomic, assign)         GLboolean                          lightModelTwoSided;          // GL_FALSE
@property (nonatomic, assign)         GLboolean                          useConstantColor;            // GL_TRUE

@property (nonatomic, readonly)       GLKEffectPropertyTransform         *transform;                  // Identity Matrices
@property (nonatomic, readonly)       GLKEffectPropertyLight             *light0, *light1, *light2;   // Disabled
@property (nonatomic, assign)         GLKLightingType                    lightingType;                // GLKLightingTypePerVertex
@property (nonatomic, assign)         GLKVector4                         lightModelAmbientColor;      // { 0.2, 0.2, 0.2, 1.0 }
@property (nonatomic, readonly)       GLKEffectPropertyMaterial          *material;                   // Default material state
@property (nonatomic, readonly)       GLKEffectPropertyTexture           *texture2d0, *texture2d1;    // Disabled
@property (nullable, nonatomic, copy) NSArray<GLKEffectPropertyTexture*> *textureOrder;               // texture2d0, texture2d1
@property (nonatomic, assign)         GLKVector4                         constantColor;               // { 1.0, 1.0, 1.0, 1.0 }
@property (nonatomic, readonly)       GLKEffectPropertyFog               *fog;                        // Disabled
@property (nullable, nonatomic, copy) NSString                           *label;                      // @"GLKBaseEffect"

@end
NS_ASSUME_NONNULL_END



#endif /* help_GLKBaseEffect_h */
