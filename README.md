# marker cookbook

[![Build Status](https://travis-ci.org/rightscale-cookbooks/marker.png?branch=master)](https://travis-ci.org/rightscale-cookbooks/marker)

Provides a way to create a visual marker in the Chef log based on a template.

It uses a definition because it runs in the context of the recipe where the
cookbook and recipe name are available.

# Requirements

Requires Chef 10 or higher.

# Usage

Add a dependency to your cookbook's `metadata.rb`:

```ruby
depends 'marker'
```

At the beginning of your recipe:

```ruby
marker "recipe_start"
```

Now, when your recipe is converging it will log:

```
********************************************************************************
*  Running recipe hello_world::default
```

## RightScale Audit Entry

This cookbook comes with a `rightscale_audit_entry.erb` template that can be
used to delineate recipes in the Audit Entires UI on the RightScale Dashboard:

```ruby
marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end
```

This will log in a format that will create an expandable entry for your recipe
in the RightScale Audit Entry for your Chef run:

```
********************************************************************************
*RS>  Running recipe hello_world::default   ****
```

## Custom Templates

You can also use the `marker` with your own custom templates and even add your own variables:

```ruby
marker "recipe_start_custom" do
  template "custom.erb"
  cookbook "hello_world"
  variables :host_name => node[:hostname]
end
```

The template that you include in your cookbook could look like:

```erb
********************************************************************************
*  Running recipe <%= @recipe_name %> on <%= @host_name %>
```

This will log in your custom format:

```
********************************************************************************
*  Running recipe hello_world::default on localhost
```

# Attributes

There are no attributes in this cookbook.

# Recipes

There are no recipes in this cookbook.

# Author

Author:: RightScale, Inc. (<cookbooks@rightscale.com>)
