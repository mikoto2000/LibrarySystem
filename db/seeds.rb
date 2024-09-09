# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

NdcCategory.create!(
  [
    { number: 0, name: "\u7DCF\u8A18\uFF08General works\uFF09" },
    { number: 10,
      name: "\u56F3\u66F8\u9928\u3001\u56F3\u66F8\u9928\u60C5\u5831\u5B66\uFF08Libraries. Library and information sciences\uFF09" },
    { number: 20, name: "\u56F3\u66F8\u3001\u66F8\u8A8C\u5B66\uFF08Books, Bibliography\uFF09" },
    { number: 30, name: "\u767E\u79D1\u4E8B\u5178\uFF08General encyclopedias\uFF09" },
    { number: 40,
      name: "\u4E00\u822C\u8AD6\u6587\u96C6\u3001\u4E00\u822C\u8B1B\u6F14\u96C6\uFF08General collected essays\uFF09" },
    { number: 50, name: "\u9010\u6B21\u520A\u884C\u7269\uFF08General serial publications\uFF09" },
    { number: 60,
      name: "\u56E3\u4F53\u3001\u5B66\u4F1A\u3001\u5354\u4F1A\u3001\u4F1A\u8B70\uFF08General societies\uFF09" },
    { number: 70,
      name: "\u30B8\u30E3\u30FC\u30CA\u30EA\u30BA\u30E0\u3001\u65B0\u805E\uFF08Journalism. Newspapers\uFF09" },
    { number: 80, name: "\u53E2\u66F8\u3001\u5168\u96C6\u3001\u9078\u96C6\uFF08General collections\uFF09" },
    { number: 90,
      name: "\u8CB4\u91CD\u66F8\u3001\u90F7\u571F\u8CC7\u6599\u3001\u305D\u306E\u4ED6\u306E\u7279\u5225\u30B3\u30EC\u30AF\u30B7\u30E7\u30F3\uFF08Rare books. Local collections. Special collections\uFF09" },
    { number: 100, name: "\u54F2\u5B66\uFF08Philosophy\uFF09" },
    { number: 110, name: "\u54F2\u5B66\u5404\u8AD6\uFF08Special treatises on philosophy\uFF09" },
    { number: 120, name: "\u6771\u6D0B\u601D\u60F3\uFF08Oriental thought\uFF09" },
    { number: 130, name: "\u897F\u6D0B\u54F2\u5B66\uFF08Western philosophy\uFF09" },
    { number: 140, name: "\u5FC3\u7406\u5B66\uFF08Psychology\uFF09" },
    { number: 150, name: "\u502B\u7406\u5B66\u3001\u9053\u5FB3\uFF08Ethics. Morals\uFF09" },
    { number: 160, name: "\u5B97\u6559\uFF08Religion\uFF09" },
    { number: 170, name: "\u795E\u9053\uFF08Shinto\uFF09" },
    { number: 180, name: "\u4ECF\u6559\uFF08Buddhism\uFF09" },
    { number: 190, name: "\u30AD\u30EA\u30B9\u30C8\u6559\uFF08Christianity\uFF09" },
    { number: 200, name: "\u6B74\u53F2\uFF08General History\uFF09" },
    { number: 210, name: "\u65E5\u672C\u53F2\uFF08General history of Japan\uFF09" },
    { number: 220, name: "\u30A2\u30B8\u30A2\u53F2\u3001\u6771\u6D0B\u53F2\uFF08General history of Asia\uFF09" },
    { number: 230,
      name: "\u30E8\u30FC\u30ED\u30C3\u30D1\u53F2\u3001\u897F\u6D0B\u53F2\uFF08General history of Europe\uFF09" },
    { number: 240, name: "\u30A2\u30D5\u30EA\u30AB\u53F2\uFF08General history of Africa\uFF09" },
    { number: 250, name: "\u5317\u30A2\u30E1\u30EA\u30AB\u53F2\uFF08General history of North America\uFF09" },
    { number: 260, name: "\u5357\u30A2\u30E1\u30EA\u30AB\u53F2\uFF08General history of South America\uFF09" },
    { number: 270,
      name: "\u30AA\u30BB\u30A2\u30CB\u30A2\u53F2\u3001\u4E21\u6975\u5730\u65B9\u53F2\uFF08General history of Oceania. General history of Polar regions\uFF09" },
    { number: 280, name: "\u4F1D\u8A18\uFF08General biography\uFF09" },
    { number: 290,
      name: "\u5730\u7406\u3001\u5730\u8A8C\u3001\u7D00\u884C\uFF08General geography. Description and travel\uFF09" },
    { number: 300, name: "\u793E\u4F1A\u79D1\u5B66\uFF08Social sciences\uFF09" },
    { number: 310, name: "\u653F\u6CBB\uFF08Political science\uFF09" },
    { number: 320, name: "\u6CD5\u5F8B\uFF08Law\uFF09" },
    { number: 330, name: "\u7D4C\u6E08\uFF08Economics\uFF09" },
    { number: 340, name: "\u8CA1\u653F\uFF08Public finance\uFF09" },
    { number: 350, name: "\u7D71\u8A08\uFF08Statistics\uFF09" },
    { number: 360, name: "\u793E\u4F1A\uFF08Society\uFF09" },
    { number: 370, name: "\u6559\u80B2\uFF08Education\uFF09" },
    { number: 380,
      name: "\u98A8\u4FD7\u7FD2\u6163\u3001\u6C11\u4FD7\u5B66\u3001\u6C11\u65CF\u5B66\uFF08Customs, folklore and ethnology\uFF09" },
    { number: 390, name: "\u56FD\u9632\u3001\u8ECD\u4E8B\uFF08National defence. Military science\uFF09" },
    { number: 400, name: "\u81EA\u7136\u79D1\u5B66\uFF08Natural sciences\uFF09" },
    { number: 410, name: "\u6570\u5B66\uFF08Mathematics\uFF09" },
    { number: 420, name: "\u7269\u7406\u5B66\uFF08Physics\uFF09" },
    { number: 430, name: "\u5316\u5B66\uFF08Chemistry\uFF09" },
    { number: 440, name: "\u5929\u6587\u5B66\u3001\u5B87\u5B99\u79D1\u5B66\uFF08Astronomy. Space sciences\uFF09" },
    { number: 450,
      name: "\u5730\u7403\u79D1\u5B66\u3001\u5730\u5B66\u3001\u5730\u8CEA\u5B66\uFF08Earth sciences\uFF09" },
    { number: 460, name: "\u751F\u7269\u79D1\u5B66\u3001\u4E00\u822C\u751F\u7269\u5B66\uFF08Biology\uFF09" },
    { number: 470, name: "\u690D\u7269\u5B66\uFF08Botany\uFF09" },
    { number: 480, name: "\u52D5\u7269\u5B66\uFF08Zoology\uFF09" },
    { number: 490, name: "\u533B\u5B66\uFF08Medical sciences\uFF09" },
    { number: 500, name: "\u6280\u8853\u3001\u5DE5\u5B66\uFF08Technology. Engineering\uFF09" },
    { number: 510,
      name: "\u5EFA\u8A2D\u5DE5\u5B66\u3001\u571F\u6728\u5DE5\u5B66\uFF08Construction. Civil engineering\uFF09" },
    { number: 520, name: "\u5EFA\u7BC9\u5B66\uFF08Architecture. Building\uFF09" },
    { number: 530, name: "\u6A5F\u68B0\u5DE5\u5B66\uFF08Mechanical engineering\uFF09" },
    { number: 540, name: "\u96FB\u6C17\u5DE5\u5B66\uFF08Electrical engineering\uFF09" },
    { number: 550, name: "\u6D77\u6D0B\u5DE5\u5B66\u3001\u8239\u8236\u5DE5\u5B66\uFF08Maritime engineering\uFF09" },
    { number: 560,
      name: "\u91D1\u5C5E\u5DE5\u5B66\u3001\u9271\u5C71\u5DE5\u5B66\uFF08Metal and mining engineering\uFF09" },
    { number: 570, name: "\u5316\u5B66\u5DE5\u696D\uFF08Chemical technology\uFF09" },
    { number: 580, name: "\u88FD\u9020\u5DE5\u696D\uFF08Manufactures\uFF09" },
    { number: 590, name: "\u5BB6\u653F\u5B66\u3001\u751F\u6D3B\u79D1\u5B66\uFF08Domestic arts and sciences\uFF09" },
    { number: 600, name: "\u7523\u696D\uFF08Industry and commerce\uFF09" },
    { number: 610, name: "\u8FB2\u696D\uFF08Agriculture\uFF09" },
    { number: 620, name: "\u5712\u82B8\uFF08Horticulture\uFF09" },
    { number: 630, name: "\u8695\u7CF8\u696D\uFF08Sericulture. Silk industry\uFF09" },
    { number: 640, name: "\u755C\u7523\u696D\uFF08Animal husbandry\uFF09" },
    { number: 650, name: "\u6797\u696D\uFF08Forestry\uFF09" },
    { number: 660, name: "\u6C34\u7523\u696D\uFF08Fishing industry. Fisheries\uFF09" },
    { number: 670, name: "\u5546\u696D\uFF08Commerce\uFF09" },
    { number: 680, name: "\u904B\u8F38\u3001\u4EA4\u901A\uFF08Transportation services\uFF09" },
    { number: 690, name: "\u901A\u4FE1\u4E8B\u696D\uFF08Communication services\uFF09" },
    { number: 700, name: "\u82B8\u8853\u3001\u7F8E\u8853\uFF08The arts. Fine arts\uFF09" },
    { number: 710, name: "\u5F6B\u523B\uFF08Sculpture. Plastic arts\uFF09" },
    { number: 720, name: "\u7D75\u753B\uFF08Painting. Pictorial arts\uFF09" },
    { number: 730, name: "\u7248\u753B\uFF08Engraving\uFF09" },
    { number: 740, name: "\u5199\u771F\uFF08Photography and photographs\uFF09" },
    { number: 750, name: "\u5DE5\u82B8\uFF08Industrial arts\uFF09" },
    { number: 760, name: "\u97F3\u697D\uFF08Music\uFF09" },
    { number: 770, name: "\u6F14\u5287\uFF08Theater\uFF09" },
    { number: 780, name: "\u30B9\u30DD\u30FC\u30C4\u3001\u4F53\u80B2\uFF08Sports and physical training\uFF09" },
    { number: 790, name: "\u8AF8\u82B8\u3001\u5A2F\u697D\uFF08Accomplishments and amusements\uFF09" },
    { number: 800, name: "\u8A00\u8A9E\uFF08Language\uFF09" },
    { number: 810, name: "\u65E5\u672C\u8A9E\uFF08Japanese\uFF09" },
    { number: 820, name: "\u4E2D\u56FD\u8A9E\uFF08Chinese\uFF09" },
    { number: 830, name: "\u82F1\u8A9E\uFF08English\uFF09" },
    { number: 840, name: "\u30C9\u30A4\u30C4\u8A9E\uFF08German\uFF09" },
    { number: 850, name: "\u30D5\u30E9\u30F3\u30B9\u8A9E\uFF08French\uFF09" },
    { number: 860, name: "\u30B9\u30DA\u30A4\u30F3\u8A9E\uFF08Spanish\uFF09" },
    { number: 870, name: "\u30A4\u30BF\u30EA\u30A2\u8A9E\uFF08Italian\uFF09" },
    { number: 880, name: "\u30ED\u30B7\u30A2\u8A9E\uFF08Russian\uFF09" },
    { number: 890, name: "\u305D\u306E\u4ED6\u306E\u8AF8\u8A00\u8A9E\uFF08Other languages\uFF09" },
    { number: 900, name: "\u6587\u5B66\uFF08Literature\uFF09" },
    { number: 910, name: "\u65E5\u672C\u6587\u5B66\uFF08Japanese literature\uFF09" },
    { number: 920, name: "\u4E2D\u56FD\u6587\u5B66\uFF08Chinese literature\uFF09" },
    { number: 930, name: "\u82F1\u7C73\u6587\u5B66\uFF08English and American literature\uFF09" },
    { number: 940, name: "\u30C9\u30A4\u30C4\u6587\u5B66\uFF08German literature\uFF09" },
    { number: 950, name: "\u30D5\u30E9\u30F3\u30B9\u6587\u5B66\uFF08French literature\uFF09" },
    { number: 960, name: "\u30B9\u30DA\u30A4\u30F3\u6587\u5B66\uFF08Spanish literature\uFF09" },
    { number: 970, name: "\u30A4\u30BF\u30EA\u30A2\u6587\u5B66\uFF08Italian literature\uFF09" },
    { number: 980, name: "\u30ED\u30B7\u30A2\u30FB\u30BD\u30D3\u30A8\u30C8\u6587\u5B66\uFF08Russian literature\uFF09" },
    { number: 990,
      name: "\u305D\u306E\u4ED6\u306E\u8AF8\u8A00\u8A9E\u6587\u5B66\uFF08Literatures of other languages\uFF09" }
  ]
)

BookStockStatus.create!([
                          {
                            name: "貸出可能"
                          },
                          {
                            name: "貸出中"
                          },
                          {
                            name: "貸出不可"
                          },
                          {
                            name: "破棄"
                          }
                        ])

LendingStatus.create!([
                        {
                          name: "貸出中"
                        },
                        {
                          name: "貸出期限超過"
                        },
                        {
                          name: "返却済"
                        }
                      ])
