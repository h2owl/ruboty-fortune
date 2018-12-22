require 'date'
require 'nokogiri'
require 'open-uri'

module Ruboty
  module Handlers
    # A Ruboty Handler description
    class Fortune < Base
      SEIZA = [
        { name: 'やぎ座',     eng: 'capricorn',   border: 119 },
        { name: 'みずがめ座', eng: 'aquarius',    border: 218 },
        { name: 'うお座',     eng: 'pisces',      border: 320 },
        { name: 'おひつじ座', eng: 'aries',       border: 419 },
        { name: 'おうし座',   eng: 'taurus',      border: 520 },
        { name: 'ふたご座',   eng: 'gemini',      border: 621 },
        { name: 'かに座',     eng: 'cancer',      border: 722 },
        { name: 'しし座',     eng: 'leo',         border: 822 },
        { name: 'おとめ座',   eng: 'virgo',       border: 922 },
        { name: 'てんびん座', eng: 'libra',       border: 1023 },
        { name: 'さそり座',   eng: 'scorpio',     border: 1122 },
        { name: 'いて座',     eng: 'sagittarius', border: 1221 }
      ]

      on /うらない\s(\d{3,4})\z/, name: 'uranai', description: 'uranai yo'
      #env :development, "hoge"

      def uranai(message)
        target_date_num = message.match_data[1].to_i
        str_for_date = "2000/%s/%s" % ("%04d" % target_date_num).scan(/.{2}/)
        begin
          date = Date.parse(str_for_date)
          user_seiza = get_seiza_from_date(date)
          fortune_text = get_fortune_text(user_seiza[:eng])
          message.reply("うらないます：%s(%s)\n---\n%s" % [date.strftime("%m/%d"), user_seiza[:name], fortune_text])
        rescue => e
          message.reply("ごめん、無理でした")
        end
      end

      private
        def get_seiza_from_date(d)
          date_num = d.strftime("%m%d").to_i
          seiza = nil
          SEIZA.each do |row|
            if row[:border] >= date_num
              seiza = row
              break
            end
          end
          if !seiza
            seiza = SEIZA.first
          end
          return seiza
        end

        def get_fortune_text(seiza_name_eng)
          html = Nokogiri::HTML(open('https://fortune.yahoo.co.jp/12astro/%s' % seiza_name_eng))
          text = html.css(".yftn12a-md48 dd").map{|a| a.content}.join("\n")
          return text
        end
    end
  end
end
