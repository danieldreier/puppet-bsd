# Define: bsd::network::interface::wifi
#
# Handles the creation and configuration of wifi interfaces.
#
define bsd::network::interface::wifi (
  $network_name,
  $ensure      = 'present',
  $network_key = undef,
  $address     = undef,
  $description = undef,
  $options     = undef,
) {

  $if_name = $name

  validate_re(
    $ensure,
    '(up|down|present|absent)',
    '$ensure can only be one of up, down, present, or absent'
  )

  $config = {
    network_name => $network_name,
    network_key  => $network_key,
    address      => $address,
  }

  $wifi_ifconfig = get_hostname_if_wifi($config)

  bsd::network::interface { $if_name:
    description => $description,
    values      => [$wifi_ifconfig],
    options     => $options,
  }
}
