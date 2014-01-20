use utf8;
package Konocle::DB::Schema::Result::UsersPostLoved;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::UsersPostLoved

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

=head1 TABLE: C<users_posts_loved>

=cut

__PACKAGE__->table("users_posts_loved");

=head1 ACCESSORS

=head2 users_posts_loved_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_posts_loved_users_posts_loved_id_seq'

=head2 users_posts_loved_user_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 users_posts_loved_post_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 users_posts_loved_ip_addr

  data_type: 'varchar'
  is_nullable: 0
  size: 256

=head2 users_posts_loved_date

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "users_posts_loved_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_posts_loved_users_posts_loved_id_seq",
  },
  "users_posts_loved_user_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "users_posts_loved_post_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "users_posts_loved_ip_addr",
  { data_type => "varchar", is_nullable => 0, size => 256 },
  "users_posts_loved_date",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</users_posts_loved_id>

=back

=cut

__PACKAGE__->set_primary_key("users_posts_loved_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<users_posts_loved_users_posts_loved_post_id_users_posts_lov_key>

=over 4

=item * L</users_posts_loved_post_id>

=item * L</users_posts_loved_ip_addr>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "users_posts_loved_users_posts_loved_post_id_users_posts_lov_key",
  ["users_posts_loved_post_id", "users_posts_loved_ip_addr"],
);

=head1 RELATIONS

=head2 users_posts_loved_post

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::Post>

=cut

__PACKAGE__->belongs_to(
  "users_posts_loved_post",
  "Konocle::DB::Schema::Result::Post",
  { post_id => "users_posts_loved_post_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 users_posts_loved_user

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "users_posts_loved_user",
  "Konocle::DB::Schema::Result::User",
  { user_id => "users_posts_loved_user_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XL3ed81+0k3RwMC9QXVbdQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
