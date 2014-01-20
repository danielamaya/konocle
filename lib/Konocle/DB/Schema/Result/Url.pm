use utf8;
package Konocle::DB::Schema::Result::Url;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::Url

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

=head1 TABLE: C<urls>

=cut

__PACKAGE__->table("urls");

=head1 ACCESSORS

=head2 url_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'urls_url_id_seq'

=head2 url_title

  data_type: 'character[]'
  is_nullable: 0
  size: 80

=head2 url_address

  data_type: 'varchar'
  is_nullable: 0
  size: 2500

=head2 url_description

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 url_hearts

  data_type: 'bigint'
  default_value: 0
  is_nullable: 0

=head2 url_spam

  data_type: 'bigint'
  default_value: 0
  is_nullable: 0

=head2 url_broken

  data_type: 'bigint'
  default_value: 0
  is_nullable: 0

=head2 url_miscategorized

  data_type: 'bigint'
  default_value: 0
  is_nullable: 0

=head2 url_created_date

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 url_last_edited

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 url_submitted_by

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 url_last_edited_by

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "url_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "urls_url_id_seq",
  },
  "url_title",
  { data_type => "character[]", is_nullable => 0, size => 80 },
  "url_address",
  { data_type => "varchar", is_nullable => 0, size => 2500 },
  "url_description",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "url_hearts",
  { data_type => "bigint", default_value => 0, is_nullable => 0 },
  "url_spam",
  { data_type => "bigint", default_value => 0, is_nullable => 0 },
  "url_broken",
  { data_type => "bigint", default_value => 0, is_nullable => 0 },
  "url_miscategorized",
  { data_type => "bigint", default_value => 0, is_nullable => 0 },
  "url_created_date",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "url_last_edited",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "url_submitted_by",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "url_last_edited_by",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</url_id>

=back

=cut

__PACKAGE__->set_primary_key("url_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<urls_url_address_key>

=over 4

=item * L</url_address>

=back

=cut

__PACKAGE__->add_unique_constraint("urls_url_address_key", ["url_address"]);

=head1 RELATIONS

=head2 comments

Type: has_many

Related object: L<Konocle::DB::Schema::Result::Comment>

=cut

__PACKAGE__->has_many(
  "comments",
  "Konocle::DB::Schema::Result::Comment",
  { "foreign.comment_url_id" => "self.url_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 disciplines_urls

Type: has_many

Related object: L<Konocle::DB::Schema::Result::DisciplinesUrl>

=cut

__PACKAGE__->has_many(
  "disciplines_urls",
  "Konocle::DB::Schema::Result::DisciplinesUrl",
  { "foreign.disciplines_urls_url_id" => "self.url_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tags_urls

Type: has_many

Related object: L<Konocle::DB::Schema::Result::TagsUrl>

=cut

__PACKAGE__->has_many(
  "tags_urls",
  "Konocle::DB::Schema::Result::TagsUrl",
  { "foreign.tags_urls_url_id" => "self.url_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 url_last_edited_by

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "url_last_edited_by",
  "Konocle::DB::Schema::Result::User",
  { user_id => "url_last_edited_by" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 url_submitted_by

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "url_submitted_by",
  "Konocle::DB::Schema::Result::User",
  { user_id => "url_submitted_by" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 users_urls_loved

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersUrlLoved>

=cut

__PACKAGE__->has_many(
  "users_urls_loved",
  "Konocle::DB::Schema::Result::UsersUrlLoved",
  { "foreign.users_urls_loved_url_id" => "self.url_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_urls_saved

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersUrlSaved>

=cut

__PACKAGE__->has_many(
  "users_urls_saved",
  "Konocle::DB::Schema::Result::UsersUrlSaved",
  { "foreign.users_urls_saved_url_id" => "self.url_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:d4HEXIAi3n7sz2Ef76UsIg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
