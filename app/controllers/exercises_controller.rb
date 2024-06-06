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
    # shopsにfoods外結する意味？？

    #注文していない商品のidとshop_id
    no_order_foods_shop_id =  Food.left_outer_joins(:order_foods).where.missing(:order_foods).select(:shop_id)
    #注文していない商品のshop_idのみ
    no_order_shop_id =[]
    no_order_foods_shop_id.each do |id|
      no_order_shop_id.push(id.shop_id)
    end
    @shops = Shop.left_outer_joins(:foods).where(id: no_order_shop_id).distinct

  end

  def exercise3 
    # 【要件】配達先の一番多い住所を返すこと
    #   * joinsを使うこと
    #   * 取得したAddressのインスタンスにorders_countと呼びかけると注文の数を返すこと  
    join_result  = Address.joins(:orders).where(addressable_type: "Customer")
    max_address = join_result.group("id").count.sort_by{|k,v|v}.reverse.first
    @address = join_result.group("id").select("addresses.*","count(orders.id) as orders_count").distinct.where(id:max_address[0]).first
  end

  def exercise4 
    # 【要件】一番お金を使っている顧客を返すこと
    #   * joinsを使うこと
    #   * 取得したCustomerのインスタンスにfoods_price_sumと呼びかけると合計金額を返すこと
    @customer =   Customer.joins(orders: :foods).group("id").select("customers.*","sum(foods.price) as foods_price_sum").order(foods_price_sum: :desc).first

  end
end
