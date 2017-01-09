require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest
    
   def setup
   @user = User.create(username: "test", email: "test@example.com", password: "password")
   end
   
    test "create articles" do
        sign_in_as(@user, "password")
        get new_article_path
        assert_template 'articles/new'
        assert_difference "Article.count", 1 do
           post_via_redirect articles_path, article: { title: "title", description: "description" }
        end
        assert_template 'articles/show'
        assert_match "title", response.body
        
    end
end