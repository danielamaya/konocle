use utf8;
package Konocle::DB::Schema::Result::Request;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::Request

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

=head1 TABLE: C<requests>

=cut

__PACKAGE__->table("requests");

=head1 ACCESSORS

=head2 request_title

  data_type: 'varchar'
  is_nullable: 0
  size: 80

=head2 request_desc

  data_type: 'varchar'
  is_nullable: 0
  size: 250

=head2 request_submitted_by

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 request_submitted_date

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=head2 request_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'requests_request_id_seq'

=cut

__PACKAGE__->add_columns(
  "request_title",
  { data_type => "varchar", is_nullable => 0, size => 80 },
  "request_desc",
  { data_type => "varchar", is_nullable => 0, size => 250 },
  "request_submitted_by",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "request_submitted_date",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
  "request_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "requests_request_id_seq",
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</request_id>

=back

=cut

__PACKAGE__->set_primary_key("request_id");

=head1 RELATIONS

=head2 disciplines_requests

Type: has_many

Related object: L<Konocle::DB::Schema::Result::DisciplinesRequest>

=cut

__PACKAGE__->has_many(
  "disciplines_requests",
  "Konocle::DB::Schema::Result::DisciplinesRequest",
  { "foreign.disciplines_requests_request_id" => "self.request_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 request_submitted_by

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "request_submitted_by",
  "Konocle::DB::Schema::Result::User",
  { user_id => "request_submitted_by" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 tags_requests

Type: has_many

Related object: L<Konocle::DB::Schema::Result::TagsRequest>

=cut

__PACKAGE__->has_many(
  "tags_requests",
  "Konocle::DB::Schema::Result::TagsRequest",
  { "foreign.tags_requests_request_id" => "self.request_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_requests_loved

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersRequestLoved>

=cut

__PACKAGE__->has_many(
  "users_requests_loved",
  "Konocle::DB::Schema::Result::UsersRequestLoved",
  { "foreign.users_requests_loved_request_id" => "self.request_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users_requests_saved

Type: has_many

Related object: L<Konocle::DB::Schema::Result::UsersRequestSaved>

=cut

__PACKAGE__->has_many(
  "users_requests_saved",
  "Konocle::DB::Schema::Result::UsersRequestSaved",
  { "foreign.users_requests_saved_request_id" => "self.request_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tGclIKgUVQwSO2V1xirEIA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
