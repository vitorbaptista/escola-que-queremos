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

    total = Indicators.joins(:school).where({:escolas => {:cod_municipio => cod_municipio}}).count.to_f
    avg_your_indicator_city = Indicators.joins(:school).where({:escolas => {:cod_municipio => cod_municipio}}).sum(indicators_sum) / total

    total = Indicators.joins(:school).where({:escolas => {:uf => uf}}).count.to_f
    avg_your_indicator_state = Indicators.joins(:school).where({:escolas => {:uf => uf}}).sum(indicators_sum) / total

    {
      your_indicator: normalize(your_indicator, indicators.length),
      avg_your_indicator: normalize(avg_your_indicator, indicators.length),
      avg_your_indicator_city: normalize(avg_your_indicator_city, indicators.length),
      avg_your_indicator_state: normalize(avg_your_indicator_state, indicators.length),
    }
  end

  def calculate_ideb_2011
    total = School.count
    avg_ideb_2011 = School.sum('ideb_2011') / total

    total = School.where(cod_municipio: self.cod_municipio).count
    avg_ideb_2011_city = School.where(cod_municipio: self.cod_municipio).sum('ideb_2011') / total

    total = School.where(uf: self.uf).count
    avg_ideb_2011_state = School.where(uf: self.uf).sum('ideb_2011') / total

    {
      ideb_2011: formatted(self.ideb_2011),
      avg_ideb_2011: formatted(avg_ideb_2011),
      avg_ideb_2011_city: formatted(avg_ideb_2011_city),
      avg_ideb_2011_state: formatted(avg_ideb_2011_state)
    }
  end

  def normalize(val, max)
   formatted((MAX * val) / max.to_f)
  end

  def formatted(val)
    format('%.1f', val)
  end
end
