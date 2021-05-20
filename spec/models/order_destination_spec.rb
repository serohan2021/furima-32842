require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  before do
    @order_destination = FactoryBot.build(:order_destination)
  end

  describe '正常系テスト' do
    it 'すべての値が正しく入力されていれば保存できる' do
      expect(@order_destination).to be_valid
    end

    it '建物名が空でも保存できる' do
      @order_destination.building_name = ''
      expect(@order_destination).to be_valid
    end
  end

  describe '異常系テスト' do
    it 'user_id が存在しないと登録できない' do
      @order_destination.user_id = nil
      @order_destination.valid?
      expect(@order_destination.errors.full_messages).to include("User can't be blank")
    end

    it 'item_id が存在しないと登録できない' do
      @order_destination.item_id = nil
      @order_destination.valid?
      expect(@order_destination.errors.full_messages).to include("Item can't be blank")
    end

    it 'token が空では保存できないこと' do
      @order_destination.token = nil
      @order_destination.valid?
      expect(@order_destination.errors.full_messages).to include("Token can't be blank")
    end

    context '郵便番号が半角のハイフンを含んだ正しい形式でないと保存できない（123-4567）' do
      it '郵便番号が空だと保存できない' do
        @order_destination.post_code = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Post code can't be blank")
      end

      it '郵便番号にハイフンがなければ保存できない' do
        @order_destination.post_code = '12345678'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Post code is invalid')
      end

      it '郵便番号は全角文字では保存できない' do
        @order_destination.post_code = '１２３-４５６７'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Post code is invalid')
      end

      it '郵便番号は半角英字が含まれていれば保存できない' do
        @order_destination.post_code = '12b-ab67'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Post code is invalid')
      end

      it '郵便番号の半角ハイフンの位置が正しくないと保存できない' do
        @order_destination.post_code = '12345-67'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Post code is invalid')
      end

      it '郵便番号の文字数が規定より少ないと保存できない' do
        @order_destination.post_code = '123-4'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Post code is invalid')
      end

      it '郵便番号の文字数が規定より多いと保存できない' do
        @order_destination.post_code = '123-45678'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Post code is invalid')
      end
    end

    it '都道府県が空だと保存できない' do
      @order_destination.region_id = nil
      @order_destination.valid?
      expect(@order_destination.errors.full_messages).to include("Region can't be blank")
    end

    it '都道府県は選択していないと保存できない' do
      @order_destination.region_id = 1
      @order_destination.valid?
      expect(@order_destination.errors.full_messages).to include('Region must be other than 1')
    end

    it '市区町村が空だと保存できない' do
      @order_destination.city = ''
      @order_destination.valid?
      expect(@order_destination.errors.full_messages).to include("City can't be blank")
    end

    it '番地が空だと保存できない' do
      @order_destination.address = ''
      @order_destination.valid?
      expect(@order_destination.errors.full_messages).to include("Address can't be blank")
    end

    context '電話番号が9桁〜11桁の半角数字のみの入力でないと保存できない(09012345678)' do
      it '電話番号が空だと保存できない' do
        @order_destination.phone_number = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が全角数字では保存できない' do
        @order_destination.phone_number = '１２３４５６７８９１'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号に半角英字が含まれていると保存できない' do
        @order_destination.phone_number = '12345ghj9x'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号が11桁以内でないと保存できない' do
        @order_destination.phone_number = 123_456_789_012
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone number is invalid')
      end

      it '電話番号が9桁以上でないと保存できない' do
        @order_destination.phone_number = 12_345_678
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end
