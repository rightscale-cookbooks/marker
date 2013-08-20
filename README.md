# marker cookbook

Provides a way to create a visual marker in your Chef log by logging a template
to the Chef log.

It uses a definition here because it runs in the context of the recipe where the
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

You can use the `marker` to distinguish recipes in RightScale Audit Entires:

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

Maintained by the RightScale White Team
