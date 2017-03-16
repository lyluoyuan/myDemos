//
//  NSData+BFKit.h
//  BFKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 - 2016 Fabrizio Brancati. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

@import Foundation;

/**
 *  This category adds some useful methods to NSData
 */
@interface NSData (BFKit)

/**
 *  Convert the given NSData to UTF8 NSString
 *
 *  @param data The NSData to be converted
 *
 *  @return Returns the converted NSData as UTF8 NSString
 */
+ (NSString * _Nonnull)convertToUTF8String:(NSData * _Nonnull)data;

/**
 *  Convert self to a UTF8 NSString
 *
 *  @return Returns self as UTF8 NSString
 */
- (NSString * _Nonnull)convertToUTF8String;

/**
 *  Convert the given NSData to ASCII NSString
 *
 *  @param data The NSData to be converted
 *
 *  @return Returns the converted NSData as ASCII NSString
 */
+ (NSString * _Nonnull)convertToASCIIString:(NSData * _Nonnull)data;

/**
 *  Convert self to a ASCII NSString
 *
 *  @return Returns self as ASCII NSString
 */
- (NSString * _Nonnull)convertToASCIIString;

/**
 *  Convert self UUID to NSString.
 *  Useful for push notifications
 *
 *  @return Returns self as NSString from UUID
 */
- (NSString * _Nullable)convertUUIDToString;

@end