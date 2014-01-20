use utf8;
package Konocle::DB::Schema::Result::UsersCommentSaved;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::UsersCommentSaved

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

=head1 TABLE: C<users_comments_saved>

=cut

__PACKAGE__->table("users_comments_saved");

=head1 ACCESSORS

=head2 users_comments_saved_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_comments_saved_users_comments_saved_id_seq'

=head2 users_comments_saved_user_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 users_comments_saved_comment_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 users_comments_saved_date

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "users_comments_saved_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_comments_saved_users_comments_saved_id_seq",
  },
  "users_comments_saved_user_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "users_comments_saved_comment_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "users_comments_saved_date",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</users_comments_saved_id>

=back

=cut

__PACKAGE__->set_primary_key("users_comments_saved_id");

=head1 RELATIONS

=head2 users_comments_saved_comment

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::Comment>

=cut

__PACKAGE__->belongs_to(
  "users_comments_saved_comment",
  "Konocle::DB::Schema::Result::Comment",
  { comment_id => "users_comments_saved_comment_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 users_comments_saved_user

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "users_comments_saved_user",
  "Konocle::DB::Schema::Result::User",
  { user_id => "users_comments_saved_user_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:s4VM5QzrIugkQGWsefZU3Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
