# -*- coding: utf-8 -*-
class String
  require 'mechanize'
  AGENT = Mechanize.new
  BASE_URL = 'https://yomikatawa.com/kanji/'

  def to_kana
    self.tr('ぁ-ん','ァ-ン')
  end

  def to_hira
    AGENT.get(BASE_URL + self).search('#yomikata td').first.text
  end
end