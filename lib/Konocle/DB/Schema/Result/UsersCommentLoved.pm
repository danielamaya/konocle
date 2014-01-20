use utf8;
package Konocle::DB::Schema::Result::UsersCommentLoved;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::UsersCommentLoved

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

=head1 TABLE: C<users_comments_loved>

=cut

__PACKAGE__->table("users_comments_loved");

=head1 ACCESSORS

=head2 users_comments_loved_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_comments_loved_users_comments_loved_id_seq'

=head2 users_comments_loved_user_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 users_comments_loved_comment_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 users_comments_loved_ip_addr

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 users_comments_loved_date

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "users_comments_loved_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_comments_loved_users_comments_loved_id_seq",
  },
  "users_comments_loved_user_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "users_comments_loved_comment_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "users_comments_loved_ip_addr",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "users_comments_loved_date",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</users_comments_loved_id>

=back

=cut

__PACKAGE__->set_primary_key("users_comments_loved_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<users_comments_loved unique>

=over 4

=item * L</users_comments_loved_comment_id>

=item * L</users_comments_loved_ip_addr>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "users_comments_loved unique",
  [
    "users_comments_loved_comment_id",
    "users_comments_loved_ip_addr",
  ],
);

=head1 RELATIONS

=head2 users_comments_loved_comment

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::Comment>

=cut

__PACKAGE__->belongs_to(
  "users_comments_loved_comment",
  "Konocle::DB::Schema::Result::Comment",
  { comment_id => "users_comments_loved_comment_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 users_comments_loved_user

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "users_comments_loved_user",
  "Konocle::DB::Schema::Result::User",
  { user_id => "users_comments_loved_user_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Jg9Rgd02l+l7HOJE3H6Uew


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
