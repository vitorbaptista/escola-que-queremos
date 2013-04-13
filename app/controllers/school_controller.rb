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
       indicators: [{name: 'Merenda', description: ''},
                    {name: 'Merenda de Qualidade', description: ''},
                    {name: 'Projeto Pedagógico', description: ''},
                    {name: 'Livro didático', description: ''}]},
      {title: 'Gestão Escolar Democrática',
       indicators: [{name: 'Conselho Escolar Democrático', description: ''},
                    {name: 'Conselho de Classe', description: ''},
                    {name: 'Projeto Pedagógico Democrático', description: ''},
                    {name: 'Apoio da Comunidade', description: ''}]},
      {title: 'Formação e Condições de Trabalho dos Profissionais da Escola',
       indicators: [{name: 'Formação Inicial', description: ''},
                    {name: 'Equipe Pedagógica Completa', description: ''},
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
    render json: @school.to_json(include: :indicators)
  end
end
