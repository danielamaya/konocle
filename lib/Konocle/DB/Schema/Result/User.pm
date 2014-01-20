use utf8;
package Konocle::DB::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::User

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

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 user_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_user_id_seq'

=head2 user_login

  data_type: 'character varying[]'
  is_nullable: 0
  size: 20

=head2 user_passwd

  data_type: 'varchar'
  is_nullable: 0
  size: 256

=head2 user_email

  data_type: 'varchar'
  is_nullable: 1
  size: 254

=head2 user_created_date

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 user_urls_loved

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 user_posts_loved

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 user_comments_loved

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=head2 user_edits_loved

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "user_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_user_id_seq",
  },
  "user_login",
  { data_type => "character varying[]", is_nullable => 0, size => 20 },
  "user_passwd",
  { data_type => "varchar", is_nullable => 0, size => 256 },
  "user_email",
  { data_type => "varchar", is_nullable => 1, size => 254 },
  "user_created_date",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "user_urls_loved",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "user_posts_loved",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "user_comments_loved",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
  "user_edits_loved",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<users_user_login_key>

=over 4

=item * L</user_login>

=back

=cut

__PACKAGE__->add_unique_constraint("users_user_login_key", ["user_login"]);

=head1 RELATIONS

=head2 comments

Type: has_many

Related object: L<Konocle::DB::Schema::Result::Comment>

=cut

__PACKAGE__->has_many(
  "comments",
  "Konocle::DB::Schema::Result::Comment",
  { "foreign.comment_user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 posts_post_last_editeds_by

Type: has_many

Related object: L<Konocle::DB::Schema::Result::Post>

=cut

__PACKAGE__->has_many(
  "posts_post_last_editeds_by",
  "Konocle::DB::Schema::Result::Post",
  { "foreign.post_last_edited_by" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 posts_posts_submitted_by

Type: has_many

Related object: L<Konocle::DB::Schema::Result::Post>

=cut

__PACKAGE__->has_many(
  "posts_posts_submitted_by",
  "Konocle::DB::Schema::Result::Post",
  { "foreign.post_submitted_by" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 requests

Type: has_many

Related object: L<Konocle::DB::Schema::Result::Request>

=cut

__PACKAGE__->has_many(
  "requests",
  "Konocle::DB::Schema::Result::Request",
  { "foreign.request_submitted_by" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tags_users

Type: has_many

Related object: L<Konocle::DB::Schema::Result::TagsUser>

=cut

__PACKAGE__->has_many(
  "tags_users",
  "Konocle::DB::Schema::Result::TagsUser",
  { "foreign.tags_users_user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 urls_url_last_editeds_by

Type: has_many

Related object: L<Konocle::DB::Schema::Result::Url>

=cut

__PACKAGE__->has_many(
  "urls_url_last_editeds_by",
  "Konocle::DB::Schema::Result::Url",
  { "foreign.url_last_edited_by" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 urls_urls_submitted_by

Type: has_many

Related object: L<Konocle::DB::Schema::Result::Url>

=cut

__PACKAGE__->has_many(
  "urls_urls_submitted_by",
  "Konocle::DB::Schema::Result::Url",
  { "foreign.url_submitted_by" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_comments_loved

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersCommentLoved>

=cut

__PACKAGE__->has_many(
  "users_comments_loved",
  "Konocle::DB::Schema::Result::UsersCommentLoved",
  { "foreign.users_comments_loved_user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_comments_saved

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersCommentSaved>

=cut

__PACKAGE__->has_many(
  "users_comments_saved",
  "Konocle::DB::Schema::Result::UsersCommentSaved",
  { "foreign.users_comments_saved_user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_disciplines

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersDiscipline>

=cut

__PACKAGE__->has_many(
  "users_disciplines",
  "Konocle::DB::Schema::Result::UsersDiscipline",
  { "foreign.users_disciplines_user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_posts_loved

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersPostLoved>

=cut

__PACKAGE__->has_many(
  "users_posts_loved",
  "Konocle::DB::Schema::Result::UsersPostLoved",
  { "foreign.users_posts_loved_user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_posts_saved

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersPostSaved>

=cut

__PACKAGE__->has_many(
  "users_posts_saved",
  "Konocle::DB::Schema::Result::UsersPostSaved",
  { "foreign.users_posts_saved_user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_requests_loved

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersRequestLoved>

=cut

__PACKAGE__->has_many(
  "users_requests_loved",
  "Konocle::DB::Schema::Result::UsersRequestLoved",
  { "foreign.users_requests_loved_user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_requests_saved

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersRequestSaved>

=cut

__PACKAGE__->has_many(
  "users_requests_saved",
  "Konocle::DB::Schema::Result::UsersRequestSaved",
  { "foreign.users_requests_saved_user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_urls_loved

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersUrlLoved>

=cut

__PACKAGE__->has_many(
  "users_urls_loved",
  "Konocle::DB::Schema::Result::UsersUrlLoved",
  { "foreign.users_urls_loved_user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_urls_saved

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersUrlSaved>

=cut

__PACKAGE__->has_many(
  "users_urls_saved",
  "Konocle::DB::Schema::Result::UsersUrlSaved",
  { "foreign.users_urls_saved_user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WJC/2FyqIdKp4x8OOeZJKw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
