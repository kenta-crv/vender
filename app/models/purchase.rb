class Purchase < ApplicationRecord
  has_many :reports, dependent: :destroy
    VENDER_PRICES = {
      "26セレクション（395,000円）" => 395000,
      "25セレクション（395,000円）" => 395000,
      "12セレクション（448,000円）" => 448000,
      "36セレクション（420,000円）" => 420000,
      "20セレクション（435,000円）" => 435000,
      "16セレクション（435,000円）" => 435000,
      "お菓子自販機（機種により要見積）" => 0,
      "ど冷えもん自販機（機種により要見積）" => 0,
      "相談して決めたい" => 0
    }.freeze
  
    OPTION_PRICES = {
      thousand: 28000,
      five_hundred: 25000,
      five_ensure: 30000,
      simple_wrapping: 30000,
      design_wrapping: 65000
    }.freeze


  ESTIMATE_REQUIRED_VENDERS = ["お菓子自販機", "ど冷えもん自販機", "相談して決めたい"].freeze

  def total_price
    return '要見積り' if estimate_required?
  
    total = VENDER_PRICES[vender] || 0
    OPTION_PRICES.each do |option, price|
      # 文字列の"1"をtrueに変換して比較
      total += price if self[option].to_s == "1"
    end
    total
  end

  def total_price_with_tax
    return '要見積り' if estimate_required?

    (total_price * 1.1).round
  end

  def installment_prices
    total = total_price
    return '要見積り' if total == '要見積り'

    total_with_fee = (total * 1.22).round
    monthly_payment = (total_with_fee / 24.0).round
    first_payment = total_with_fee - (monthly_payment * 23)

    { first: first_payment, monthly: monthly_payment }
  end

  def installment_prices_with_tax
    total_with_tax = total_price_with_tax
    return '要見積り' if total_with_tax == '要見積り'

    total_with_fee = (total_with_tax * 1.22).round
    monthly_payment = (total_with_fee / 24.0).round
    first_payment = total_with_fee - (monthly_payment * 23)

    { first: first_payment, monthly: monthly_payment }
  end

  private

  def estimate_required?
    ESTIMATE_REQUIRED_VENDERS.include?(vender)
  end
end
