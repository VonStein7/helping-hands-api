class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :events, :organizations, :donations

  def organizations 
    self.object.organizations.map do |organization|
      {
        id: organization.id,
        name: organization.name
      }
    end
  end
end
