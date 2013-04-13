# encoding: utf-8
class SchoolController < ApplicationController
  def index
    @total_schools = 263833
    @categories = [
      {title: 'Estrutura Física',
       indicators: [{name: 'Estrutura Básica', description: 'Água, luz, bla...', count: 160296},
                    {name: 'Biblioteca', description: '', count: 263833},
                    {name: 'Sala de Informática', description: '', count: 66918},
                    {name: 'Quadra de Esportes', description: '', count: 52045}]},
      {title: 'Insumos e condições de funcionamento da escola',
       indicators: [{name: 'Merenda', description: '', count: 263833},
                    {name: 'Merenda de Qualidade', description: '', count: 2457},
                    {name: 'Projeto Pedagógico', description: ''},
                    {name: 'Livro didático', description: ''}]},
      {title: 'Gestão Escolar Democrática',
       indicators: [{name: 'Conselho Escolar Democrático', description: '', count: 35771},
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
