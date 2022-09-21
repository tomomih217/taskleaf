require 'rails_helper'

describe 'タスク管理機能', type: :system do
    describe '一覧表示機能' do
        before do
            user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') 
            #create:データベースに保存　build:保存しない
            FactoryBot.create(:task, name: '最初のタスク', user: user_a)
        end

        context 'ユーザーAがログインしている時' do
            before do
                visit login_path
                fill_in 'メールアドレス', with: 'a@example.com'
                fill_in 'パスワード', with: 'password'
                click_button 'ログインする'
            end

            it 'ユーザーAが作成したタスク一覧が表示される' do
                expect(page).to have_content '最初のタスク'
            end
        end
    end 
end