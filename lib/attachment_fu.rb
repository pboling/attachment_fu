module Technoweenie # :nodoc:
  module AttachmentFu # :nodoc:
    def self.rails_root=(rails_root)
      @@rails_root = rails_root
    end
 
    def self.rails_root
      @@rails_root
    end
 
    def self.tempfile_path=(tempfile_path)
      @@tempfile_path = tempfile_path
    end
 
    def self.tempfile_path
      @@tempfile_path
    end
  end
end
 
class Railtie < Rails::Railtie
  initializer "attachment_fu" do |app|
    if defined?(Rails)
      Technoweenie::AttachmentFu.rails_root = Rails.root
    else
      Technoweenie::AttachmentFu.rails_root = RAILS_ROOT
    end

    if Object.const_defined?(:ATTACHMENT_FU_TEMPFILE_PATH)
      Technoweenie::AttachmentFu.tempfile_path = ATTACHMENT_FU_TEMPFILE_PATH
    else
      Technoweenie::AttachmentFu.tempfile_path = File.join(Technoweenie::AttachmentFu.rails_root, 'tmp', 'attachment_fu')
    end

    FileUtils.mkdir_p Technoweenie::AttachmentFu.tempfile_path

    require 'tempfile'
    require 'active_record'

    require 'geometry'

    require 'technoweenie/attachment_fu'

    ActiveSupport::Dependencies.autoload_paths << File.dirname(__FILE__)
    ActiveRecord::Base.send(:extend, Technoweenie::AttachmentFu::ActMethods)
  end
end