use utf8;
package Konocle::DB::Schema::Result::UsersUrlLoved;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Konocle::DB::Schema::Result::UsersUrlLoved

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

=head1 TABLE: C<users_urls_loved>

=cut

__PACKAGE__->table("users_urls_loved");

=head1 ACCESSORS

=head2 users_urls_loved_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_urls_loved_users_urls_loved_id_seq'

=head2 users_urls_loved_user_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 users_urls_loved_url_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 users_urls_loved_ip_addr

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 users_urls_loved_date

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "users_urls_loved_id",
  {
    data_type         => "bigint",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_urls_loved_users_urls_loved_id_seq",
  },
  "users_urls_loved_user_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "users_urls_loved_url_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "users_urls_loved_ip_addr",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "users_urls_loved_date",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</users_urls_loved_id>

=back

=cut

__PACKAGE__->set_primary_key("users_urls_loved_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<users_urls_loved unique>

=over 4

=item * L</users_urls_loved_url_id>

=item * L</users_urls_loved_ip_addr>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "users_urls_loved unique",
  ["users_urls_loved_url_id", "users_urls_loved_ip_addr"],
);

=head1 RELATIONS

=head2 users_urls_loved_url

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::Url>

=cut

__PACKAGE__->belongs_to(
  "users_urls_loved_url",
  "Konocle::DB::Schema::Result::Url",
  { url_id => "users_urls_loved_url_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 users_urls_loved_user

Type: belongs_to

Related object: L<Konocle::DB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "users_urls_loved_user",
  "Konocle::DB::Schema::Result::User",
  { user_id => "users_urls_loved_user_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07038 @ 2014-01-08 17:21:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Ak4z/nsxY6EbJVlWaN7aMQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
