class WikiPolicy < ApplicationPolicy
    def index?
        true
    end 

    def create?
        user.present?
    end

    def update?
        user.admin? || user.id == record.user.id
    end

    def edit?
        user.admin? || user.id == record.user.id
    end

    def destroy?
        false
    end

end