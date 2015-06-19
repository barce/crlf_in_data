require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:three)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: { body: @post.body, title: @post.title }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should strip CR from CRLF on create" do
    assert_difference('Post.count') do
      post :create, post: { body: @post.body, title: @post.title }
    end

    assert_redirected_to post_path(assigns(:post))
    get :show, id: @post
    assert_response :success
    assert_equal "My Paragraph\nMy next paragraph\nMy last paragraph", Post.last.body
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post
    assert_response :success
  end

  test "should update post" do
    patch :update, id: @post, post: { body: @post.body, title: @post.title }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should update post and turn CRLF into LF" do
    patch :update, id: @post, post: { body: "My Paragraph\r\nMy next paragraph\r\nMy last paragraph", title: "updated stuff" }
    assert_redirected_to post_path(assigns(:post))
    assert_equal "updated stuff", Post.find_by_title('updated stuff').title
    assert_equal "My Paragraph\nMy next paragraph\nMy last paragraph", Post.find_by_title('updated stuff').body
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end
end
