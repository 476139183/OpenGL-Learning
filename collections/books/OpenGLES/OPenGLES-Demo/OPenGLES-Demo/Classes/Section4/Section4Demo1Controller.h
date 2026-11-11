//
//  Section4Demo1Controller.h
//  OPenGLES-Demo
//
//  Created by 王潇 on 2019/5/15.
//  Copyright © 2019 王潇. All rights reserved.
//

#import <GLKit/GLKit.h>

@class AGLKVertexAttribArrayBuffer;

NS_ASSUME_NONNULL_BEGIN

@interface Section4Demo1Controller : GLKViewController


@property (strong, nonatomic) GLKBaseEffect
*baseEffect;
@property (strong, nonatomic) GLKBaseEffect
*extraEffect;
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer
*vertexBuffer;
@property (strong, nonatomic) AGLKVertexAttribArrayBuffer
*extraBuffer;

@property (nonatomic) GLfloat
centerVertexHeight;
@property (nonatomic) BOOL
shouldUseFaceNormals;
@property (nonatomic) BOOL
shouldDrawNormals;

- (IBAction)takeShouldUseFaceNormalsFrom:(UISwitch *)sender;
- (IBAction)takeShouldDrawNormalsFrom:(UISwitch *)sender;
- (IBAction)takeCenterVertexHeightFrom:(UISlider *)sender;


@end

NS_ASSUME_NONNULL_END
