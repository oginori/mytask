require 'rails_helper'
describe 'ラベル機能', type: :system do
  user = FactoryBot.create(:user)
  let!(:task) { Task.first }
  task1 = FactoryBot.create(:task, name: "first", description: "first", expired_at: "2020/01/01", status: "未着手", priority: 1, user_id: user.id)
  task2 = FactoryBot.create(:task, name: "second", description: "second", expired_at: "2020/01/01", status: "未着手", priority: 1, user_id: user.id)
  task3 = FactoryBot.create(:task, name: "third", description: "third", expired_at: "2020/01/01", status: "未着手", priority: 1, user_id: user.id)

  first_label = FactoryBot.create(:label, name: "first_label")
  second_label = FactoryBot.create(:label, name: "second_label")

  FactoryBot.create(:labelling, task_id: task1.id, label_id: first_label.id)
  FactoryBot.create(:labelling, task_id: task1.id, label_id: second_label.id)
  FactoryBot.create(:labelling, task_id: task2.id, label_id: first_label.id)
  FactoryBot.create(:labelling, task_id: task3.id, label_id: second_label.id)

  # let!(:second_task) { FactoryBot.create(:second_task) }
  # let!(:second_labelling) { FactoryBot.create(:second_label) }
  # let!(:third_labelling) { FactoryBot.create(:third_label) }

  before do
    visit new_session_path
    fill_in 'session_email', with: 'test@example.com'
    fill_in 'session_password', with: 'password'
    click_on 'commit'
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '複数のラベルを一緒に登録できる' do
        visit new_task_path
        fill_in 'task_name', with: 'sample'
        fill_in 'task_description', with: 'go to somewhere'
        fill_in 'task_expired_at', with: '002020-12-31'
        select '高', from: 'task_priority'
        select '未着手', from: 'task_status'
        all('input[type=checkbox]').each do |checkbox|
          checkbox.click
        end
        click_on 'commit'
        expect(page).to have_content 'first_label'
        expect(page).to have_content 'second_label'
      end
    end
  end

  describe '一覧機能' do
    context 'タスクの一覧画面に遷移した場合' do
      it 'そのタスクに紐づいているラベル一覧が出力される' do
        visit tasks_path
        expect(page).to have_content 'first_label'
      end
    end
  end

  describe '検索機能' do
    context 'ラベルで曖昧検索をした場合' do
      it '検索したラベルを含むタスクで絞り込める' do
        visit tasks_path
        select 'first_label', from: 'task_label_id'
        click_on 'search'
        expect(page).to have_content 'first_label'
        expect(page).not_to have_content 'third'
      end
    end
  end

end
