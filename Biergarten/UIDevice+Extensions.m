//
//  UIDevice+Extensions.m
//
//  MobileTech Conference 2014
//  Copyright (c) 2014 Ivo Wessel. All rights reserved.
//  Fragen zum Quellcode? Unterstützung bei iOS-Projekten? Melden Sie sich bei mir...
//
//  Ivo Wessel
//  Lehrter Str. 57, Haus 2
//  D-10557 Berlin
//  Phone : +49-(0)30-89 62 64 77
//  Mobile: +49-(0)177-4 86 93 77
//  Skype : ivo.wessel
//  E-Mail: email@ivo-wessel.de
//  Web   : www.we-make-apps.com
//
// -------------------------------------------------------------------------------------------------

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <sys/types.h>
#include <net/if.h>
#include <net/if_dl.h>

#import "UIDevice+Extensions.h"

// -------------------------------------------------------------------------------------------------

@implementation UIDevice (Extensions)

// -------------------------------------------------------------------------------------------------

- (NSString *) machine {
   //          -------
   // iPhone Simulator == i386
   // iPhone == iPhone1,1
   // 3G iPhone == iPhone1,2
   // 3GS iPhone == iPhone2,1
   // 1st Gen iPod == iPod1,1
   // 2nd Gen iPod == iPod2,1
   size_t size;
   
   // Set 'oldp' parameter to NULL to get the size of the data
   // returned so we can allocate appropriate amount of space
   sysctlbyname("hw.machine", NULL, &size, NULL, 0);
   
   // Allocate the space to store name
   char *name = malloc(size);
   
   // Get the platform name
   sysctlbyname("hw.machine", name, &size, NULL, 0);
   
   // Place name into a string
   NSString *machine = @(name);
   
   // Done with this
   free(name);
   
   return machine;
}

// -------------------------------------------------------------------------------------------------

+ (NSString *) uniqueId {
   //          --------
   return [[UIDevice macAddress] stringFromMD5];
}

// -------------------------------------------------------------------------------------------------

+ (NSString *) macAddress {
   //          ----------
   int                 mib[6];
   size_t              len;
   char                *buf;
   unsigned char       *ptr;
   struct if_msghdr    *ifm;
   struct sockaddr_dl  *sdl;
   
   mib[0] = CTL_NET;
   mib[1] = AF_ROUTE;
   mib[2] = 0;
   mib[3] = AF_LINK;
   mib[4] = NET_RT_IFLIST;
   
   if ((mib[5] = if_nametoindex("en0")) == 0) {
      printf("Error: if_nametoindex error\n");
      return NULL;
   }
   
   if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
      printf("Error: sysctl, take 1\n");
      return NULL;
   }
   
   if ((buf = malloc(len)) == NULL) {
      printf("Could not allocate memory. error!\n");
      return NULL;
   }
   
   if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
      printf("Error: sysctl, take 2");
      free(buf);
      return NULL;
   }
   
   ifm = (struct if_msghdr *)buf;
   sdl = (struct sockaddr_dl *)(ifm + 1);
   ptr = (unsigned char *)LLADDR(sdl);
   NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                          *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
   free(buf);
   
   return outstring;
}

// -------------------------------------------------------------------------------------------------

+ (BOOL) isPad {
   //    -----
   return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

// -------------------------------------------------------------------------------------------------

+ (BOOL) isPhone {
   //    -------
   return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

// -------------------------------------------------------------------------------------------------

+ (BOOL) isOS7 {
   //    -----
   return floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1;
   
   /*
    NSString *sVersion = [[UIDevice currentDevice] systemVersion];
    
    return [sVersion floatValue] >= 7.0;
    */
}

// -------------------------------------------------------------------------------------------------

@end
