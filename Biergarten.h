//
//  Biergarten.h
//  Biergarten
//
//  Created by platzerworld on 24.03.14.
//  Copyright (c) 2014 platzerworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Adresse, Getraenke, Speisen;

@interface Biergarten : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * desclong;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * favorit;
@property (nonatomic, retain) NSNumber * biergartenid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * telefon;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) Adresse *adresse;
@property (nonatomic, retain) Getraenke *getraenke;
@property (nonatomic, retain) Speisen *speisen;

@end
