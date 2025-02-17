require_relative 'app_controller_test_base'

class IdReviewControllerTest < AppControllerTestBase

  def self.hex_prefix
    '5EF'
  end

  #- - - - - - - - - - - - - - - -

  test '408',
  'id_review from existing group' do
    id_review('FxWwrr')
    assert exists?
    assert_equal id, 'FxWwrr'
  end

  #- - - - - - - - - - - - - - - -

  test '409',
  'id_review from new group' do
    in_group do |group|
      id_review(group.id)
      assert exists?
      assert_equal id, group.id
    end
  end

  #- - - - - - - - - - - - - - - -

  test '40A',
  'id_review from group that does not exist' do
    id_review('112233')
    refute exists?
  end

  #- - - - - - - - - - - - - - - -

  private

  def id_review(id)
    params = { id:id }
    get '/id_review/drop_down', params:params, as: :json
    assert_response :success
  end

  def exists?
    json['exists']
  end

  def id
    json['id']
  end

end
