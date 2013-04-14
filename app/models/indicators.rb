class Indicators < ActiveRecord::Base
  self.table_name = 'indicadores_por_escola'

  belongs_to :school, foreign_key: 'cod_escola'

  def self.valid_ones
    Indicators.column_names - ['cod_escola']
  end
end

