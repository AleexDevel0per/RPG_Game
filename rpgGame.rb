# Função auxiliar para animação de texto
def atraso(texto, tempo = 0.03)
    texto.each_char do |char|
      print char
      sleep(tempo)
    end
    puts
  end
  
  # Classe Personagem
  class Personagem
    attr_accessor :nome, :vida, :pontos_especiais, :curas_restantes, :defesa
  
    def initialize(nome, vida, pontos_especiais, curas_restantes, defesa)
      @nome = nome
      @vida = vida
      @pontos_especiais = pontos_especiais
      @curas_restantes = curas_restantes
      @defesa = defesa
    end
  
    def atacar(alvo)
      dano = [rand(10..20) - alvo.defesa, 5].max
      alvo.vida -= dano
      atraso("#{@nome} atacou #{alvo.nome}, causando #{dano} de dano!")
    end
  
    def ataque_especial(alvo)
      if @pontos_especiais >= 5
        dano = [rand(20..35) - alvo.defesa, 0].max
        @pontos_especiais -= 5
        alvo.vida -= dano
        atraso("#{@nome} usou um ataque especial contra #{alvo.nome}, causando #{dano} de dano!")
      else
        atraso("Pontos especiais insuficientes para ataque especial!")
      end
    end
  
    def aumentar_defesa
      if @pontos_especiais >= 2
        if @defesa >= 10
          atraso("#{@nome} já está com a defesa no máximo!")
        else
          incremento = rand(1..2)
          @defesa = [@defesa + incremento, 10].min
          @pontos_especiais -= 2
          atraso("#{@nome} aumentou a defesa em #{incremento}. Defesa atual: #{@defesa}")
        end
      else
        atraso("Pontos especiais insuficientes para aumentar a defesa!")
      end
    end
  
    def curar
      if @curas_restantes > 0
        if @vida == 100
          atraso("#{@nome} já está com a vida cheia!")
        else
          cura = rand(15..30)
          vida_recuperada = [@vida + cura, 100].min - @vida
          @vida += vida_recuperada
          @curas_restantes -= 1
          atraso("#{@nome} usou uma cura e recuperou #{vida_recuperada} de vida. Vida atual: #{@vida}")
        end
      else
        atraso("Sem curas restantes!")
      end
    end
  end
  
  # Classe Inimigo
  class Inimigo < Personagem
    def inteligencia(alvo)
      if @vida <= 30 && @curas_restantes > 0
        curar
      elsif @pontos_especiais >= 5 && rand(1..3) == 1
        ataque_especial(alvo)
      elsif @pontos_especiais >= 2 && rand(1..2) == 1 && @defesa < 10
        aumentar_defesa
      else
        atacar(alvo)
      end
    end
  end
  
  # Função de batalha
  def batalha(jogador, inimigo)
    while jogador.vida > 0 && inimigo.vida > 0
      atraso ("\n--- Status de #{jogador.nome} ---")
      atraso ("Vida: #{jogador.vida} | Pontos Especiais: #{jogador.pontos_especiais} | Curas Restantes: #{jogador.curas_restantes} | Defesa: #{jogador.defesa}")
      atraso ("--- Status de #{inimigo.nome} ---")
      atraso ("Vida: #{inimigo.vida} | Pontos Especiais: #{inimigo.pontos_especiais} | Curas Restantes: #{inimigo.curas_restantes} | Defesa: #{inimigo.defesa}")
      atraso ("-----------------------------------")
  
      sleep(1)
  
      atraso ("\nÉ sua vez! Escolha uma ação:")
      puts "1. Atacar"
      puts "2. Ataque especial (5 pontos necessários)"
      puts "3. Aumentar defesa (2 pontos necessários)"
      puts "4. Curar (máximo 3 vezes)"
      print "> "
      escolha = gets.to_i
  
      case escolha
      when 1
        jogador.atacar(inimigo)
      when 2
        jogador.ataque_especial(inimigo)
      when 3
        jogador.aumentar_defesa
      when 4
        jogador.curar
      else
        atraso("Escolha inválida! Você perdeu a vez!")
      end
  
      break if inimigo.vida <= 0
  
      sleep(1)
      inimigo.inteligencia(jogador)
  
      sleep(1)
    end
  
    if jogador.vida > 0
      atraso("\n#{jogador.nome} venceu a batalha! Parabéns!")
    else
      atraso("\n#{inimigo.nome} venceu a batalha! Melhor sorte da próxima vez!")
    end
  end
  
  # Inicialização do jogo
  atraso("Bem-vindo ao RPG de Texto!")
  print "Digite o nome do seu herói: "
  nome = gets.chomp
  jogador = Personagem.new(nome, 100, 10, 3, 3)
  inimigo = Inimigo.new("Dragão", 100, 10, 3, 3)
  
  batalha(jogador, inimigo)