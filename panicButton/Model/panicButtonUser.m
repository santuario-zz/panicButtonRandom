//
//  panicButtonUser.m
//  panicButton
//
//  Created by 3π on 3/12/14.
//  Copyright (c) 2014 3π. All rights reserved.
//

#import "panicButtonUser.h"

@interface panicButtonUser()
@property (nonatomic, strong) NSMutableArray *contacts;
@end

@implementation panicButtonUser


#pragma mark -
#pragma mark Lazy Instantiation Methods
#pragma mark -

// Lazy instantiation of Contacts Array
-(NSMutableArray *) contacts{
    if(!_contacts) _contacts = [[NSMutableArray alloc] init];
    return _contacts;
}


#pragma mark -
#pragma mark Singleton Methods
#pragma mark -



+(id)sharedPanicButtonUser{
    static panicButtonUser *sharedMyPanicButtonUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedMyPanicButtonUser = [[self alloc] init];
    });
    
    return sharedMyPanicButtonUser;
}

-(id)init{
    
    if(self = [super init]){
        //[self checkIfUserIsRegistered];
    }
    
    return self;
}

-(instancetype)initWithUserID:(NSUInteger)usrID{
    
    self = [super init];
    
    if(self){
        //[self checkIfUserIsRegistered];
    }
    
    return self;
}


-(void)dealloc{
    
}


#pragma mark -
#pragma mark Panic Button USER Methods
#pragma mark -

-(BOOL)checkIfUserIsRegistered{
    
    NSLog(@"panicButtonUser :: checkIfUserIsRegistered");
    
    BOOL isRegistered = NO;
    
    NSFileManager *filemgr;
    NSString *dataFile;
    NSString *docsDir;
    NSArray *dirPaths;
    
    filemgr = [NSFileManager defaultManager];
    
    // Identify the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the data file
    dataFile = [docsDir stringByAppendingPathComponent: @"userFile.txt"];
    
    // Check if the file already exists
    if ([filemgr fileExistsAtPath: dataFile])
    {
        // Read file contents and display in textBox
        NSData *databuffer;
        databuffer = [filemgr contentsAtPath: dataFile];
        
        NSString *datastring = [[NSString alloc] initWithData: databuffer encoding:NSASCIIStringEncoding];
        
        NSLog(@"%@",datastring);
        isRegistered = YES;
        
    }
    
    return isRegistered;
}

-(void)registerNewUser{
    NSLog(@"panicButtonUser :: registerNewUser");
    
    NSString *someText = @"{'userID':0,'name':'','email':'','phone':0}";
    
    NSError *error = nil;
    
    NSString *path = [[self applicationDocumentsDirectory].path
                      stringByAppendingPathComponent:@"userFile.txt"];
    
    BOOL succeeded = [someText writeToFile:path atomically:YES
                                  encoding:NSUTF8StringEncoding error:nil];
    
    if (succeeded) {
        NSLog(@"Success at: %@",path);
    } else {
        NSLog(@"Failed to store. Error: %@",error);
    }
    
    
    
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}



@end
