# perc_fact

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Custom fact for reporting info about Dell RAID arrays via OpenManage.

Sample output from running `facter` on a real system:

```
perc => {
  /dev/sda => {
    id => "0",
    status => "Ok",
    name => "Virtual Disk 0",
    state => "Ready",
    hot_spare_policy_violated => "Not Assigned",
    encrypted => "No",
    layout => "RAID-1",
    size => "465.25 GB (499558383616 bytes)",
    t10_protection_information_status => "No",
    associated_fluid_cache_state_ => "Not Applicable",
    device_name => "/dev/sda",
    bus_protocol => "SATA",
    media => "HDD",
    read_policy => "Adaptive Read Ahead",
    write_policy => "Write Back",
    cache_policy => "Not Applicable",
    stripe_element_size => "64 KB",
    disk_cache_policy => "Enabled"
  },
  /dev/sdb => {
    id => "1",
    status => "Ok",
    name => "Virtual Disk 1",
    state => "Ready",
    hot_spare_policy_violated => "Not Assigned",
    encrypted => "No",
    layout => "RAID-10",
    size => "1,116.75 GB (1199101181952 bytes)",
    t10_protection_information_status => "No",
    associated_fluid_cache_state_ => "Not Applicable",
    device_name => "/dev/sdb",
    bus_protocol => "SAS",
    media => "HDD",
    read_policy => "Adaptive Read Ahead",
    write_policy => "Write Back",
    cache_policy => "Not Applicable",
    stripe_element_size => "64 KB",
    disk_cache_policy => "Disabled"
  }
}
```

## Usage

Just add this module to your Puppet installation and start using the fact.

## Limitations

Requires Dell hardware with a PERC RAID controller and a working installation
of `omreport`. Structured fact requires Facter 2.0 or greater.

## Development

I wrote this module to scratch an itch. It is my plan to add the custom fact
to one of the existing modules that installs Dell OpenManage and tear this
temporary module down.
