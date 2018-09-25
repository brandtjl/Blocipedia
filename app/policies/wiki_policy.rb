class WikiPolicy < ApplicationPolicy
    def index?
        true
    end 

    def create?
        user.present?
    end

    def update?
        user.admin? || user == record
    end

    def edit?
        user.admin? || user == record
    end

    def destroy?
        false
    end

end