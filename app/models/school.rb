class School < ActiveRecord::Base
  set_table_name 'escolas'
  self.primary_key = 'cod_escola'

  has_one :indicators, foreign_key: 'cod_escola'
end
