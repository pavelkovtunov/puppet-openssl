# @summary Generates an openssl.conf file using defaults
#
# @param ensure
#   ensure parameter for configfile; defaults to present
# @param commonname
#   commonname for config file
# @param country
#   value for country
# @param organization
#   value for organization
# @param owner
#   owner for the configuration file
# @param group
#   group for the configuration file
# @param mode
#   mode for the configuration file
# @param state
#   value for state
# @param locality
#   value for locality
# @param unit
#   value for unit
# @param email
#   value for email
# @param default_bits
#   key size to generate
# @param default_md
#   message digest to use
# @param default_keyfile
#   name for the keyfile
# @param basicconstraints
#   version 3 certificate extension basic constraints
# @param extendedkeyusages
#   version 3 certificate extension extended key usage
# @param keyusages
#   version 3 certificate extension key usage
# @param subjectaltnames
#   version 3 certificate extension for alternative names
#   currently supported are IP (v4) and DNS
#
# @example basic usage
#   openssl::config {'/path/to/openssl.conf':
#     ensure       => 'present',
#     commonname   => 'somewhere.org',
#     country      => 'mycountry',
#     organization => 'myorg',
#   }
#
define openssl::config (
  Variant[String, Array[String]] $commonname,
  String                         $country,
  String                         $organization,
  Enum['absent','present']       $ensure            = 'present',
  String                         $owner             = 'root',
  String                         $group             = 'root',
  String                         $mode              = '0640',
  Optional[String]               $state             = undef,
  Optional[String]               $locality          = undef,
  Optional[String]               $unit              = undef,
  Optional[String]               $email             = undef,
  Integer                        $default_bits      = 4096,
  String                         $default_md        = 'sha512',
  String                         $default_keyfile   = 'privkey.pem',
  Optional[Array]                $basicconstraints  = undef,
  Optional[Array]                $extendedkeyusages = undef,
  Optional[Array]                $keyusages         = undef,
  Optional[Array]                $subjectaltnames   = undef,
) {
  file { $name:
    ensure  => $ensure,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => epp('openssl/cert.cnf.epp',
      {
        commonname        => $commonname,
        country           => $country,
        state             => $state,
        locality          => $locality,
        organization      => $organization,
        unit              => $unit,
        email             => $email,
        default_bits      => $default_bits,
        default_md        => $default_md,
        default_keyfile   => $default_keyfile,
        basicconstraints  => $basicconstraints,
        extendedkeyusages => $extendedkeyusages,
        keyusages         => $keyusages,
        subjectaltnames   => $subjectaltnames,
      },
    ),
    tag     => 'openssl-configs',
  }
}
