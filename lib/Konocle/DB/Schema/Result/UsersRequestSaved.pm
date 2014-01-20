use utf8;
package Konocle::DB::Schema::Result::UsersRequestSaved;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::UsersRequestSaved

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

=head1 TABLE: C<users_requests_saved>

=cut

__PACKAGE__->table("users_requests_saved");

=head1 ACCESSORS

=head2 users_requests_saved_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_requests_saved_users_requests_saved_id_seq'

=head2 users_requests_saved_user_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 users_requests_saved_request_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 users_requests_saved_date

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "users_requests_saved_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_requests_saved_users_requests_saved_id_seq",
  },
  "users_requests_saved_user_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "users_requests_saved_request_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "users_requests_saved_date",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</users_requests_saved_id>

=back

=cut

__PACKAGE__->set_primary_key("users_requests_saved_id");

=head1 RELATIONS

=head2 users_requests_saved_request

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::Request>

=cut

__PACKAGE__->belongs_to(
  "users_requests_saved_request",
  "Konocle::DB::Schema::Result::Request",
  { request_id => "users_requests_saved_request_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 users_requests_saved_user

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "users_requests_saved_user",
  "Konocle::DB::Schema::Result::User",
  { user_id => "users_requests_saved_user_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:A3JgQwiP+AF9VopnRROS2A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
