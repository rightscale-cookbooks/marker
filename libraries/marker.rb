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

require 'chef/mixin/template'
require 'erb'
require 'ostruct'

class Chef
  class Log
    class Marker
      include Chef::Mixin::Template

      def initialize(run_context)
        @run_context = run_context
        @node = @run_context.node
      end

      def create(template, variables, cookbook)
        # Find template from cookbook collection
        cookbook = @run_context.cookbook_collection[cookbook]
        template = cookbook.preferred_filename_on_disk_location(
          @node,
          :templates,
          template
        )
        # render template
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

        # create log entry for each line in evaluated template
        marker_contents.split("\n").each do |line|
          Chef::Log.info(line)
        end
      end
    end
  end
end
