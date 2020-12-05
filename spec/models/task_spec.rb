require 'rails_helper'

describe 'タスクモデル機能', type: :model do
  let!(:user) { FactoryBot.create(:user) }

  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', description: '失敗テスト', user_id: user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(name: '失敗テスト', description: '',user_id: user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(name: '成功', description: 'テスト', user_id: user.id)
        expect(task).to be_valid
      end
    end
  end

  describe 'タスクモデル機能', type: :model do
    describe '検索機能' do
      let!(:task) { FactoryBot.create(:task, name: 'task', status: '完了', user_id: user.id) }
      let!(:second_task) { FactoryBot.create(:second_task, name: 'sample', user_id: user.id) }

      context 'scopeメソッドでタイトルの曖昧検索をした場合' do
        it '検索キーワードを含むタスクが絞り込まれる' do
          expect(Task.search_by_name('task')).to include(task)
          expect(Task.search_by_name('task')).not_to include(second_task)
          expect(Task.search_by_name('task').count).to eq 1
        end
      end

      context 'scopeメソッドでステータス検索をした場合' do
        it 'ステータスに完全一致するタスクが絞り込まれる' do
          expect(Task.search_by_status('完了')).to include(task)
        end
      end

      context 'scopeメソットでタイトルの曖昧検索とステータス検索をした場合' do
        it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる' do
          expect(Task.search_by_name('task').search_by_status('完了')).to include(task)
          expect(Task.search_by_name('task').search_by_status('完了').count).to eq 1
        end
      end
    end
  end
end
