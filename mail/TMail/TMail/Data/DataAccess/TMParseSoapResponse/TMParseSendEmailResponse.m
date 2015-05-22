//
//  TMParseSendEmailResponse.m
//  TMail
//
//  Created by Ranjith on 5/18/15.
//  Copyright (c) 2015 T-Mobile All rights reserved.
//

#import "TMParseSendEmailResponse.h"

@implementation TMParseSendEmailResponse


-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // Keep track of the current element value
    self.elementValue = string;
    NSLog(@"Found Character :  %@",string);
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"End Element :  %@",elementName);

    // If the element was 'statusCode' or 'statusMessage'
    if ([elementName isEqualToString:@"pfx4:statusCode"]){
        self.sendEmailResponseStatus = self.elementValue;
    }else if([elementName isEqualToString:@"pfx4:statusMessage"]) {
        self.sendEmailResponseMessage = self.elementValue;
    }
}

@end
