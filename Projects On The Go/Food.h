//
//  Food.h
//  Piquant
//
//  Created by Eugene Wong on 12/5/14.
//  Copyright (c) 2014 raweng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Food : NSObject

@property (nonatomic, strong) NSDate *dayEaten;
@property (nonatomic, strong) NSNumber *calories;
@property (nonatomic, strong) NSNumber *caloriesFromFat;
@property (nonatomic, strong) NSNumber *totalFat;
@property (nonatomic, strong) NSNumber *saturatedFat;
@property (nonatomic, strong) NSNumber *transFattyAcid;
@property (nonatomic, strong) NSNumber *polysaturatedFat;
@property (nonatomic, strong) NSNumber *monosaturatedFat;
@property (nonatomic, strong) NSNumber *cholesterol;
@property (nonatomic, strong) NSNumber *sodium;
@property (nonatomic, strong) NSNumber *totalCarbs;
@property (nonatomic, strong) NSNumber *dietaryFiber;
@property (nonatomic, strong) NSNumber *sugar;
@property (nonatomic, strong) NSNumber *protein;
@property (nonatomic, strong) NSNumber *vitaminA;
@property (nonatomic, strong) NSNumber *vitaminC;
@property (nonatomic, strong) NSNumber *calcium;
@property (nonatomic, strong) NSNumber *iron;


// Designated Initializer (Good to put in this comment)
- (id) initWithData:(NSDictionary *)dict andDate: (NSDate *) date;

@end
