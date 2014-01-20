use utf8;
package Konocle::DB::Schema::Result::TagsDiscipline;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::TagsDiscipline

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

=head1 TABLE: C<tags_disciplines>

=cut

__PACKAGE__->table("tags_disciplines");

=head1 ACCESSORS

=head2 tags_disciplines_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'tags_disciplines_tags_disciplines_id_seq'

=head2 tags_disciplines_discipline_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 tags_disciplines_tag_id

  data_type: 'bigint'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "tags_disciplines_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "tags_disciplines_tags_disciplines_id_seq",
  },
  "tags_disciplines_discipline_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "tags_disciplines_tag_id",
  { data_type => "bigint", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</tags_disciplines_id>

=back

=cut

__PACKAGE__->set_primary_key("tags_disciplines_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<tags_disciplines_tags_disciplines_discipline_id_tags_discip_key>

=over 4

=item * L</tags_disciplines_discipline_id>

=item * L</tags_disciplines_tag_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "tags_disciplines_tags_disciplines_discipline_id_tags_discip_key",
  ["tags_disciplines_discipline_id", "tags_disciplines_tag_id"],
);

=head1 RELATIONS

=head2 tags_disciplines_discipline

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::Discipline>

=cut

__PACKAGE__->belongs_to(
  "tags_disciplines_discipline",
  "Konocle::DB::Schema::Result::Discipline",
  { discipline_id => "tags_disciplines_discipline_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 tags_disciplines_discipline_2

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::Tag>

=cut

__PACKAGE__->belongs_to(
  "tags_disciplines_discipline_2",
  "Konocle::DB::Schema::Result::Tag",
  { tag_id => "tags_disciplines_discipline_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hnpE32G/2Hvd/yItezYfww


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
