//
//  BiergartenGAEFetcher.m
//  BiergartenApp
//
//  Created by Günter Platzer on 17.08.12.
//  Copyright (c) 2012 Günter Platzer. All rights reserved.
//

#import "BiergartenGAEFetcher.h"
#import "Biergarten.h"
#import "Adresse.h"
#import "Getraenke.h"
#import "Speisen.h"
#import "PWDataManager.h"
#import "Constants.h"

#define kBiergartenURL [NSURL URLWithString: @"http://biergartenservice.appspot.com/platzerworld/biergarten/holebiergarten"] //
#define kBiergartenQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1


@implementation BiergartenGAEFetcher

- (void) loadBiergaerten
{
    
    dispatch_async(kBiergartenQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: kBiergartenURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData  options:kNilOptions error:&error];
    
    NSArray *items1 = [[PWDataManager sharedManager] fetchEntitiesForClass:[Biergarten class] withPredicate:nil];
    
    for (Biergarten *biergarten in items1) {
        NSLog(@"Biergarten mit Namen %@ und adresse %@ Biermarke %@ und Speise %@ gefunden",
              biergarten.name, biergarten.adresse.strasse, biergarten.getraenke.biermarke, biergarten.speisen.lieblingsgericht);
    }


    
    NSArray* latestLoans = [json objectForKey:cAttributeBiergartenliste]; //2
    
    NSLog(@"Biergaerten: %@", latestLoans); //3
    
    
    for (int i = 0; i < [latestLoans count]; i++) {
        // 1) Get the latest loan
        NSDictionary* loan = [latestLoans objectAtIndex:i];
        NSLog(@"Biergaerten: %@", loan); //3
        
        NSString* biergartenId = [loan objectForKey:cAttributeId];
        NSString* name = [loan objectForKey:cAttributeName];
        NSString* strasse = [loan objectForKey:cAttributeStrasse];
        NSString* plz = [loan objectForKey:cAttributePlz];
        NSString* ort = [loan objectForKey:cAttributeOrt];
        NSString* telefon = [loan objectForKey:cAttributeTelefon];
        NSString* email = [loan objectForKey:cAttributeEmail];
        NSString* url = [loan objectForKey:cAttributeUrl];
        NSString* latitude = [loan objectForKey:cAttributeLatitude];
        NSString* longitude = [loan objectForKey:cAttributeLongitude];
        NSString* desc = [loan objectForKey:cAttributeDesc];
        NSString* desclong = [loan objectForKey:cAttributeDesclong];
        NSString* mass = [loan objectForKey:cAttributeMass];
        NSString* apfelschorle = [loan objectForKey:cAttributeApfelschorle];
        NSString* riesenbreze = [loan objectForKey:cAttributeRiesenbreze];
        NSString* obazda = [loan objectForKey:cAttributeObazda];
        NSString* biermarke = [loan objectForKey:cAttributeBiermarke];
        NSString* lieblingsgericht = [loan objectForKey:cAttributeLieblingsgericht];
        NSString* speisenkommentar = [loan objectForKey:cAttributeSpeisenkommentar];
        NSString* favorit = [loan objectForKey:cAttributeFavorit];
        
        // [[PWDataManager sharedManager] managedObjectContext] ;
     
        Biergarten *biergarten = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass ([Biergarten class]) inManagedObjectContext:[[PWDataManager sharedManager] managedObjectContext]];
        
        biergarten.biergartenid =  [NSNumber numberWithInt:[biergartenId integerValue]];
        biergarten.name = name;
        biergarten.telefon = telefon;
        biergarten.email = email;
        biergarten.url = url;
        biergarten.desc = desc;
        biergarten.desclong = desclong;
        biergarten.favorit = 0;
        
        
        Adresse *adresse = [[PWDataManager sharedManager] insertManagedObjectOfClass:[Adresse class ]];
        adresse.strasse = strasse;
        adresse.plz = plz;
        adresse.ort = ort;
        adresse.latitude =   [NSNumber numberWithFloat:[[latitude stringByReplacingOccurrencesOfString:@"," withString:@"."] floatValue]];
        adresse.longitude =  [NSNumber numberWithFloat:[[longitude stringByReplacingOccurrencesOfString:@"," withString:@"."]  floatValue]];
        NSLog(@"Adresse: %@", adresse);
        
        Getraenke *getraenke = [[PWDataManager sharedManager] insertManagedObjectOfClass:[Getraenke class ]];
        getraenke.biermarke = biermarke;
        getraenke.mass = mass;
        getraenke.apfelschorle = apfelschorle;
        
        Speisen *speisen = [[PWDataManager sharedManager] insertManagedObjectOfClass:[Speisen class ]];
        speisen.lieblingsgericht = lieblingsgericht;
        speisen.riesenbreze = riesenbreze;
        speisen.obazda = obazda;
        speisen.kommentar = speisenkommentar;
        
        biergarten.adresse = adresse;
        biergarten.speisen = speisen;
        biergarten.getraenke = getraenke;
        
        [[PWDataManager sharedManager] saveManagedObjectContext];    }
    
    NSArray *items = [[PWDataManager sharedManager] fetchEntitiesForClass:[Biergarten class] withPredicate:nil];
    
    for (Biergarten *biergarten in items) {
        NSLog(@"Biergarten mit Namen %@ und adresse %@ Biermarke %@ und Speise %@ gefunden",
              biergarten.name, biergarten.adresse.strasse, biergarten.getraenke.biermarke, biergarten.speisen.lieblingsgericht);
    }

    
    // [self storeData];
}

