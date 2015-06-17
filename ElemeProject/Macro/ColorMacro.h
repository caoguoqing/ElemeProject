//
//  ColorMacro.h
//  ElemeProject
//
//  Created by Sam Lau on 6/12/15.
//  Copyright (c) 2015 Sam Lau. All rights reserved.
//

#ifndef ElemeProject_ColorMacro_h
#define ElemeProject_ColorMacro_h

// UIColor Helper Macro
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

// App Colors
#define THEME_COLOR UIColorFromRGB(0x3E86E4)
#define BACKGROUND_COLOR UIColorFromRGB(0xF0EFF4)

#endif
