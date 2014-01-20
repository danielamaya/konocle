use utf8;
package Konocle::DB::Schema::Result::Comment;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::Comment

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

=head1 TABLE: C<comments>

=cut

__PACKAGE__->table("comments");

=head1 ACCESSORS

=head2 comment_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'comments_comment_id_seq'

=head2 comment_url_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 comment_user_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 comment_parent_id

  data_type: 'bigint'
  is_nullable: 1

=head2 comment_text

  data_type: 'text'
  is_nullable: 0

=head2 comment_hearts

  data_type: 'bigint'
  default_value: 0
  is_nullable: 0

=head2 comment_spam

  data_type: 'bigint'
  default_value: 0
  is_nullable: 0

=head2 comment_created_date

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "comment_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "comments_comment_id_seq",
  },
  "comment_url_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "comment_user_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "comment_parent_id",
  { data_type => "bigint", is_nullable => 1 },
  "comment_text",
  { data_type => "text", is_nullable => 0 },
  "comment_hearts",
  { data_type => "bigint", default_value => 0, is_nullable => 0 },
  "comment_spam",
  { data_type => "bigint", default_value => 0, is_nullable => 0 },
  "comment_created_date",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</comment_id>

=back

=cut

__PACKAGE__->set_primary_key("comment_id");

=head1 RELATIONS

=head2 comment_url

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::Url>

=cut

__PACKAGE__->belongs_to(
  "comment_url",
  "Konocle::DB::Schema::Result::Url",
  { url_id => "comment_url_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 comment_user

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "comment_user",
  "Konocle::DB::Schema::Result::User",
  { user_id => "comment_user_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 users_comments_loved

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersCommentLoved>

=cut

__PACKAGE__->has_many(
  "users_comments_loved",
  "Konocle::DB::Schema::Result::UsersCommentLoved",
  { "foreign.users_comments_loved_comment_id" => "self.comment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_comments_saved

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersCommentSaved>

=cut

__PACKAGE__->has_many(
  "users_comments_saved",
  "Konocle::DB::Schema::Result::UsersCommentSaved",
  { "foreign.users_comments_saved_comment_id" => "self.comment_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:T5wl6Biu4nY1bajJ3ktVaQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
