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

    # my $schema = $self->schema is how we grab our database handle (connection to the database)
    # We then take the parameters given to use (username, password and email)
    # and create the entry in the database table users. DBIx::Class takes the plural off a
    # database table, and capitalizes the first letter. So, if in your database you have
    # a table called users, DBIx::Class will call it User and you will access it
    # as User (not users).

    # The above code creates the entry in the database.

    # Now, below we redirect to login with POST paramaters username and password.
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
