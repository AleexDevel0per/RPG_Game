def atraso(texto, tempo = 1)
    texto.each_char do |char|
      print char
      sleep(tempo / 50.0)
    end
    puts
  end
  
  class Personagem
    attr_accessor :nome, :vida, :pontos_especiais, :curas_restantes, :defesa
  
    def initialize(nome, vida, pontos_especiais, curas_restantes)
      @nome = nome
      @vida = vida
      @pontos_especiais = pontos_especiais
      @curas_restantes = curas_restantes
      @defesa = 3  # Inicializando com 3 de defesa
    end
  
    def atacar(inimigo)
      dano = rand(10..20)
      inimigo.vida -= dano
      atraso("#{nome} causou #{dano} de dano ao #{inimigo.nome}!")
    end
  
    def ataque_especial(inimigo)
      if @pontos_especiais >= 5
        dano = rand(30..50)
        inimigo.vida -= dano
        @pontos_especiais -= 5
        atraso("#{nome} causou #{dano} de dano ao #{inimigo.nome} com um ataque especial!")
      else
        atraso("#{nome} tentou usar um ataque especial, mas não tinha pontos suficientes!")
      end
    end
  
    def defender
      if @pontos_especiais >= 2 && @defesa > 0
        @pontos_especiais -= 2
        atraso("#{nome} se defendeu!")
        @defesa -= 1  # Diminuir a defesa após cada defesa
      else
        atraso("#{nome} tentou se defender, mas não tinha pontos suficientes ou defesa!")
      end
    end
  
    def curar
      if @curas_restantes > 0
        cura = rand(15..25)
        @vida += cura
        @curas_restantes -= 1
        atraso("#{nome} se curou em #{cura} pontos de vida!")
      else
        atraso("#{nome} não tem mais curas restantes!")
      end
    end
  
    def status
      "#{nome}: #{vida} HP | Pontos Especiais: #{pontos_especiais} | Curas Restantes: #{curas_restantes} | Defesa: #{defesa}"
    end
  end
  
  class Inimigo
    attr_accessor :nome, :vida, :pontos_especiais, :defesa
  
    def initialize(nome, vida, pontos_especiais)
      @nome = nome
      @vida = vida
      @pontos_especiais = pontos_especiais
      @defesa = 3  # Inicializando com 3 de defesa
    end
  
    def atacar(personagem)
      dano = rand(10..20)
      dano -= personagem.defesa
      dano = [dano, 0].max  # Garante que o dano não seja negativo
      personagem.vida -= dano
      personagem.defesa = 0  # Defesa é removida após o ataque
      atraso("#{nome} causou #{dano} de dano a #{personagem.nome}!")
    end
  
    def ataque_especial(personagem)
      if @pontos_especiais >= 5
        dano = rand(30..50)
        dano -= personagem.defesa
        dano = [dano, 0].max
        personagem.vida -= dano
        @pontos_especiais -= 5
        personagem.defesa = 0
        atraso("#{nome} causou #{dano} de dano a #{personagem.nome} com um ataque especial!")
      else
        atraso("#{nome} tentou usar um ataque especial, mas não tinha pontos suficientes!")
      end
    end
  
    def defender
      if @pontos_especiais >= 2
        @defesa = 3
        @pontos_especiais -= 2
        atraso("#{nome} se defendeu!")
      else
        atraso("#{nome} tentou se defender, mas não tinha pontos suficientes!")
        @defesa = 0
      end
    end
  
    def inteligencia
      # Dragão é mais agressivo se tiver menos HP, mas tenta balancear com a defesa
      if @vida <= 30
        return 0 # Atacar
      elsif @pontos_especiais >= 5
        return rand(2) # 50% de chance de usar ataque especial
      else
        return 1 # Defender
      end
    end
  
    def status
      "#{nome}: #{vida} HP | Pontos Especiais: #{pontos_especiais} | Defesa: #{defesa}"
    end
  end
  
  def batalha
    atraso("Bem-vindo ao jogo de RPG!")
    print "Digite o nome do seu herói: "
    nome_heroi = gets.chomp
    heroi = Personagem.new(nome_heroi, 100, 10, 3)
    dragao = Inimigo.new("Dragão", 150, 10)
  
    atraso("#{heroi.nome}, prepare-se para enfrentar o #{dragao.nome}!")
  
    while heroi.vida > 0 && dragao.vida > 0
      # Status antes do turno do herói
      atraso("\n--- Status de #{heroi.nome} ---")
      puts heroi.status
      puts "-----------------------------------"
  
      # Turno do herói
      atraso("\nÉ sua vez! (Pontos Especiais: #{heroi.pontos_especiais}, Curas Restantes: #{heroi.curas_restantes})")
      puts "Escolha uma ação:"
      puts "1. Atacar"
      puts "2. Ataque especial (5 pontos necessários)"
      puts "3. Defender (2 pontos necessários)"
      puts "4. Curar (máximo 3 vezes)"
      escolha = gets.chomp.to_i
  
      case escolha
      when 1
        heroi.atacar(dragao)
      when 2
        heroi.ataque_especial(dragao)
      when 3
        heroi.defender
      when 4
        heroi.curar
      else
        puts "Opção inválida. Tente novamente."
        next
      end
  
      # Status do dragão após dano
      atraso("\n--- Status do #{dragao.nome} ---")
      puts dragao.status
      puts "-----------------------------------"
  
      # Turno do dragão
      if dragao.vida > 0
        acao_dragao = dragao.inteligencia
        case acao_dragao
        when 0
          dragao.atacar(heroi)
        when 1
          dragao.defender
        when 2
          dragao.ataque_especial(heroi)
        end
      end
  
      # Status após o turno do dragão
      atraso("\n--- Status do #{dragao.nome} ---")
      puts dragao.status
      puts "-----------------------------------"
  
      puts "\n--- Fim do Turno ---\n"
    end
  
    if heroi.vida <= 0
      atraso("\n#{heroi.nome} foi derrotado pelo #{dragao.nome}...")
    elsif dragao.vida <= 0
      atraso("\nParabéns, #{heroi.nome}! Você derrotou o #{dragao.nome}!")
    end
  end
  
  batalha