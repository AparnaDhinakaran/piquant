//
//  Food.m
//  Piquant
//
//  Created by Eugene Wong on 12/5/14.
//  Copyright (c) 2014 raweng. All rights reserved.
//

#import "Food.h"

@implementation Food

- (id) initWithData:(NSDictionary *)dict andDate: (NSDate *) date{
    self = [super init];
    if (self) {
        self.dayEaten = date;
        self.calories = [dict objectForKey:@"nf_calories"];
        self.caloriesFromFat = [dict objectForKey:@"nf_calories_from_fat"] ;
        self.totalFat = [dict objectForKey:@"nf_total_fat"] ;
        self.saturatedFat = [dict objectForKey:@"nf_saturated_fat"];
        self.transFattyAcid = [dict objectForKey:@"nf_trans_fatty_acid"];
        self.polysaturatedFat = [dict objectForKey:@"nf_polysaturated_fat"];
        self.monosaturatedFat = [dict objectForKey:@"nf_monosaturated_fat"];
        self.cholesterol = [dict objectForKey:@"nf_cholesterol"];
        self.sodium = [dict objectForKey:@"nf_sodium"];
        self.totalCarbs = [dict objectForKey:@"nf_total_carbohydrate"];
        self.dietaryFiber = [dict objectForKey:@"nf_dietary_fiber"];
        self.sugar = [dict objectForKey:@"nf_sugars"];
        self.protein = [dict objectForKey:@"nf_protein"];
        self.vitaminA = [dict objectForKey:@"nf_vitamin_a_dv"];
        self.vitaminC = [dict objectForKey:@"nf_vitamin_c_dv"];
        self.calcium = [dict objectForKey:@"nf_calcium_dv"];
        self.iron = [dict objectForKey:@"nf_iron_dv"];
    }
    return self;
}

@end
