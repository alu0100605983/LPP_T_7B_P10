require "question_examen.rb"

module QuestionExamen
  describe QuestionExamen::SimpleChoice do

    before :each do
      @p1 = QuestionExamen::SimpleChoice.new(:text => '¿Cuanto es 2+5 ?', :right => 7, :distractor => [2,5,10])
      @p2 = QuestionExamen::SimpleChoice.new(:text => '¿Cuanto es 2+5 ?', :right => 7, :distractor => [2,5,10])
      @p3 = QuestionExamen::SimpleChoice.new(:text => '¿Cuanto es 2+2+2 ?', :right => 7, :distractor => [2,5,10])
    end

    describe "Construccion de una pregunta" do

      it "Tiene pregunta" do
        expect(@p1.text) == '¿Cuanto es 2+5 ?'
      end

      it "Tiene respuesta correcta" do
        expect(@p1.right) == 7
      end

      it "Tiene otras respuestas" do
        expect(@p1.distractor) == [2,5,10]
      end

      it "Conversion html" do
        expect(@p1).to respond_to :to_html
      end

      it "Pertence a clase" do
        expect(@p1.class) == SimpleChoice
      end

      it "Probando comparacion igual" do
        expect(@p1 == @p2).to eq(true)    
      end  
      it "Probando comparacion distinto" do
        expect(@p2 == @p3).to eq(false)    
      end    
      it "Probando comparacion mayor" do
        expect(@p3 < @p2).to eq(true)    
      end
      it "Probando comparacion menor" do
        expect(@p3 > @p2).to eq(false)    
      end


    end
    end #describe SimpleChoice

    describe QuestionExamen::TrueFalse do   
      before :each do
        @p2=QuestionExamen::TrueFalse.new(
          "Es apropiado que una clase Tablero herede de una clase Juego \n", "a) Verdadero \n",
        "b) Falso \n") 
        @p3=QuestionExamen::TrueFalse.new(
          "Es apropiado que una clase Tablero herede de una clase Juego \n", "a) Verdadero \n",
        "b) Falso \n")
        @p4=QuestionExamen::TrueFalse.new(
          "Es apropiado que una clase Tablero herede de una clase Juegos \n", "a) Verdadero! \n",
        "b) False \n")          
      end   

      describe "Probando Clase True False" do
        it "Enuncia heredado" do
          expect(@p2.question) == 'Es apropiado que una clase Tablero herede de una clase Juego \n'         
        end
        it "Probando respuesta correcta" do
          expect(@p2.thetrue) == 'a) Verdadero \n'         
end 
it "Probando respuesta incorrecta" do
  expect(@p2.thefalse) == 'b) Falso \n'         
end 
it "Probando metodo to_s" do
  expect(@p2).to respond_to :to_s       
end   
it "Probando comparacion igual" do
  expect(@p2 == @p3).to eq(true)    
end  
it "Probando comparacion distinto" do
  expect(@p2 == @p4).to eq(false)    
end    
it "Probando comparacion mayor" do
  expect(@p4 > @p2).to eq(true)    
end
it "Probando comparacion menor" do
  expect(@p4 < @p2).to eq(false)    
end
end     
end


