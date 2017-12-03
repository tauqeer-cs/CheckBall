//
//  NBPhoneMetaClassGenerator.m
//  libPhoneNumber
//
//

#import "NBPhoneMetaClassGenerator.h"
#import "NBPhoneMetaData.h"



@implementation NBPhoneMetaClassGenerator


- (id)init
{
    self = [super init];
    
    if (self) {
    }
    
    return self;
}


- (void)generateMetaClasses
{
    NSDictionary *realMetadata = nil, *testMetadata = nil;
    realMetadata = [self generateMetaData];
    testMetadata = [self generateMetaDataWithTest];
    
    @try {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"src"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
            NSError* error;
            if (![[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]) {
                NSLog(@"[%@] ERROR: attempting to write create MyFolder directory", [self class]);
            }
        }
        
        NSDictionary *mappedRealData = [self mappingObject:realMetadata];
        NSDictionary *mappedTestData = [self mappingObject:testMetadata];
        
        [self createClassWithDictionary:mappedRealData name:@"NBPhoneNumberMetadata"];
        [self createClassWithDictionary:mappedTestData name:@"NBPhoneNumberMetadataForTesting"];
    } @catch (NSException *exception) {
        NSLog(@"Error for creating metadata classes : %@", exception.reason);
    }
}


- (void)createClassWithDictionary:(NSDictionary *)data name:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"src"];
    
    NSString *filePathData = [NSString stringWithFormat:@"%@/%@.plist", dataPath, name];
    NSData *objData = [NSKeyedArchiver archivedDataWithRootObject:data];
    [objData writeToFile:filePathData atomically:YES];
    
    
    
    NSData *fileData = [NSData dataWithContentsOfFile:filePathData];
    NSDictionary *unarchiveData = [NSKeyedUnarchiver unarchiveObjectWithData:fileData];
    
    NSLog(@"Created file to...[%@ / %zu]", filePathData, (unsigned long)[unarchiveData count]);
}


- (NSDictionary *)mappingObject:(NSDictionary *)parsedJSONData
{
    NSMutableDictionary *resMedata = [[NSMutableDictionary alloc] init];
    NSDictionary *countryCodeToRegionCodeMap = [parsedJSONData objectForKey:@"countryCodeToRegionCodeMap"];
    NSDictionary *countryToMetadata = [parsedJSONData objectForKey:@"countryToMetadata"];
    NSLog(@"- countryCodeToRegionCodeMap count [%zu]", (unsigned long)[countryCodeToRegionCodeMap count]);
    NSLog(@"- countryToMetadata          count [%zu]", (unsigned long)[countryToMetadata count]);
    
    NSMutableDictionary *genetatedMetaData = [[NSMutableDictionary alloc] init];
    
    for (id key in [countryToMetadata allKeys])
    {
        id metaData = [countryToMetadata objectForKey:key];
        
        NBPhoneMetaData *newMetaData = [[NBPhoneMetaData alloc] init];
        [newMetaData buildData:metaData];
        
        [genetatedMetaData setObject:newMetaData forKey:key];
    }
    
    [resMedata setObject:countryCodeToRegionCodeMap forKey:@"countryCodeToRegionCodeMap"];
    [resMedata setObject:genetatedMetaData forKey:@"countryToMetadata"];
    
    return resMedata;
}


- (NSString *)documentsDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}


- (NSDictionary *)generateMetaData
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PhoneNumberMetaData" ofType:@"json"];
    return [self parseJSON:filePath];
}


- (NSDictionary *)generateMetaDataWithTest
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"PhoneNumberMetaDataForTesting" ofType:@"json"];
    return [self parseJSON:filePath];
}


- (NSDictionary *)parseJSON:(NSString *)filePath
{
    NSDictionary *jsonRes = nil;
    
    @try {
        NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
        NSError *error = nil;
        jsonRes = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    }
    @catch (NSException *exception) {
        NSLog(@"Error : %@", exception.reason);
    }
    
    return jsonRes;
}



@end
