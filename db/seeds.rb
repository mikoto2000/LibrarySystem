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
    { number: 0, name: '総記（General works）' },
    { number: 10, name: '図書館、図書館情報学（Libraries. Library and information sciences）' },
    { number: 20, name: '図書、書誌学（Books, Bibliography）' },
    { number: 30, name: '百科事典（General encyclopedias）' },
    { number: 40, name: '一般論文集、一般講演集（General collected essays）' },
    { number: 50, name: '逐次刊行物（General serial publications）' },
    { number: 60, name: '団体、学会、協会、会議（General societies）' },
    { number: 70, name: 'ジャーナリズム、新聞（Journalism. Newspapers）' },
    { number: 80, name: '叢書、全集、選集（General collections）' },
    { number: 90, name: '貴重書、郷土資料、その他の特別コレクション（Rare books. Local collections. Special collections）' },
    { number: 100, name: '哲学（Philosophy）' },
    { number: 110, name: '哲学各論（Special treatises on philosophy）' },
    { number: 120, name: '東洋思想（Oriental thought）' },
    { number: 130, name: '西洋哲学（Western philosophy）' },
    { number: 140, name: '心理学（Psychology）' },
    { number: 150, name: '倫理学、道徳（Ethics. Morals）' },
    { number: 160, name: '宗教（Religion）' },
    { number: 170, name: '神道（Shinto）' },
    { number: 180, name: '仏教（Buddhism）' },
    { number: 190, name: 'キリスト教（Christianity）' },
    { number: 200, name: '歴史（General History）' },
    { number: 210, name: '日本史（General history of Japan）' },
    { number: 220, name: 'アジア史、東洋史（General history of Asia）' },
    { number: 230, name: 'ヨーロッパ史、西洋史（General history of Europe）' },
    { number: 240, name: 'アフリカ史（General history of Africa）' },
    { number: 250, name: '北アメリカ史（General history of North America）' },
    { number: 260, name: '南アメリカ史（General history of South America）' },
    { number: 270, name: 'オセアニア史、両極地方史（General history of Oceania. General history of Polar regions）' },
    { number: 280, name: '伝記（General biography）' },
    { number: 290, name: '地理、地誌、紀行（General geography. Description and travel）' },
    { number: 300, name: '社会科学（Social sciences）' },
    { number: 310, name: '政治（Political science）' },
    { number: 320, name: '法律（Law）' },
    { number: 330, name: '経済（Economics）' },
    { number: 340, name: '財政（Public finance）' },
    { number: 350, name: '統計（Statistics）' },
    { number: 360, name: '社会（Society）' },
    { number: 370, name: '教育（Education）' },
    { number: 380, name: '風俗習慣、民俗学、民族学（Customs, folklore and ethnology）' },
    { number: 390, name: '国防、軍事（National defence. Military science）' },
    { number: 400, name: '自然科学（Natural sciences）' },
    { number: 410, name: '数学（Mathematics）' },
    { number: 420, name: '物理学（Physics）' },
    { number: 430, name: '化学（Chemistry）' },
    { number: 440, name: '天文学、宇宙科学（Astronomy. Space sciences）' },
    { number: 450, name: '地球科学、地学、地質学（Earth sciences）' },
    { number: 460, name: '生物科学、一般生物学（Biology）' },
    { number: 470, name: '植物学（Botany）' },
    { number: 480, name: '動物学（Zoology）' },
    { number: 490, name: '医学（Medical sciences）' },
    { number: 500, name: '技術、工学（Technology. Engineering）' },
    { number: 510, name: '建設工学、土木工学（Construction. Civil engineering）' },
    { number: 520, name: '建築学（Architecture. Building）' },
    { number: 530, name: '機械工学（Mechanical engineering）' },
    { number: 540, name: '電気工学（Electrical engineering）' },
    { number: 550, name: '海洋工学、船舶工学（Maritime engineering）' },
    { number: 560, name: '金属工学、鉱山工学（Metal and mining engineering）' },
    { number: 570, name: '化学工業（Chemical technology）' },
    { number: 580, name: '製造工業（Manufactures）' },
    { number: 590, name: '家政学、生活科学（Domestic arts and sciences）' },
    { number: 600, name: '産業（Industry and commerce）' },
    { number: 610, name: '農業（Agriculture）' },
    { number: 620, name: '園芸（Horticulture）' },
    { number: 630, name: '蚕糸業（Sericulture. Silk industry）' },
    { number: 640, name: '畜産業（Animal husbandry）' },
    { number: 650, name: '林業（Forestry）' },
    { number: 660, name: '水産業（Fishing industry. Fisheries）' },
    { number: 670, name: '商業（Commerce）' },
    { number: 680, name: '運輸、交通（Transportation services）' },
    { number: 690, name: '通信事業（Communication services）' },
    { number: 700, name: '芸術、美術（The arts. Fine arts）' },
    { number: 710, name: '彫刻（Sculpture. Plastic arts）' },
    { number: 720, name: '絵画（Painting. Pictorial arts）' },
    { number: 730, name: '版画（Engraving）' },
    { number: 740, name: '写真（Photography and photographs）' },
    { number: 750, name: '工芸（Industrial arts）' },
    { number: 760, name: '音楽（Music）' },
    { number: 770, name: '演劇（Theater）' },
    { number: 780, name: 'スポーツ、体育（Sports and physical training）' },
    { number: 790, name: '諸芸、娯楽（Accomplishments and amusements）' },
    { number: 800, name: '言語（Language）' },
    { number: 810, name: '日本語（Japanese）' },
    { number: 820, name: '中国語（Chinese）' },
    { number: 830, name: '英語（English）' },
    { number: 840, name: 'ドイツ語（German）' },
    { number: 850, name: 'フランス語（French）' },
    { number: 860, name: 'スペイン語（Spanish）' },
    { number: 870, name: 'イタリア語（Italian）' },
    { number: 880, name: 'ロシア語（Russian）' },
    { number: 890, name: 'その他の諸言語（Other languages）' },
    { number: 900, name: '文学（Literature）' },
    { number: 910, name: '日本文学（Japanese literature）' },
    { number: 920, name: '中国文学（Chinese literature）' },
    { number: 930, name: '英米文学（English and American literature）' },
    { number: 940, name: 'ドイツ文学（German literature）' },
    { number: 950, name: 'フランス文学（French literature）' },
    { number: 960, name: 'スペイン文学（Spanish literature）' },
    { number: 970, name: 'イタリア文学（Italian literature）' },
    { number: 980, name: 'ロシア・ソビエト文学（Russian literature）' },
    { number: 990, name: 'その他の諸言語文学（Literatures of other languages）' },
  ]
)

BookStockStatus.create!([
  {
    name: "貸出可能",
  },
  {
    name: "貸出中",
  },
  {
    name: "貸出不可",
  },
  {
    name: "破棄",
  }
])

LendingStatus.create!([
  {
    name: "貸出中",
  },
  {
    name: "貸出期限超過",
  },
  {
    name: "返却済",
  }
])
