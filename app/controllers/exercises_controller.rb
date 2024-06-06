class ExercisesController < ApplicationController
  def exercise1
    # 【要件】注文されていないすべての料理を返すこと
    #   * left_outer_joinsを使うこと
    # 注文されていないすべての料理＝order_foodsテーブルに存在していないfood_idをもったレコード
    @foods = Food.left_outer_joins(:order_foods).where.missing(:order_foods)
  end

  def exercise2
    # 【要件】注文されていない料理を提供しているすべてのお店を返すこと
    #   * left_outer_joinsを使うこと
    # foodsのshop_idをもったお店をShopから引き抜く eager_load使いたいけど。。。
    # shopsにfoods
    no_order_foods_id =  Food.left_outer_joins(:order_foods).where.missing(:order_foods).select(:shop_id)
    @shops = Shop.where(id:no_order_foods_id)

    #@shops = Shop.where.((Food.left_outer_joins(:order_foods).where.missing(:order_foods)).select(:shop_id))
  end

  def exercise3 
    # 【要件】配達先の一番多い住所を返すこと
    #   * joinsを使うこと
    #   * 取得したAddressのインスタンスにorders_countと呼びかけると注文の数を返すこと
    @address = Address
  end

  def exercise4 
    # 【要件】一番お金を使っている顧客を返すこと
    #   * joinsを使うこと
    #   * 取得したCustomerのインスタンスにfoods_price_sumと呼びかけると合計金額を返すこと
    @customer = Customer
  end
end
