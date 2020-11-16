require 'rails_helper'
describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, name: 'task')}
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
        click_on "終了期限でソートする"
        task_list = all('.task_name')
        expect(task_list[0]).to have_content 'title5'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task.id)
        expect(page).to have_content 'task'
      end
    end
  end
end
