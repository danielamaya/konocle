#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;

use Data::Dumper;
use lib '.';
use RequestSignatureHelper;
use LWP::UserAgent;
use XML::Simple;

use constant myAWSId	    => 'AKIAISS4JGLJCTA7PGIQ';
use constant myAWSSecret    => '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';
use constant myEndPoint	    => 'ecs.amazonaws.com';

$| = 1;
# see if user provided ItemId on command-line
my $itemId = shift || '1000';
my $itemName = shift || 'Books';
getNodes($itemId,$itemName);

sub getNodes {
    my ($itemId,$itemName) = @_;

    say $itemName;

    # Set up the helper
    my $helper = new RequestSignatureHelper (
        +RequestSignatureHelper::kAWSAccessKeyId => myAWSId,
        +RequestSignatureHelper::kAWSSecretKey => myAWSSecret,
        +RequestSignatureHelper::kEndPoint => myEndPoint,
    );

    # A simple ItemLookup request
    my $request = {
        Service => 'AWSECommerceService',
        AssociateTag => 'nothing0d8-20',
        Operation => 'BrowseNodeLookup',
        Version => '2009-03-31',
        BrowseNodeId => $itemId,
    };

    # Sign the request
    my $signedRequest = $helper->sign($request);

    # We can use the helper's canonicalize() function to construct the query string too.
    my $queryString = $helper->canonicalize($signedRequest);
    my $url = "http://" . myEndPoint . "/onca/xml?" . $queryString;

    sleep(1);
    my $ua = LWP::UserAgent->new(env_proxy => 1);
    my $response = $ua->get($url);
    my $content = $response->content();

    my $xmlParser = new XML::Simple();
    my $xml = $xmlParser->XMLin($content);

    #print "Parsed XML is: " . Dumper($xml) . "\n";

    if ($response->is_success()) {
        if ( ref $xml->{BrowseNodes}->{BrowseNode}->{Children}->{BrowseNode} eq 'ARRAY' ) {
            for ( @{ $xml->{BrowseNodes}->{BrowseNode}->{Children}->{BrowseNode} } ) {
                getNodes($_->{BrowseNodeId},"$itemName/$_->{Name}");
            }
        }
    }
    else {
        my $error = findError($xml);
        if (defined $error) {
        print "Error: " . $error->{Code} . ": " . $error->{Message} . "\n";
        } else {
        print "Unknown Error!\n";
        }
    }
}

sub findError {
    my $xml = shift;

    return undef unless ref($xml) eq 'HASH';

    if (exists $xml->{Error}) { return $xml->{Error}; };

    for (keys %$xml) {
	my $error = findError($xml->{$_});
	return $error if defined $error;
    }

    return undef;
}
