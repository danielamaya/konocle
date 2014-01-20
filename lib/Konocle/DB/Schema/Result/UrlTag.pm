use utf8;
package Konocle::DB::Schema::Result::UrlTag;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::UrlTag

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

=head1 TABLE: C<url_tags>

=cut

__PACKAGE__->table("url_tags");

=head1 ACCESSORS

=head2 url_tags_url_id

  data_type: 'bigint'
  is_nullable: 0

=head2 url_tags_tag_id

  data_type: 'bigint'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "url_tags_url_id",
  { data_type => "bigint", is_nullable => 0 },
  "url_tags_tag_id",
  { data_type => "bigint", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</url_tags_url_id>

=item * L</url_tags_tag_id>

=back

=cut

__PACKAGE__->set_primary_key("url_tags_url_id", "url_tags_tag_id");


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-04 21:03:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5SUd8tFpDxp5Dbidr4C7Lw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
