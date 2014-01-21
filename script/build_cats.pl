#!/usr/bin/env perl
use strict;
use warnings;
use Mojo::UserAgent;
use DBD::Pg;

my @categories = (
'1:African History',
'1:American History',
'1:Ancient History',
'1:History of Asia',
'1:History of Europe',
'1:Chinese History',
'1:Cultural History',
'1:Diplomatic History',
'1:Economic History',
'1:Ethnohistory',
'1:Greek History',
'1:History of Education',
'1:History of Science and Technology',
'1,5:History of Philosophy',
'1:Iranian History',
'1:Indian History',
'1:Indonesian History',
'1:Intellectual History',
'1,39:Military History',
'1:Modern History',
'1,15:Political History',
'1:World History',
);

my $dbh = DBI->connect(
    "dbi:Pg:dbname=konocle",
    'konocle',
    'ZlqPam#12'
);



my $counter = 1;
foreach my $cat (@categories) {
    my ($pkey,$disc)=split(/:/,$cat);

    my $sth = $dbh->prepare("INSERT INTO disciplines (discipline_name) VALUES(?)");
    $sth->execute($cat);

    my @pkeys = split(/,/,$pkey);

    foreach my $pizzle (@pkeys) {
        my $sth = $dbh->prepare("INSERT INTO categories_disciplines(categories_disciplines_category_id,categories_disciplines_discipline_id) VALUES(?,?)");
        $sth->execute($pizzle,$counter);
    }
        $counter++;
}
