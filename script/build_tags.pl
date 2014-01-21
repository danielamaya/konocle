#!/usr/bin/env perl
use strict;
use warnings;
use Mojo::UserAgent;
use DBD::Pg;

my @sites = qw(
    biology.stackexchange.com
    stackoverflow.com
    unix.stackexchange.com
    gamedev.stackexchange.com
    philosophy.stackexchange.com
);

my $dbh = DBI->connect(
    "dbi:Pg:dbname=konocle;host=konocle.com",
    'konocle',
    'ZlqPam#12'
);
my $tag_count = 1;
my $sth = $dbh->prepare("INSERT INTO tags(tag_name,tag_count) VALUES(?,?)");
for my $i (1 .. 10) {
    my $delay = Mojo::IOLoop->delay(sub {
        my $delay = shift;

        my @tags = map { @$_ } map { $_->res->json->{items} } @_;
        for my $tag (@tags) {
            $sth->execute($tag->{name},$tag_count);
        }
    });

    my $ua =  Mojo::UserAgent->new;
    $ua->get( 'http://api.stackexchange.com/2.1/tags?page='.$i.'&pagesize=100&order=desc&sort=popular&site='.$_ => $delay->begin ) for @sites;
    $delay->wait unless Mojo::IOLoop->is_running;
}
$dbh->disconnect;
