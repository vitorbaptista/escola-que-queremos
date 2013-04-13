# encoding: utf-8
class SchoolController < ApplicationController
  def index
    @categories = [
      {title: 'Estrutura Física',
       indicators: [{name: 'Estrutura Básica', description: 'Água, luz, bla...'},
                    {name: 'Biblioteca', description: ''},
                    {name: 'Sala de Informática', description: ''},
                    {name: 'Quadra de Esportes', description: ''}]},
      {title: 'Insumos e condições de funcionamento da escola',
       indicators: [{name: 'Merenda', description: 'Água, luz, bla...'},
                    {name: 'Projeto pedagógico', description: ''},
                    {name: 'Livro didático', description: ''}]}
    ]
  end

  def info
    @school = School.find(params[:id].to_s)
    render json: @school.to_json(include: :indicators)
  end
end
