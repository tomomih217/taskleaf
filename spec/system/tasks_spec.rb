require 'rails_helper'

describe 'タスク管理機能', type: :system do
    let(:user_a){ FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
    let(:user_b){ FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
    #create:データベースに保存　build:保存しない
    let!(:task_a){ FactoryBot.create(:task, name: '最初のタスク', user: user_a) }

    before do
        visit login_path
        fill_in 'メールアドレス', with: login_user.email
        fill_in 'パスワード', with: login_user.password
        click_button 'ログインする'
    end

    shared_examples_for 'ユーザーAが作成したタスクが表示される' do
        it { expect(page).to have_content '最初のタスク' }
    end

    describe '一覧表示機能' do 
        context 'ユーザーAがログインしている時' do
            let(:login_user){ user_a }

            it_behaves_like 'ユーザーAが作成したタスクが表示される'
        end

        context 'ユーザーBがログインしている時' do
            let(:login_user){ user_b }

            it 'ユーザーAが作ったタスクが表示されない' do
                #画面上にユーザーAが作ったタスクが表示されない
                expect(page).to have_no_content '最初のタスク'
            end
        end
    end
    
    describe '詳細表示機能' do
        context 'ユーザーAがログインしている時' do
            let(:login_user){ user_a }
            before do
                #詳細画面に移動
                visit task_path(task_a)
            end

            it_behaves_like 'ユーザーAが作成したタスクが表示される'
        end

    end
end