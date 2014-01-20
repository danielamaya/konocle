package Konocle;
use Mojo::Base 'Mojolicious';


use File::Basename 'dirname';
use File::Spec::Functions qw'rel2abs catdir';
use File::ShareDir 'dist_dir';
use Cwd;
use Data::Dumper;

has db => sub {
    my $self = shift;

    my $schema_class = $self->config->{db_schema} or die "Unknown DB Schema Class";
    eval "require $schema_class" or die "Could not load Schema Class ($schema_class). $@\n";

    my $schema = $schema_class->connect(
        @{ $self->config }{ qw/db_dsn db_username db_password db_options/ }
    ) or die "Could not connect to $schema_class using DSN " . $self->config->{db_dsn};

    return $schema;
};

has home_path => sub {
    my $path = $ENV{KONOCKLE_HOME} || getcwd;
    return File::Spec->rel2abs($path);
};

has config_file => sub {
    my $self = shift;
    return $ENV{KONOCLE_CONFIG} if $ENV{KONOCLE_CONFIG};
    return rel2abs( 'konocle.conf', $self->home_path );
};

sub startup {
    my $self = shift;

    $self->load_config;
    $self->setup_plugins;
    $self->setup_routes;
    $self->setup_helpers;

}

sub load_config {
    my $self = shift;

    $self->plugin( Config => {
        file => $self->config_file,
        default => {
            db_schema  => 'Konocle::DB::Schema',
            db_dsn => 'dbi:Pg:dbname=konocle',
            db_username => 'konocle',
            db_password => 'ZlqPam#12',
            db_options => { },
            extra_css => [ ],
            extra_js => [ ],
            extra_static_paths => [ ],
            sanitize => 1,
            secrets => [ '9dd1571a116fccce362d54996c3d8c70c101cad5' ],
        },
    });

    if ( my $db_connect = delete $self->config->{db_connect} ) {
        warn "### Configuration key db_connect is deprecated ###\n";
        if ( ref $db_connect ) {
            @{ $self->config }{ qw/db_dsn db_username db_password db_options/ } = @$db_connect;
        } else {
            $self->config->{db_dsn} = $db_connect;
        }
    }


    # add the files directories to array of static content folders
    # TODO don't repeat
    foreach my $dir ( @{$self->config->{extra_static_paths}} ) {
        # convert relative paths to relative one (to home dir)
        $dir = $self->_to_abs($dir);
        push @{ $self->static->paths }, $dir if -d $dir;
    }


    if ( my $secrets = $self->config->{secrets} ) {
        $self->secrets( $secrets );
    }
}

sub _to_abs {
    my ($self, $dir) = @_;
    unless ( File::Spec->file_name_is_absolute( $dir ) ) {
        $dir = $self->home->rel_dir( $dir );
    }
    return $dir;
}

sub setup_plugins {
    my $self = shift;

    $self->plugin('Mojolicious::Plugin::Bcrypt');


    #
    # Database-based authentication example
    #

    $self->plugin('Mojolicious::Plugin::Authentication' => {

        load_user => sub {

            my ( $self, $uid ) = @_;

            my $schema = $self->schema;

            my $user = $schema->resultset('User')->find({ user_login => $uid });

            if ( $user ) {

                return $user;

            }
            else {

                return;
            }

        },

        validate_user => sub {

            my ( $self, $username, $password ) = @_;

            my $schema = $self->schema;

            my $user = $schema->resultset('User')->single({ user_login => $username });

            return unless $user;

            my $salt = substr $password, 0, 2;

            if ( $self->bcrypt_validate( $password, $user->user_password ) ) {

                $self->session(user_id => $user->user_id);
                $self->session(user => $username);

                return $user->user_login;

            }
            else {

                return;

            }
        },

    });
}

sub setup_routes {
    my $self = shift;
    my $r = $self->routes;

    # Normal route to controller
    $r->get('/')->to('main#index');
    $r->post('/register')->to('main#register');
    $r->any('/login')->to('main#login');
    $r->any('/logout')->to('main#logout');
    $r->post('/search')->to('search#search');

    # URLS
    $r->get('/p/:postid')->to('posts#main');
    $r->post('/u/submit');



    # Posts
    $r->get('/post')->to('posts#new');
    $r->get('/p/:postid')->to('posts#main');
    $r->get('/p/submit/:id')->to('posts#main');

    # Actions
    $r->get('/a/add/:discipline')->to('actions#add');



    # Subjects
    $r->get('/s/:subject')->to('subjects#subject');

    # Profile
    $r->get('/profile')->to('user#profile');

}

sub setup_helpers {
    my $self = shift;

    $self->helper( schema => sub { $self->app->db } );


    $self->helper( 'get_user' => sub {
        my ($self, $name) = @_;
        unless ($name) {
            $name = $self->session->{username};
        }
        return undef unless $name;
        return $self->schema->resultset('User')->single({name => $name});
    });
}

1;