- (void) storeData
{
    // Override point for customization after application launch.
    
    Biergarten *biergarten = [[PWDataManager sharedManager] insertManagedObjectOfClass:[Biergarten class ]];
    biergarten.name = @"Aumeister";
    
    Adresse *adresse = [[PWDataManager sharedManager] insertManagedObjectOfClass:[Adresse class ]];
    adresse.strasse = @"Aumeisterweg 3";
    
    Getraenke *getraenke =  [[PWDataManager sharedManager] insertManagedObjectOfClass:[Getraenke class ]];
    getraenke.biermarke = @"Hofbräu";
    
    Speisen *speisen = [[PWDataManager sharedManager] insertManagedObjectOfClass:[Speisen class ]];
    speisen.lieblingsgericht = @"Steckerl-Fisch";
    
    biergarten.adresse = adresse;
    biergarten.speisen = speisen;
    biergarten.getraenke = getraenke;
    
    [[PWDataManager sharedManager] saveManagedObjectContext];
    
    /*
     Person *person = [JSMCoreDataHelper insertManagedObjectOfClass:[Person class] inManagedObjectContext:context];
     person.name = @"Frank Jüstel 2";
     
     Postanschrift *postanschrift = [JSMCoreDataHelper insertManagedObjectOfClass:[Postanschrift class] inManagedObjectContext:context];
     postanschrift.adresse = @"Am Pfahlgraben 20, 61239 Ober-Mören";
     
     person.postanschrift = postanschrift;
     
     [JSMCoreDataHelper saveManagedObjectContext:context];
     */
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@", @"a"];
    
    NSArray *items = [[PWDataManager sharedManager] fetchEntitiesForClass:[Biergarten class] withPredicate:nil];

    
    for (Biergarten *biergarten in items) {
        NSLog(@"Biergarten mit Namen %@ und adresse %@ gefunden", biergarten.name, biergarten.desclong);
    }
    
    /*
    NSManagedObjectContext *context = [self managedObjectContext];
    Biergarten *biergarten = [NSEntityDescription insertNewObjectForEntityForName:@"Biergarten" inManagedObjectContext:context];
    biergarten.name = @"Aumeister";
    
    
    Adresse *adresse = [NSEntityDescription insertNewObjectForEntityForName:@"Adresse" inManagedObjectContext:context];
    adresse.latitude = @3;
    biergarten.adresse = adresse;
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    // Test listing all FailedBankInfos from the store
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Biergarten" inManagedObjectContext:context];
    
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Biergarten *biergarten in fetchedObjects) {
        NSLog(@"Name: %@", biergarten.name);
        
        Adresse *adressen = biergarten.adresse;
        NSLog(@"Latitude: %@", adressen.latitude);
    }
     */

}


@end
