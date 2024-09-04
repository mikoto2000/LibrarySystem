Ransack.configure do |config|
  config.custom_arrows = {
    up_arrow: '<i class="bi-sort-down"></i>',
    down_arrow: '<i class="bi-sort-down-alt"></i>',
    default_arrow: '<i class="bi-arrow-down-up"></i>'
  }

  config.add_predicate 'lteq_end_of_day',
    :arel_predicate => 'lteq',
    :formatter => proc {|v| v.end_of_day},
    :compounds => false

  config.add_predicate 'lteq_end_of_minute',
    :arel_predicate => 'lteq',
    :formatter => proc {|v| v + 59},
    :compounds => false
end
