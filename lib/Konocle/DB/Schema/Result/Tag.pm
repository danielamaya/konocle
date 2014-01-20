use utf8;
package Konocle::DB::Schema::Result::Tag;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::Tag

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

=head1 TABLE: C<tags>

=cut

__PACKAGE__->table("tags");

=head1 ACCESSORS

=head2 tag_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'tags_tag_id_seq'

=head2 tag_name

  data_type: 'varchar'
  is_nullable: 0
  size: 25

=head2 tag_description

  data_type: 'text'
  is_nullable: 1

=head2 tag_count

  data_type: 'bigint'
  default_value: 0
  is_nullable: 0

=head2 tag_created_date

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "tag_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "tags_tag_id_seq",
  },
  "tag_name",
  { data_type => "varchar", is_nullable => 0, size => 25 },
  "tag_description",
  { data_type => "text", is_nullable => 1 },
  "tag_count",
  { data_type => "bigint", default_value => 0, is_nullable => 0 },
  "tag_created_date",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</tag_id>

=back

=cut

__PACKAGE__->set_primary_key("tag_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<tags_tag_name_key>

=over 4

=item * L</tag_name>

=back

=cut

__PACKAGE__->add_unique_constraint("tags_tag_name_key", ["tag_name"]);

=head1 RELATIONS

=head2 tags_disciplines

Type: has_many

Related object: L<Konocle::DB::Schema::Result::TagsDiscipline>

=cut

__PACKAGE__->has_many(
  "tags_disciplines",
  "Konocle::DB::Schema::Result::TagsDiscipline",
  { "foreign.tags_disciplines_discipline_id" => "self.tag_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tags_posts

Type: has_many

Related object: L<Konocle::DB::Schema::Result::TagsPost>

=cut

__PACKAGE__->has_many(
  "tags_posts",
  "Konocle::DB::Schema::Result::TagsPost",
  { "foreign.tags_posts_tag_id" => "self.tag_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tags_requests

Type: has_many

Related object: L<Konocle::DB::Schema::Result::TagsRequest>

=cut

__PACKAGE__->has_many(
  "tags_requests",
  "Konocle::DB::Schema::Result::TagsRequest",
  { "foreign.tags_requests_tag_id" => "self.tag_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tags_urls

Type: has_many

Related object: L<Konocle::DB::Schema::Result::TagsUrl>

=cut

__PACKAGE__->has_many(
  "tags_urls",
  "Konocle::DB::Schema::Result::TagsUrl",
  { "foreign.tags_urls_tag_id" => "self.tag_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tags_users

Type: has_many

Related object: L<Konocle::DB::Schema::Result::TagsUser>

=cut

__PACKAGE__->has_many(
  "tags_users",
  "Konocle::DB::Schema::Result::TagsUser",
  { "foreign.tags_users_tag_id" => "self.tag_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JIuh5frAhpFboZpmdc0UQw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
