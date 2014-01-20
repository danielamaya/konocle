use utf8;
package Konocle::DB::Schema::Result::DisciplinesToParent;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::DisciplinesToParent

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

=head1 TABLE: C<disciplines_to_parents>

=cut

__PACKAGE__->table("disciplines_to_parents");

=head1 ACCESSORS

=head2 disciplines_to_parents_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'disciplines_to_parents_disciplines_to_parents_id_seq'

=head2 disciplines_to_parents_parent_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 disciplines_to_parents_child_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "disciplines_to_parents_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "disciplines_to_parents_disciplines_to_parents_id_seq",
  },
  "disciplines_to_parents_parent_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "disciplines_to_parents_child_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</disciplines_to_parents_id>

=back

=cut

__PACKAGE__->set_primary_key("disciplines_to_parents_id");

=head1 RELATIONS

=head2 disciplines_to_parents_child

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::Discipline>

=cut

__PACKAGE__->belongs_to(
  "disciplines_to_parents_child",
  "Konocle::DB::Schema::Result::Discipline",
  { discipline_id => "disciplines_to_parents_child_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 disciplines_to_parents_parent

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::Discipline>

=cut

__PACKAGE__->belongs_to(
  "disciplines_to_parents_parent",
  "Konocle::DB::Schema::Result::Discipline",
  { discipline_id => "disciplines_to_parents_parent_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LvQMuBSb2hU4dWzNwBFifw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
