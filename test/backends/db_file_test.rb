require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

class DbFileTest < ActiveSupport::TestCase
  include BaseAttachmentTests
  attachment_model AttachmentTest

  def test_should_call_after_attachment_saved(klass = AttachmentTest)
    attachment_model.saves = 0
    assert_created do
      upload_file :filename => '/files/rails.png'
    end
    assert_equal 1, attachment_model.saves
  end
  
  test_against_subclass :test_should_call_after_attachment_saved, AttachmentTest
end