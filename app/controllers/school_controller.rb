# encoding: utf-8
class SchoolController < ApplicationController
  def index
    @total_schools = 194932
    @categories = [
      {title: 'Estrutura Física',
       indicators: [{name: 'Estrutura Básica', description: 'Água, luz, banheiro e saneamento básico', count: 159853},
                    {name: 'Biblioteca', description: '', count: 65553},
                    {name: 'Sala de Informática', description: 'Com acesso à internet para os alunos', count: 66743},
                    {name: 'Quadra de Esportes', description: '', count: 51924}]},
      {title: 'Insumos e condições de funcionamento da escola',
       indicators: [{name: 'Merenda', description: '', count: 168803},
                    {name: 'Merenda de Qualidade', description: '', count: 2457},
                    {name: 'Projeto Pedagógico', description: '', count: 54129},
                    {name: 'Livro didático', description: 'Para todos alunos', count: 18758}]},
      {title: 'Gestão Escolar Democrática',
       indicators: [{name: 'Conselho Escolar Democrático', description: '', count: 35771},
                    {name: 'Conselho de Classe', description: '', count: 48556},
                    {name: 'Projeto Pedagógico Democrático', description: '', count: 22862},
                    {name: 'Apoio da Comunidade', description: '', count: 52113}]},
      {title: 'Formação e Condições de Trabalho dos Profissionais da Escola',
       indicators: [{name: 'Formação Inicial', description: '', count: 4668},
                    {name: 'Equipe Pedagógica Completa', description: '', count: 46616},
                    {name: 'Turmas Com Até 25 alunos', description: ''},
                    {name: 'Salário Acima do Piso', description: ''}]},
      {title: 'Rendimento e Desempenho',
       indicators: [{name: 'Desempenho Satisfatório em Português', description: ''},
                    {name: 'Desempenho Satisfatório em Matemática', description: ''},
                    {name: 'Índice de Aprovação', description: ''},
                    {name: 'Escola Justa?', description: ''}]}
    ]
  end

  def info
    @school = School.find(params[:id].to_s)
    render json: @school.to_json(include: :indicators, methods: :location)
  end

  def search
    schools = if params[:term]
                School.where("nome like ?", "%#{params[:term].downcase}%")
              else
                School.all.limit(10)
              end
    schools_list = schools.map {|u| Hash[ id: u.cod_escola, label: u.nome, name: u.nome]}

    render json: schools_list
  end
end
