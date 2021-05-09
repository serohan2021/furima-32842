require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録/ユーザー情報' do
    context '正常テスト' do
      it '全ての項目に正しい値を入力すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'パスワードが6文字以上で登録できる' do
        @user.password = 'h1j2k3'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
      it 'パスワードが、半角英数字混合入力であれば登録できる' do
        @user.password = '0984593859398ttt'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
    end

    context '異常テスト' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性でなければ登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスに @ が含まれていなければ登録できない' do
        @user.email = 'hogehogehoge.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが5文字以下では登録できない' do
        @user.password = 'w1e2r'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードは、半角英字のみの入力では登録できない（半角英数字混合入力が必要）' do
        @user.password = 'asdfghjk'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードは、半角数字のみの入力では登録できない（半角英数字混合入力が必要）' do
        @user.password = '0984593859398'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードが存在してもパスワード(確認)が空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードとパスワード(確認)の値が一致していなければ登録できない' do
        @user.password = 'a123456'
        @user.password_confirmation = 'a1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end

  describe 'ユーザー新規登録/本人情報確認' do
    context '正常テスト' do
      it 'ユーザー本名（苗字）は、全角（漢字）での入力で登録できる' do
        @user.last_name = '漢字'
        expect(@user).to be_valid
      end
      it 'ユーザー本名（苗字）は、全角（ひらがな）入力で登録できる' do
        @user.last_name = 'ひらがな'
        expect(@user).to be_valid
      end
      it 'ユーザー本名（苗字）は、全角（カタカナ）入力で登録できる' do
        @user.last_name = 'カタカナ'
        expect(@user).to be_valid
      end
      it 'ユーザー本名（名前）は、全角（漢字）入力で登録できる' do
        @user.first_name = '太郎'
        expect(@user).to be_valid
      end
      it 'ユーザー本名（名前）は、全角（ひらがな）入力で登録できる' do
        @user.first_name = 'たろう'
        expect(@user).to be_valid
      end
      it 'ユーザー本名（名前）は、全角（カタカナ）入力で登録できる' do
        @user.first_name = 'タロウ'
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナ（苗字）は、全角（カタカナ）入力で登録できる' do
        @user.last_name_kana = 'ミョウジ'
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナ（名前）は、全角（カタカナ）入力で登録できる' do
        @user.first_name_kana = 'ファーストネーム'
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナ（苗字）は、全角カタカナ入力で登録できる' do
        @user.last_name_kana = 'フリガナミョウジ'
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナ（名前）は、全角カタカナ入力で登録できる' do
        @user.first_name_kana = 'フリガナナマエ'
        expect(@user).to be_valid
      end
    end

    context '異常テスト' do
      it 'ユーザー本名は、名字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", 'Last name is invalid')
      end
      it 'ユーザー本名は、名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", 'First name is invalid')
      end
      it 'ユーザー本名（苗字）は、半角入力では登録できない' do
        @user.last_name = 'Monky1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it 'ユーザー本名（名前）は、半角入力では登録できない' do
        @user.first_name = 'Luffy2'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it 'ユーザー本名のフリガナは、苗字が空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'ユーザー本名（名前）のフリガナは、名前が空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'ユーザー本名のフリガナ（苗字）は、全角（ひらがな）入力で登録できない' do
        @user.last_name_kana = 'みょうじ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it 'ユーザー本名のフリガナ（名前）は、全角（ひらがな）入力で登録できない' do
        @user.first_name_kana = 'なまえ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it 'ユーザー本名のフリガナ（苗字）は、半角英字入力で登録できない' do
        @user.last_name_kana = 'myouji'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it 'ユーザー本名のフリガナ（名前）は、半角英字入力で登録できない' do
        @user.first_name_kana = 'namae'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it 'ユーザー本名のフリガナ（苗字）は、半角数字入力で登録できない' do
        @user.last_name_kana = '93847'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it 'ユーザー本名のフリガナ（名前）は、半角数字入力で登録できない' do
        @user.first_name_kana = '09275655'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '生年月日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
