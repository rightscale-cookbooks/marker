#
# Cookbook Name:: marker
#
# Copyright (C) 2013 RightScale, Inc.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Create a visual marker in your Chef log.
#
# We use a definition here because it runs in the context of the recipe which
# allows us to grab the cookbook and recipe name.
#
# @param template [String] The name of the template to use for the marker.
# @param cookbook [String] The cookbook that contains the marker template (if not in this one)
# @param variable [Hash] A hash of variables that are passed into the template file.
#
define :marker, :template => "default.erb", :cookbook => "marker", :variables => nil do

  ruby_block "log marker #{params[:name]}" do
    block do

      # add recipes to values hash
      recipe_name = "#{self.cookbook_name}::#{self.recipe_name}"
      values = { :recipe_name => recipe_name }
      values.merge(params[:variables]) if params[:variables]

      # create log marker from template
      log_marker = Chef::Log::Marker.new(run_context)
      log_marker.create(params[:template], values, params[:cookbook])
    end
  end

end
