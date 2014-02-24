#!/usr/bin/env perl
use strict;
use warnings;
use DBD::Pg;
use 5.12.0;

my $dbh = DBI->connect(
    "dbi:Pg:dbname=konocle;host=konocle.com",
    'konocle',
    'ZlqPam#12'
);

open my $in, "<", 'AmazonCategories.txt' or die $!;

while (<$in>) {
    chomp;

    if ( !/\./ ) {
        my $sth = $dbh->prepare("INSERT INTO categories(name) VALUES(?)");
        $sth->execute($_);
    }
    else {
        my ($parent,$current) = (split(/\./))[-2,-1];
        my $sth = $dbh->prepare("SELECT category_id FROM categories where name = ?");
        $sth->execute($parent);
        my $parent_id = $sth->fetchrow_array;

        $sth = $dbh->prepare("INSERT INTO categories(parent_id,name) VALUES(?,?)");
        $sth->execute($parent_id,$current);

    }
}
close $in;
