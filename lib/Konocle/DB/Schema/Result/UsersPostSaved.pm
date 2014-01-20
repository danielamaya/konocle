use utf8;
package Konocle::DB::Schema::Result::UsersPostSaved;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::UsersPostSaved

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<users_posts_saved>

=cut

__PACKAGE__->table("users_posts_saved");

=head1 ACCESSORS

=head2 users_posts_saved_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_posts_saved_users_posts_saved_id_seq'

=head2 users_posts_saved_user_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 users_posts_saved_post_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 users_posts_saved_date

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "users_posts_saved_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_posts_saved_users_posts_saved_id_seq",
  },
  "users_posts_saved_user_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "users_posts_saved_post_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "users_posts_saved_date",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</users_posts_saved_id>

=back

=cut

__PACKAGE__->set_primary_key("users_posts_saved_id");

=head1 RELATIONS

=head2 users_posts_saved_post

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::Post>

=cut

__PACKAGE__->belongs_to(
  "users_posts_saved_post",
  "Konocle::DB::Schema::Result::Post",
  { post_id => "users_posts_saved_post_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 users_posts_saved_user

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "users_posts_saved_user",
  "Konocle::DB::Schema::Result::User",
  { user_id => "users_posts_saved_user_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:h6MN7qC3nkAKjvQS2TnbwA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
