//
//  SortReveal
//
//  Created by Eric on 2018/4/18.
//  Copyright © 2018 Eric. All rights reserved.
//
#ifndef _HanyuPinyinOutputFormat_H_
#define _HanyuPinyinOutputFormat_H_
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ToneType) {
    ToneTypeWithToneNumber,
    ToneTypeWithoutTone,
    ToneTypeWithToneMark
};

typedef NS_ENUM(NSUInteger, VCharType) {
    VCharTypeWithUAndColon,
    VCharTypeWithV,
    VCharTypeWithUUnicode
};

typedef NS_ENUM(NSUInteger, CaseType) {
    CaseTypeUppercase,
    CaseTypeLowercase
};


@interface HanyuPinyinOutputFormat : NSObject

@property(nonatomic, assign) VCharType vCharType;
@property(nonatomic, assign) CaseType caseType;
@property(nonatomic, assign) ToneType toneType;

- (id)initWithVCharType:(VCharType)vt caseType:(CaseType)ct toneType:(ToneType)tt;

+ (HanyuPinyinOutputFormat *)commonFormat;
+ (HanyuPinyinOutputFormat *)formatWithVCharType:(VCharType)vt caseType:(CaseType)ct toneType:(ToneType)tt;

@end




#endif // _HanyuPinyinOutputFormat_H_
