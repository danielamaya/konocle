use utf8;
package Konocle::DB::Schema::Result::Badge;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::Badge

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

=head1 TABLE: C<badges>

=cut

__PACKAGE__->table("badges");

=head1 ACCESSORS

=head2 badge_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'badges_badge_id_seq'

=head2 badge_name

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=head2 badge_reputation

  data_type: 'bigint'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "badge_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "badges_badge_id_seq",
  },
  "badge_name",
  { data_type => "varchar", is_nullable => 0, size => 32 },
  "badge_reputation",
  { data_type => "bigint", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</badge_id>

=back

=cut

__PACKAGE__->set_primary_key("badge_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<Badge Name>

=over 4

=item * L</badge_name>

=back

=cut

__PACKAGE__->add_unique_constraint("Badge Name", ["badge_name"]);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-03 18:37:13
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fYcBerBvY6uqH6cip9ZiKg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
