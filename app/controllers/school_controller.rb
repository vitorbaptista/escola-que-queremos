# encoding: utf-8
class SchoolController < ApplicationController
  BRASIL = JSON.parse(File.open('public/brasil.json').read)
  ESTADOS = JSON.parse(File.open('public/estados.json').read)
  MUNICIPIOS = JSON.parse(File.open('public/municipios.json').read)
  require "pry", binding.pry

  def index
    @categories = [
      {title: 'Ambiente físico escolar',
       indicators: [{name: 'Estrutura Básica', description: 'Água, luz, banheiro e saneamento básico'},
                    {name: 'Biblioteca', description: ''},
                    {name: 'Sala de Informática', description: 'Com acesso à internet para os alunos'},
                    {name: 'Quadra de Esportes', description: ''}]},
      {title: 'Insumos e condições de funcionamento da escola',
       indicators: [{name: 'Merenda', description: ''},
                    {name: 'Merenda de Qualidade', description: 'Quantidade, variedade, pessoal, e espaço para cozinhar'},
                    {name: 'Projeto Pedagógico', description: ''},
                    {name: 'Livro didático', description: 'Para todos alunos'}]},
      {title: 'Gestão escolar democrática',
       indicators: [{name: 'Conselho Escolar Democrático', description: ''},
                    {name: 'Conselho de Classe', description: ''},
                    {name: 'Projeto Pedagógico Democrático', description: ''},
                    {name: 'Apoio da Comunidade', description: ''}]},
      {title: 'Formação e condições de trabalho dos profissionais da escola',
       indicators: [{name: 'Formação Inicial', description: ''},
                    {name: 'Equipe Pedagógica Completa', description: ''}]}
    ]
  end

  def indicators
    render json: ESTADOS[params[:id]] || MUNICIPIOS[params[:id]] || BRASIL
  end

  def show
    @school = School.find(params[:id].to_s)
    render json: @school.to_json(include: :indicators, methods: [:location, :calculate_ideb_2011])
  end

  def search
    schools = if params[:term]
                School.where("nome like ?", "%#{params[:term].downcase}%")
              else
                School.all.limit(10)
              end
    schools_list = schools.map {|u| Hash[ id: u.cod_escola, name: u.nome, label: (u.nome + " (#{u.uf})")]}

    render json: schools_list
  end

  def your_indicator
    indicators = Indicators.valid_ones & (params[:indicadores] || '').split(',')
    (render status: 400, text: 'Bad Request' if indicators.empty?) and return

    school = School.find(params[:id].to_s)

    render json: school.calculate_custom_indicator(indicators)
  end

end

