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

    class Scope
        attr_reader :user, :scope
    
        def initialize(user, scope)
          @user = user
          @scope = scope
        end
    
        def resolve
          wikis = []
        puts @user.id
          if user && user.role == 'admin'
            wikis = scope.all # if the user is an admin, show them all the wikis
            p "admin user"
          elsif user && user.account == 'premium'
            all_wikis = scope.all
            all_wikis.each do |wiki|
              #puts "#{!wiki.private}, #{wiki.user_id == @user_id}, #{wiki.collaborators.include?(user)}" 
              if !wiki.private || wiki.user_id == user.id || wiki.collaborators.exists?(user_id: user.id) #wiki.user_id == @user_id #|| 
                wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
              end
            end
            p "premium user"
          else # this is the lowly standard user
            all_wikis = scope.all
            wikis = []
            all_wikis.each do |wiki|
              #puts "#{wiki.collaborators.include?(user)}, #{!wiki.private?}"
              if !wiki.private || wiki.collaborators.exists?(user_id: user.id) #|| !wiki.private?
                wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
              end
            end
            
            p "regular user"
          end
          wikis # return the wikis array we've built up
        end
      end
end