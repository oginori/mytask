require 'rails_helper'
describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, name: 'task', status: '完了')}
  let!(:second_task) { FactoryBot.create(:second_task)}
  let!(:third_task) { FactoryBot.create(:third_task)}
  let!(:fourth_task) { FactoryBot.create(:fourth_task)}
  let!(:fifth_task) { FactoryBot.create(:fifth_task)}
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_name', with: task.name
        fill_in 'task_description', with: task.description
        fill_in 'task_expired_at', with: task.expired_at
        click_on 'commit'
        expect(page).to have_content 'task'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_name')
        expect(task_list[0]).to have_content 'title5'
      end
    end

    context '「終了期限でソートする」というボタンを押した場合' do
      it '終了期限の降順に並び替えられる' do
        visit tasks_path
        find('.sort_expired_button').click
        task_list = all('.task_name')
        expect(task_list[0]).to have_content 'title5'
      end
    end

    # context '「優先順位でソートする」というボタンを押した場合' do
    #   it '優先順位の高い順に並び替えられる' do
    #     visit tasks_path
    #     find('.sort_priority_button').click
    #     task_list = all('.task_name')
    #     expect(task_list[0]).to have_content 'title5'
    #   end
    # end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task.id)
        expect(page).to have_content 'task'
      end
    end
  end

  describe '検索機能' do
    context 'タイトルで曖昧検索をした場合' do
      it '検索ワードを含むタスクで絞り込める' do
        visit tasks_path
        fill_in 'task_name', with: task.name
        select '', from: 'ステータス'
        click_on 'search'
        expect(page).to have_content 'task'
      end
    end
    context ' ステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        visit tasks_path
        select '完了', from: 'ステータス'
        click_on 'search'
        expect(page).to have_content '完了'
      end
    end

    context 'タイトルの曖昧検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる' do
        visit tasks_path
        fill_in 'task_name', with: task.name
        select '完了', from: 'ステータス'
        click_on 'search'
        expect(page).to have_content 'task'
        expect(page).to have_content '完了'
      end
    end
  end

end
