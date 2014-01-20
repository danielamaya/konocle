package Konocle::Profile;
use Mojo::Base 'Mojolicious::Controller';

sub view_user {
    my $self = shift;
    my $user = $self->param('user');

    if ( $user eq $self->session->{user} ) {

    }
    else {

    }

}

1;
