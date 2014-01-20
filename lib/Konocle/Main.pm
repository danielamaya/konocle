package Konocle::Main;
use Mojo::Base 'Mojolicious::Controller';

sub register {
    my $self = shift;

    my $username = $self->param('username');
    my $email = $self->param('email');
    my $password = $self->bcrypt( $self->param('password') );


    my $schema = $self->schema;
    $schema->resultset('User')->create(
        {
            user_login => $username,
            user_password => $password,
            user_email => $email,
        }
    );

    $self->redirect_to('/login', username => $username, password => $password);
};

sub login {
    my $self = shift;

    my $username = $self->param('username') || q{};
    my $password = $self->param('password');

    if ( $self->authenticate( $username, $password ) ) {

        $self->redirect_to('/');

    }
    else {

        $self->render( text => 'Invalid credentials!' );

    }
}

sub logout {
    my $self = shift;

    if ( $self->is_user_authenticated ) {
        delete $self->session->{auth_data};
        delete $self->stash->{__authentication__};
    }
    $self->redirect_to( '/' );
}
1;
