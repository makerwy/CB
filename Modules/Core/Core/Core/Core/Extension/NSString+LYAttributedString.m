//
//  NSString+LYAttributedString.m
//  LYProject
//
//  Created by mac on 2019/9/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "NSString+LYAttributedString.h"

@implementation NSString (LYAttributedString)

- (NSMutableAttributedString *)attributedStr {
    return [[NSMutableAttributedString alloc] initWithString:self];
}

@end
