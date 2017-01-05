name             'marker'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Provides a way to create a visual marker in the Chef log based on a template.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.0'
issues_url       'https://github.com/rightscale-cookbooks/marker/issues'
source_url       'https://github.com/rightscale-cookbooks/marker'
chef_version '>= 12.0' if respond_to?(:chef_version)
