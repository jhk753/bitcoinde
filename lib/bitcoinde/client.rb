require 'hashie'
require 'base64'
require 'addressable/uri'
require 'nokogiri'
require 'open-uri'
require 'yaml'
require 'httparty'


module Bitcoinde
  class Client
    include HTTParty

    def initialize(options={})
      @base_uri     = options[:base_uri] ||= 'www.bitcoin.de/en/'
      @google ||= self.class.get("https://maps.googleapis.com/maps/api/timezone/json?location=52.5075419,13.4261419&timestamp=#{Time.now.to_i}&sensor=false").parsed_response
      @offset ||= (@google["dstOffset"] + @google["rawOffset"])/3600
    end

    ###########################
    ###### Public Data ########
    ###########################


    def ticker
      page = get_public("market")
      page.css("div.fs12.wp100 div.fright strong").text[0..-3].gsub(",", ".").to_f
    end

    def depth
      page = get_public("market")
      asks_table = page.css("article.fleft tbody#box_buy_sell_offer tr[data-trade-type='offer']")
      bids_table = page.css("article.fright tbody#box_buy_sell_order tr[data-trade-type='order']")
      asks = []
      bids = []
      bids_table.each do |b|
        bids << {price: b["data-critical-price"].to_f, amount: b["data-critical-amount"].to_f}
      end
      asks_table.each do |a|
        asks <<  {price: a["data-critical-price"].to_f, amount: a["data-critical-amount"].to_f}
      end

      Hashie::Mash.new({asks: asks, bids: bids})
    end

    def trades
      page = get_public("market")
      trades_list = []
      page.css("section.brd2t table.list.aright tr").each do |tr|
        tds = tr.css("td")
        unless tds.empty?
          str = tds[0].text.match("([0-9][0-9](.| |:)){5}")[0]+"+#{@offset}"
          datetime = Time.strptime(str, "%d.%m.%y %H:%M %z")
          trades_list << {time: datetime, price: tds[1].text.gsub(",", ".").to_f, btc_volume: tds[2].text.gsub(",", ".").to_f, eur_volume: tds[3].text.gsub(",", ".").to_f}
        end
      end
      Hashie::Mash.new({trades: trades_list})

    end

    def get_public(method, opts={})
      url = 'https://'+ @base_uri + method
      page = Nokogiri(open(url))
      page.css('div#wrap')
    end

  end
end

class Hashie::Mash
    def try key
       if self.key?(key.to_s)
         self[key]
       else
         self
       end
    end
end
