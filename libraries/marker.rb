#
# Cookbook Name:: marker
# Library:: marker
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

require 'chef/mixin/template'
require 'erb'

class Chef
  class Log
    class Marker
      include Chef::Mixin::Template

      # Constructs a log marker for a Chef run context.
      #
      # @param run_context [Chef::RunContext] the Chef run context
      #
      def initialize(run_context)
        @run_context = run_context
        @node = @run_context.node
      end

      # Creates a log entry from a given template.
      #
      # @param template [String] the template to use for the marker
      # @param cookbook [String] the cookbook that contains the marker template
      # @param variables [Hash<Symbol, String>] the extra variables to pass into the template
      #
      def create(template, cookbook, variables)
        # Find template from cookbook collection
        cookbook = @run_context.cookbook_collection[cookbook]
        template = cookbook.preferred_filename_on_disk_location(
          @node,
          :templates,
          template
        )
        # Render template
        context = {}
        context.merge!(variables)
        context[:node] = @node
        marker_contents = nil
        begin
          eruby = Erubis::Eruby.new(::File.read(template))
          marker_contents = eruby.evaluate(context)
        rescue Object => e
          raise TemplateError.new(e, template, context)
        end

        # Create log entry for each line in evaluated template
        marker_contents.split("\n").each do |line|
          Chef::Log.info(line)
        end
      end
    end
  end
end
