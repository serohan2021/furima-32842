require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '正常系テスト' do
    it '必要な情報を適切に入力すると、商品の出品ができる' do
      expect(@item).to be_valid
    end

    it '商品の状態についての入力が ２〜7 であれば、商品の出品ができる' do
      @item.condition_id = 7
      expect(@item).to be_valid
    end

    it '商品のカテゴリーについての入力が ２〜11 であれば、商品の出品ができる' do
      @item.category_id = 11
      expect(@item).to be_valid
    end

    it '配送料の負担についての入力が ２〜３ であれば、商品の出品ができる' do
      @item.postage_type_id = 3
      expect(@item).to be_valid
    end

    it '発送元の地域についての入力が ２〜48 であれば、商品の出品ができる' do
      @item.region_id = 48
      expect(@item).to be_valid
    end

    it '発送までの日数の入力が ２〜4 であれば、商品の出品ができる' do
      @item.shipping_day_id = 4
      expect(@item).to be_valid
    end

    it '価格の範囲が、¥300 ~ ¥9,999,999 であれば、商品の出品ができる' do
      @item.price = 300
      expect(@item).to be_valid
    end
  end

  describe '異常系テスト' do
    it 'userが存在しないと登録できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('User must exist')
    end

    it '商品画像を1枚つけなければ、商品の出品ができない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名が空欄であれば、商品の出品ができない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '商品名が40字より多ければ、商品の出品ができない' do
      @item.name = '商品名001' * 7
      @item.valid?
      expect(@item.errors.full_messages).to include('Name is too long (maximum is 40 characters)')
    end

    it '商品の説明が空欄であれば、商品の出品ができない' do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end

    it '商品の説明が1000字より多ければ、商品の出品ができない' do
      @item.description = 'これはテストです９。' * 101
      @item.valid?
      expect(@item.errors.full_messages).to include('Description is too long (maximum is 1000 characters)')
    end

    it '商品のカテゴリーが空欄であれば、商品の出品ができない' do
      @item.category_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end

    it '商品のカテゴリーが１では商品の出品ができない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 1')
    end

    it '商品の状態が空欄であれば、商品の出品ができない' do
      @item.condition_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Condition can't be blank")
    end

    it '商品の状態が１では商品の出品ができない' do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Condition must be other than 1')
    end

    it '配送料の負担が空欄であれば、商品の出品ができない' do
      @item.postage_type_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Postage type can't be blank")
    end

    it '配送料の負担が１では商品の出品ができない' do
      @item.postage_type_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Postage type must be other than 1')
    end

    it '発送元の地域が空欄であれば、商品の出品ができない' do
      @item.region_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Region can't be blank")
    end

    it '発送元の地域が１では商品の出品ができない' do
      @item.region_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Region must be other than 1')
    end

    it '発送までの日数が空欄であれば、商品の出品ができない' do
      @item.shipping_day_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping day can't be blank")
    end

    it '発送までの日数が１では商品の出品ができない' do
      @item.shipping_day_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('Shipping day must be other than 1')
    end

    it '価格が空欄であれば、商品の出品ができない' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格が、¥300より小さい額では商品の出品ができない' do
      @item.price = 200
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end

    it '価格が、¥9,999,999より大きい額では商品の出品ができない' do
      @item.price = 39_999_999
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
    end

    it '販売価格は半角英字のみの入力では、商品の出品ができない' do
      @item.price = 'asdfghjk'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end

    it '販売価格は半角英数字混合では、商品の出品ができない' do
      @item.price = '123asdfghjk'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end

    it '販売価格は全角数字では、商品の出品ができない' do
      @item.price = '３０００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end

    it '販売価格は全角英数字では、商品の出品ができない' do
      @item.price = 'ａａａ３０００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end

    it '販売価格は全角漢数字では、商品の出品ができない' do
      @item.price = '五六〇〇'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end
  end
end
