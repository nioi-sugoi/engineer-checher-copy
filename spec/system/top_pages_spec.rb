require 'rails_helper'

RSpec.describe "TopPages", :type => :system do
 context 'トップページにアクセスした場合' do
   it '正しく表示される' do
     visit root_path
     expect(page).to have_field 'screen_name', :placeholder => 'あの人のTwitter ID' 
   end
 end
end
