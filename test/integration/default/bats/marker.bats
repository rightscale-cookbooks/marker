#!/usr/bin/env bats

@test "default marker is printed to the log" {
  grep -B 2 recipe_start_default /var/log/chef-solo.log | grep -P '\*{80}$'
  grep -B 2 recipe_start_default /var/log/chef-solo.log | \
    grep '\*  Running recipe marker-test::default$'
}

@test "rightscale marker is printed to the log" {
  grep -B 2 recipe_start_rightscale /var/log/chef-solo.log | grep -P '\*{80}$'
  grep -B 2 recipe_start_rightscale /var/log/chef-solo.log | \
    grep -P '\*RS>  Running recipe marker-test::default   \*{4}$'
}

@test "custom marker is printed to the log" {
  grep -B 2 recipe_start_custom /var/log/chef-solo.log | grep -P '\*{80}$'
  grep -B 2 recipe_start_custom /var/log/chef-solo.log | \
    grep "\*  Running recipe marker-test::default on `hostname -s`\$"
}
