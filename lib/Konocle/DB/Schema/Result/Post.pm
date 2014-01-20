use utf8;
package Konocle::DB::Schema::Result::Post;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::Post

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

=head1 TABLE: C<posts>

=cut

__PACKAGE__->table("posts");

=head1 ACCESSORS

=head2 post_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'posts_post_id_seq'

=head2 post_title

  data_type: 'varchar'
  is_nullable: 0
  size: 80

=head2 post_description

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 post_text

  data_type: 'text'
  is_nullable: 0

=head2 post_hearts

  data_type: 'bigint'
  default_value: 0
  is_nullable: 0

=head2 post_spam

  data_type: 'bigint'
  default_value: 0
  is_nullable: 0

=head2 post_miscategorized

  data_type: 'bigint'
  default_value: 0
  is_nullable: 0

=head2 post_created_date

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 post_edited_date

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 post_submitted_by

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 post_last_edited_by

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 post_parent_id

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "post_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "posts_post_id_seq",
  },
  "post_title",
  { data_type => "varchar", is_nullable => 0, size => 80 },
  "post_description",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "post_text",
  { data_type => "text", is_nullable => 0 },
  "post_hearts",
  { data_type => "bigint", default_value => 0, is_nullable => 0 },
  "post_spam",
  { data_type => "bigint", default_value => 0, is_nullable => 0 },
  "post_miscategorized",
  { data_type => "bigint", default_value => 0, is_nullable => 0 },
  "post_created_date",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "post_edited_date",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "post_submitted_by",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "post_last_edited_by",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "post_parent_id",
  { data_type => "bigint", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</post_id>

=back

=cut

__PACKAGE__->set_primary_key("post_id");

=head1 RELATIONS

=head2 disciplines_posts

Type: has_many

Related object: L<Konocle::DB::Schema::Result::DisciplinesPost>

=cut

__PACKAGE__->has_many(
  "disciplines_posts",
  "Konocle::DB::Schema::Result::DisciplinesPost",
  { "foreign.disciplines_posts_post_id" => "self.post_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 post_last_edited_by

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "post_last_edited_by",
  "Konocle::DB::Schema::Result::User",
  { user_id => "post_last_edited_by" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 post_submitted_by

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "post_submitted_by",
  "Konocle::DB::Schema::Result::User",
  { user_id => "post_submitted_by" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 tags_posts

Type: has_many

Related object: L<Konocle::DB::Schema::Result::TagsPost>

=cut

__PACKAGE__->has_many(
  "tags_posts",
  "Konocle::DB::Schema::Result::TagsPost",
  { "foreign.tags_posts_post_id" => "self.post_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_posts_loved

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersPostLoved>

=cut

__PACKAGE__->has_many(
  "users_posts_loved",
  "Konocle::DB::Schema::Result::UsersPostLoved",
  { "foreign.users_posts_loved_post_id" => "self.post_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_posts_saved

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersPostSaved>

=cut

__PACKAGE__->has_many(
  "users_posts_saved",
  "Konocle::DB::Schema::Result::UsersPostSaved",
  { "foreign.users_posts_saved_post_id" => "self.post_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:AdvRsZax9nZhysplIW/t0w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
