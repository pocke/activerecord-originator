# frozen_string_literal: true

RSpec.describe ActiveRecord::Originator do
  describe '#to_sql' do
    context 'with a WHERE clause' do
      it 'annotates single = operator' do
        expect(Post.hello.to_sql).to eq(<<~SQL)
          SELECT "posts".* FROM "posts" WHERE "posts"."title" = 'hello' /* /spec/support/post.rb:4 */
        SQL
      end

      it 'annotates multiple = operator' do
        expect(Post.hello.draft.to_sql).to eq(<<~SQL)
          SELECT "posts".* FROM "posts" WHERE "posts"."title" = 'hello' /* /spec/support/post.rb:4 */
           AND "posts"."state" = 'draft' /* /spec/support/post.rb:5 */
        SQL
      end

      it 'annotates != operator' do
        expect(Post.not_eq('hello').to_sql).to eq(<<~SQL)
          SELECT "posts".* FROM "posts" WHERE "posts"."title" != 'hello' /* /spec/support/post.rb:9 */
        SQL
      end

      it 'annotates IN operator' do
        expect(Post.state_for(['draft', 'published']).to_sql).to eq(<<~SQL)
          SELECT "posts".* FROM "posts" WHERE "posts"."state" IN ('draft', 'published') /* /spec/support/post.rb:6 */
        SQL
      end

      it 'annotates NOT IN operator' do
        expect(Post.not_state_for(['draft', 'published']).to_sql).to eq(<<~SQL)
          SELECT "posts".* FROM "posts" WHERE "posts"."state" NOT IN ('draft', 'published') /* /spec/support/post.rb:7 */
        SQL
      end

      it 'annotates >= operator' do
        expect(Post.compare_id(42..).to_sql).to eq(<<~SQL)
          SELECT "posts".* FROM "posts" WHERE "posts"."id" >= 42 /* /spec/support/post.rb:8 */
        SQL
      end

      it 'annotates >= operator' do
        expect(Post.compare_id(..42).to_sql).to eq(<<~SQL)
          SELECT "posts".* FROM "posts" WHERE "posts"."id" <= 42 /* /spec/support/post.rb:8 */
        SQL
      end

      it 'annotates < operator' do
        expect(Post.compare_id(...42).to_sql).to eq(<<~SQL)
          SELECT "posts".* FROM "posts" WHERE "posts"."id" < 42 /* /spec/support/post.rb:8 */
        SQL
      end

      it 'annotates IS NULL operator' do
        expect(Post.state_for(nil).to_sql).to eq(<<~SQL)
          SELECT "posts".* FROM "posts" WHERE "posts"."state" IS NULL /* /spec/support/post.rb:6 */
        SQL
      end

      it 'annotates IS NOT NULL operator' do
        expect(Post.not_eq(nil).to_sql).to eq(<<~SQL)
          SELECT "posts".* FROM "posts" WHERE "posts"."title" IS NOT NULL /* /spec/support/post.rb:9 */
        SQL
      end
    end

    it 'annotates a ORDER BY asc clause' do
      expect(Post.order_by_title(:asc).to_sql).to eq(<<~SQL)
        SELECT "posts".* FROM "posts" ORDER BY "posts"."title" ASC /* /spec/support/post.rb:10 */
      SQL
    end

    it 'annotates a ORDER BY desc clause' do
      expect(Post.order_by_title(:desc).to_sql).to eq(<<~SQL)
        SELECT "posts".* FROM "posts" ORDER BY "posts"."title" DESC /* /spec/support/post.rb:10 */
      SQL
    end

    context 'with one_liner format' do
      before do
        ActiveRecord::Originator.format = :one_liner
      end

      it 'outputs in one line' do
        expect(Post.hello.draft.to_sql).to eq(<<~SQL.chomp)
          SELECT "posts".* FROM "posts" WHERE "posts"."title" = 'hello' /* <- /spec/support/post.rb:4 */ AND "posts"."state" = 'draft' /* <- /spec/support/post.rb:5 */
        SQL
      end
    end
  end
end
