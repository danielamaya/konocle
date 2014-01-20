use utf8;
package Konocle::DB::Schema::Result::CategoriesDiscipline;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::CategoriesDiscipline

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

=head1 TABLE: C<categories_disciplines>

=cut

__PACKAGE__->table("categories_disciplines");

=head1 ACCESSORS

=head2 categories_disciplines_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'categories_disciplines_categories_disciplines_id_seq'

=head2 categories_disciplines_category_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 categories_disciplines_discipline_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 categories_disciplines_created_date

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "categories_disciplines_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "categories_disciplines_categories_disciplines_id_seq",
  },
  "categories_disciplines_category_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "categories_disciplines_discipline_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "categories_disciplines_created_date",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</categories_disciplines_id>

=back

=cut

__PACKAGE__->set_primary_key("categories_disciplines_id");

=head1 RELATIONS

=head2 categories_disciplines_category

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::Category>

=cut

__PACKAGE__->belongs_to(
  "categories_disciplines_category",
  "Konocle::DB::Schema::Result::Category",
  { category_id => "categories_disciplines_category_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 categories_disciplines_discipline

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::Discipline>

=cut

__PACKAGE__->belongs_to(
  "categories_disciplines_discipline",
  "Konocle::DB::Schema::Result::Discipline",
  { discipline_id => "categories_disciplines_discipline_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6h2XYVoWiQuzKoBKZtD+0Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
