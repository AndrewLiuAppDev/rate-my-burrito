class BurritoPolicy
  attr_reader :user, :burrito

  def initialize(user, burrito)
    @user = user
    @burrito = burrito
  end

  def update?
    user == burrito.owner
  end

  def destroy?
    user == burrito.owner
  end
end