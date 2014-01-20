use utf8;
package Konocle::DB::Schema::Result::UserHearted;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::UserHearted

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

=head1 TABLE: C<user_hearted>

=cut

__PACKAGE__->table("user_hearted");

=head1 ACCESSORS

=head2 user_hearted_user_id

  data_type: 'bigint'
  is_nullable: 0

=head2 user_hearted_url_id

  data_type: 'bigint'
  is_nullable: 0

=head2 user_hearted_timestamp

  data_type: 'timestamp with time zone'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "user_hearted_user_id",
  { data_type => "bigint", is_nullable => 0 },
  "user_hearted_url_id",
  { data_type => "bigint", is_nullable => 0 },
  "user_hearted_timestamp",
  { data_type => "timestamp with time zone", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_hearted_user_id>

=item * L</user_hearted_url_id>

=back

=cut

__PACKAGE__->set_primary_key("user_hearted_user_id", "user_hearted_url_id");


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-03 18:37:13
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1FFRSp0aWW/LjxSmpuVKiA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
