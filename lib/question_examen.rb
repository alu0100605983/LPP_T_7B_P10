#= Examen.rb
#Autores: Haniel y Maria
#
#==Rdoc
#
#===Clase List
#*Metodo Initialize
#*Metodo get_head
#*Metodo get_tail
#*Metodo lpush
#*Metodo lpop
#*Metodo each
#*Metodo reverse_each
#
#===Clase Exam
#*Metodo initialize
#*Metodo <=>
#
#===Clase SimpleChoice
#*Metodo initialize
#*Metodo to_html
#*Metodo mostrar_pregunta
#*Metodo rmostrar_respuestas
#*Metodo to_s
#*Metodo correcta
#*Metodo <=>
#
#===Clase TrueFalse
#*Metodo initialize
#*Metod <=>
#*Metodo correcta
#*Metodo to_s
#
#===Clase Vista
#*Metodo initialize
#*Metodo test_examn
#
#===Clase Examen
#*Metodo initialize
#*Metodo to_s
#*Metodo reverse

require "question_examen/version"

module QuestionExamen
    # Your code goes here..
    ##################################################
    ############# => Node     ########################
    ##################################################
    Node = Struct.new(:thevalue, :thenext, :theprev)

    ##################################################
    ############# => List     ########################
    ##################################################

    class List

    	include Enumerable

    	attr_accessor :head, :tail

    	def initialize
    		@head = nil
    		@tail = nil
    	end

      def get_head
        @head
      end
      def get_tail
        @tail
      end

      def lpush(other)
        if @head == nil
         @head = other
         @tail = other
       else
         other.thenext = @head
         @head.theprev = other
         other.theprev = nil
         @head = other 
       end
     end

     def lpop
      if(@head != @tail) # Hay más de un elemento en la lista
      	aux = @head
      	@head = @head.thenext
      	@head.theprev = nil
      	aux.thevalue
      elsif (@head ==  @tail) && (@head != nil) # Hay un solo elemento en la lista
        aux = @head #variable creada para que al final retorne el valor del nodo eliminado
        @head = nil
        @tail = nil
        aux.thevalue
      else
       puts "No hay elementos en la lista"
     end
   end

   def each
     aux = @head
      while (aux) do #recorremos la lista
        yield aux.thevalue #envia el bloque de cada valor
        aux=aux.thenext #anvanzamos
      end
    end

    def reverse_each #recorre la lista en orden inverso
    	aux = @tail
    	while(aux) do
    		yield aux
    		aux = aux.theprev
    	end
    end
  end

    ##################################################
    ############# => Exam     ########################
    ##################################################
    class Exam

     include Comparable

     attr_accessor :question

     def initialize(question)
      @question = question
        raise ArgumentError, 'Specify :question' unless @question #retornamos el posible error o sino question
      end

      #Declaración función comparable que luego será heredada.
      def <=>(other)
      end

    end 
    ##################################################
    ############# => SimpleChoice  ###################
    ##################################################
    class SimpleChoice < Exam
     attr_accessor :text, :right, :distractor

     def initialize(args)
      @text = args[:text]
      raise ArgumentError, 'Specify :text' unless @text
      @right = args[:right]
      raise ArgumentError, 'Specify :right' unless @right
      @distractor = args[:distractor]
      raise ArgumentError, 'Specify :distractor' unless @distractor
    end


    def to_html
      @options = @distractor+[@right]
        @options = @options.shuffle# baraja
        s = ' '
        @options.each do |options|
        	s += %Q{<input type = "radio" value= "#{options}" name = 0 > #{options}\n}
        end
        botton = %Q{<input type="button" value="Enviar">}
        #html=<<-"HTML"
        "#{@text}<br/>\n#{s}\n#{botton}\n"
        #HTML
      end

      def mostrar_pregunta
       "#{@text}"
     end

     def mostrar_respuestas
       "#{@options}"
     end

     def to_s
       valor = @distractor+[@right]
       s= ' '
       valor.each do |valor|
        s += %Q{#{valor}\n}  
      end
      "#{@text}\n#{s}\n"
    end 

    def correcta(valor)
    	if valor == @right
    		return true
    	else
    		return false
    	end
    end

    def <=> (other)
    	@text <=> other.text 
    end

    end #simplechoice

  #no se ejecutara desde un require solo de consola
    ##################################################
    ############# => TrueFalse  ###################
    ##################################################
    class TrueFalse < Exam

     attr_accessor :thetrue, :thefalse

     def initialize(question, thetrue, thefalse)

      super(question)

      @thetrue = thetrue
      raise ArgumentError, 'Specify :thetrue' unless @thetrue

      @thefalse = thefalse
      raise ArgumentError, 'Specify :thefalse' unless @thefalse

    end

      #Funcion Heredada y personalizada.
      def <=>(other)
        #http://ruby-doc.org/core-2.1.4/Comparable.html
        @question <=> other.question #nil si no pueden ser comparados. -1 0 1
      end

      def correcta(valor)
       if valor == @thetrue
        return true
      else
        return false
      end
    end

    def to_s
    	opcion = @thefalse+[@thetrue]
    	s= ' '
    	opcion.each do |opcion|
    		s += %Q{#{opcion}\n}
    	end
    	"#{@question}\n#{s}\n"
    end  
    end #fin de VerdaderoFalso
    ##################################################
    ############# => Vista         ###################
    ##################################################
    class Vista
    	attr_accessor :win, :fail, :arrayCorrectas

    	def initialize (arrayCorrectas)
    		@arrayCorrectas = arrayCorrectas
    		@win = 0
    		@fail = 0
    	end

    	def test_exam(arraySinCorregir)
    		contador = 0
    		n_question = 0
    		while (n_question < 4)
    			if (@arrayCorrectas[contador] == arraySinCorregir[contador])
    				@win += 1
    			else
    				@fail += 1
    			end
    			contador +=1
    			n_question +=1
      	end #fin while

        if (@win >= @fail)
          return true
        else
          return false
        end
      end
    end
    ##################################################
    ############# => Examen        ###################
    ##################################################
    class Examen

     include Enumerable

     attr_accessor :list

     def initialize (list)
      @list = list
    end

    def to_s
      @list.each do |n|
       puts "#{n.to_s}\n"
     end
   end

   def reverse(list)
    @list_reverse = QuestionExamen::List.new
    list.reverse_each do |n|
      @list_reverse.lpush(n)
    end
    @list_reverse
  end

  end
end
