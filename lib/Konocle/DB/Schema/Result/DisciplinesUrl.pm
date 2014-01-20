use utf8;
package Konocle::DB::Schema::Result::DisciplinesUrl;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::DisciplinesUrl

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

=head1 TABLE: C<disciplines_urls>

=cut

__PACKAGE__->table("disciplines_urls");

=head1 ACCESSORS

=head2 disciplines_urls_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'disciplines_urls_disciplines_urls_id_seq'

=head2 disciplines_urls_url_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 disciplines_urls_discipline_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "disciplines_urls_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "disciplines_urls_disciplines_urls_id_seq",
  },
  "disciplines_urls_url_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "disciplines_urls_discipline_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</disciplines_urls_id>

=back

=cut

__PACKAGE__->set_primary_key("disciplines_urls_id");

=head1 RELATIONS

=head2 disciplines_urls_discipline

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::Discipline>

=cut

__PACKAGE__->belongs_to(
  "disciplines_urls_discipline",
  "Konocle::DB::Schema::Result::Discipline",
  { discipline_id => "disciplines_urls_discipline_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 disciplines_urls_url

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::Url>

=cut

__PACKAGE__->belongs_to(
  "disciplines_urls_url",
  "Konocle::DB::Schema::Result::Url",
  { url_id => "disciplines_urls_url_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Y0Hup07GlRsIG9PMuxZ37A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
