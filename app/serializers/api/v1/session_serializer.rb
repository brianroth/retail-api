class Api::V1::SessionSerializer < Api::V1::BaseSerializer
  attributes :email, :name, :token

  def token
    Knock::AuthToken.new(payload: { sub: object.id }).token
  end
end
