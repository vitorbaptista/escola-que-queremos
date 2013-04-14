class School < ActiveRecord::Base
  self.table_name = 'escolas'
  self.primary_key = 'cod_escola'
  MAX = 10

  has_one :indicators, foreign_key: 'cod_escola'

  def location
    result = SchoolQuest.select(:ID_LOCALIZACAO).where(ID_ESCOLA: cod_escola).limit(1).first
    if result
      localizacao = result.ID_LOCALIZACAO
      if localizacao == 1
        'Urbana'
      elsif localizacao == 2
        'Rural'
      end
    else
      'Desconhecida'
    end
  end

  def calculate_custom_indicator(indicators)
    indicators_sum = indicators.join(' + ') + ' '
    your_indicator = Indicators.where(cod_escola: cod_escola).sum(indicators_sum).to_i
    avg_your_indicator = Indicators.sum(indicators_sum) / Indicators.count.to_f
    {your_indicator: normalize(your_indicator, indicators.length), avg_your_indicator: normalize(avg_your_indicator, indicators.length) }
  end

  def normalize(val, max)
   format('%.1f', (MAX * val) / max.to_f)
  end
end