describe QuestionExamen::List do   
  before :each do
    @p2 = QuestionExamen::SimpleChoice.new(:text => '¿Cuanto es 2+5 ?', :right => 7, :distractor => [2,5,10])
    @p3 = QuestionExamen::SimpleChoice.new(:text => '¿Cuanto es 2+2+2 ?', :right => 7, :distractor => [2,5,10])
    @lista = QuestionExamen::List.new()
    @nodo1 = QuestionExamen::Node.new(@p2, nil, nil)
    @nodo2 = QuestionExamen::Node.new(@p3, nil, nil) 
    @nodo3 = QuestionExamen::Node.new("pepe1", nil, nil) 
    @nodo4 = QuestionExamen::Node.new("pepe2", nil, nil)    
  end   

  describe "Lista doblemente enlazada" do
    it "El nodo tiene cabeza" do
      expect(@nodo1.thevalue) != nil
    end
    it "El nodo tiene siguiente" do
      expect(@nodo1.thenext == nil)
    end
    it "El nodo tiene anterior" do
      expect(@nodo1.theprev == nil)
    end

    it "Se insertan nodos en la lista" do
      @lista.lpush(@nodo1)
      expect(@lista.head).to eq(@nodo1)
    end
    it "Se inserta un elemento por el principio" do
      @lista.lpush(@nodo1)
      @lista.lpush(@nodo2) 
      @lista.lpush(@nodo3)
      @lista.lpush(@nodo4)
      expect(@lista.head).to eq(@nodo4)
    end

    it "Se extrae el primer elemento de la lista" do
      @lista.lpush(@nodo1)
      @lista.lpush(@nodo2)
      @lista.lpop
      expect(@lista.head).to eq(@nodo1) 
    end

      #http://ruby-doc.org/core-2.1.4/Enumerable.html

      it "Probando bucle con elementos" do
        @lista.lpush(@nodo1)
        @lista.lpush(@nodo2)
        @lista.all?
        expect(@lista.all?).to eq(true)
      end
    end #End describe
  end  #End describe list
  describe QuestionExamen::Examen do

    before :each do

      @p1=QuestionExamen::TrueFalse.new(
        "Es apropiado que una clase Tablero herede de una clase Juego", "Verdadero",
        ["Falso \n"])
      @p2=QuestionExamen::TrueFalse.new(
        "Salida class de hash_raro = {[1, 2, 3] => Object.new(),Hash.new => :toto}", "Verdadero",
        ["Falso \n"])
      @p3=QuestionExamen::TrueFalse.new(
        "¿Esto es un examen?", "Si", ["No"])
      @p4 = QuestionExamen::SimpleChoice.new(:text => '¿Cuanto es 2+5 ?', :right => "7", :distractor => [2,5,10])

      @lista_exam = QuestionExamen::List.new()

      @nodo_p1 = QuestionExamen::Node.new(@p1, nil, nil)
      @nodo_p2 = QuestionExamen::Node.new(@p2, nil, nil)
      @nodo_p3 = QuestionExamen::Node.new(@p3, nil, nil)
      @nodo_p4 = QuestionExamen::Node.new(@p4, nil, nil)

      @lista_exam.lpush(@nodo_p1)
      @lista_exam.lpush(@nodo_p2)
      @lista_exam.lpush(@nodo_p3)
      @lista_exam.lpush(@nodo_p4)

      @exam = QuestionExamen::Examen.new(@lista_exam)

      @array_correctas = ["7", "Si", "Falso", "Verdadero"]

      @vista = QuestionExamen::Vista.new(@array_correctas)

    end

    it "Controlar Arrays de preguntas correctas e incorrectas" do
      array_usuario = ["7", "Si", "Falso", "Verdadero"]
      expect(@vista.test_exam(array_usuario)).to eq(true)
      expect(@vista.win.is_a?Integer).to eq(true)
      expect(@vista.fail.is_a?Integer).to eq(true)
    end

    it "Usuario 0 correctas" do
      array_usuario = ["2", "No", "Verdadero", "Falso"]
      expect(@vista.test_exam(array_usuario)).to eq(false)
    end

    it "Usuario aprueba con la nota minima" do
      array_usuario = ["2", "No", "Falso", "Verdadero"]
      expect(@vista.test_exam(array_usuario)).to eq(true)
    end

    it "Controlar invertir lista" do
      @list_normal = QuestionExamen::List.new()
      @list_normal.lpush(@nodo_p1)
      @list_normal.lpush(@nodo_p2)
      @list_normal.lpush(@nodo_p3)
      @list_normal.lpush(@nodo_p4)
      #puts "1 #{@list_normal.get_head.thevalue} --1"
      #puts "2 #{@list_normal.tail.thevalue} --2"

      @list_inverse = QuestionExamen::Examen.new(@list_normal)

      #puts "P4 #{@nodo_p4.thevalue} --P4"
      #puts "HEAD #{@list_inverse.reverse(@list_normal).get_head.thevalue} --HEAD"
      
      expect(@list_inverse.reverse(@list_normal).get_tail.thevalue).to eq(@nodo_p1.thevalue)    
    end

  end
end