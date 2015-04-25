//
//  UIFont+CustomFonts.m
//  ensemble
//
//  Created by Sanjeeva Kumar on 4/25/15.
//  Copyright (c) 2015 YMEdiaLabs. All rights reserved.
//

#import "UIFont+CustomFonts.h"

@implementation UIFont (customFonts)
static NSString *museoSansFontName = @"MuseoSans";
static NSString *proximaNovaFontName = @"ProximaNova";
static NSString *avenirFontName = @"Avenir";

+ (UIFont *)museoSansFontWithStyle:(NSString*)fontStyle ofSize:(CGFloat)fontSize {
    if (!fontStyle) {
        fontStyle = @"300";
    }
    return [UIFont fontWithName:[NSString stringWithFormat:@"%@-%@",museoSansFontName,fontStyle] size:fontSize];
}

+ (UIFont *)proximaNovaFontWithStyle:(NSString*)fontStyle ofSize:(CGFloat)fontSize {
    if (!fontStyle) {
        fontStyle = @"Regular";
    }
    return [UIFont fontWithName:[NSString stringWithFormat:@"%@-%@",proximaNovaFontName,fontStyle] size:fontSize];
}

+ (UIFont *)AvenirWithStyle:(NSString*)fontStyle ofSize:(CGFloat)fontSize {
    if (!fontStyle) {
        fontStyle = @"Book";
    }
    return [UIFont fontWithName:[NSString stringWithFormat:@"%@-%@",avenirFontName,fontStyle] size:fontSize];
}

+ (UIFont*)navBarButtonFont {
    return [UIFont AvenirWithStyle:@"Book" ofSize:20];
}
@end
