use utf8;
package Konocle::DB::Schema::Result::Category;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::Category

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

=head1 TABLE: C<categories>

=cut

__PACKAGE__->table("categories");

=head1 ACCESSORS

=head2 category_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'categories_category_id_seq'

=head2 category_display_name

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 category_created_date

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 category_link_name

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 category_wiki

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "category_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "categories_category_id_seq",
  },
  "category_display_name",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "category_created_date",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "category_link_name",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "category_wiki",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</category_id>

=back

=cut

__PACKAGE__->set_primary_key("category_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<Name must be unique>

=over 4

=item * L</category_display_name>

=back

=cut

__PACKAGE__->add_unique_constraint("Name must be unique", ["category_display_name"]);

=head1 RELATIONS

=head2 categories_disciplines

Type: has_many

Related object: L<Konocle::DB::Schema::Result::CategoriesDiscipline>

=cut

__PACKAGE__->has_many(
  "categories_disciplines",
  "Konocle::DB::Schema::Result::CategoriesDiscipline",
  {
    "foreign.categories_disciplines_category_id" => "self.category_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-09 11:10:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xiKXziMH3s+Wpo7g4dsUQg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
