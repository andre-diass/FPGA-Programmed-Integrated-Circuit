áLibrary ieee; -- Importando a biblioteca
Use ieee.std_logic_1164.all; -- Pacote necessário para o STD_logic_vector

Entity Fechadura_Eletronica is -- declara a entidade
	Generic (time1: in integer :=3; -- representa o limite de tempo para que seja pressionada uma tecla
				time2: in integer :=5); -- Tempo para resetar
	Port(clk: in  STD_LOGIC; -- Define uma interface de entrada p/ o clock.
		digit: in std_logic_vector(1 to 4) := "1111"; -- definição de uma interface de entrada p/ o teclado numerico.
		LED: out std_logic := '1'); -- def. de interface de saida para o led de status( 1 = trancado; 0 = destrancada)
end Fechadura_Eletronica; -- Finaliza a entidade

Architecture behavior of Fechadura_Eletronica is -- Demarca a def. do comportamento da fechadura.
Type state_type is (s0,s1,s2,s3); -- O tipo representa os possíveis estados da máquina.
--Attribute enum_encoding: string; utilizado para simular a forma de onda p/ transformar o estado em valores sequenciais.
--Attribute enum_encoding of state_type: type is "sequencial";
Signal state, nextstate: state_type; -- declarando sinais internos que serão utilizados do estado atual e o prox. estado.
signal count: integer range 0 to 6; -- declarando o sinal interno que será utilizado para o contador.
Begin -- Inicio da def. dos comandos do programa.
Process (state, clk, digit, count) -- logica combinacional (a logica do cadeado)
Begin
	Case state is -- case do estado atual
		When S0 => -- demarca o inicio da logica quando o estado for 0.
				If (count >= time1) then -- verifica se o contador ultrapassou o limite de tempo.
				   nextstate <= S0; -- vai para o estado 0
				Else 
					if (digit = "0001") then -- verifica se o digito 1 foi inserido
						nextstate <= S1; -- Vai para o estado 1
					Else 
						nextstate <= S0;
					End if;
				End if;
		When s1 => -- Demarca o inicio da logica quando o estado for 1
				If (count >= time1) then -- verifica se o contador ultrapassou o limite de tempo.
				   nextstate <= S0; -- vai para o estado 0
				Else 
					if (digit = "0010") then -- verifica se o digito 2 foi inserido
						nextstate <= S2; -- Vai para o estado 2
					Elsif (digit = "0001") then -- verifica se o digito '1'continua sendo pressionado
						nextstate <= S1; -- vai para o estado 1.
					Else 
					nextstate <= S0; -- vai para o estado 0
					End if;
				End if;
		When s2 => -- Demarca o inicio da logica quando o estado for 2
				If (count >= time1) then -- verifica se o contador ultrapassou o limite de tempo.
				   nextstate <= S0; -- vai para o estado 0
				Else 
					if (digit = "0011") then -- verifica se o digito 3 foi inserido
						nextstate <= S3; -- Vai para o estado 3
					Elsif (digit = "0010") then -- verifica se o digito '2'continua sendo pressionado
						nextstate <= S2; -- vai para o estado 2.
					Else 
					nextstate <= S0; -- vai para o estado 0
					End if;
				End if;		
		When s3 => -- Demarca o inicio da logica quando o estado for 3
				If (count >= time2) then -- verifica se o contador é igual ao tempo para reiniciar
				   nextstate <= S0; -- vai para o estado 0
				Else 
						nextstate <= S3; -- Vai para o estado 3
				End if;
		End case; -- fim do case
	End process; -- fim do processo

Process(state) -- Processo para inserir o valor do led
Begin
	Case state is -- case do estado atual
		When S0 to S2 => LED <= '1'; -- do estado 0 até o estado 2 o LED fica ligado (trancado)
		When S3 => LED <= '0'; -- se chegar ao estado 3, o LED vai ser desligado (destrancada)
	End case; -- fim do case
End process; -- fim do processo

Process (clk, count, state) -- Logica sequencial do projeto
Begin
	If (rising_edge(clk)) then -- verifica se é uma subida do clock (valor logico 1 (alto))
		if (count >= 6) then -- verifica se count é maior ou igual a 6
			count <= 0; -- seta o count p/ 0
		Else 
		count <= count + 1; -- incrementa 1 no count
		end if;
		
	Case state is -- case do estado atual
		When S0 => -- logica do estado 0
				count <= 0; -- count vai ser sempre 0 aqui.
		When S1 => -- logica do estado 1
				if (digit /= "0010") then -- verifica se o digit é diferente de 2
					count <= 0; -- count é settado como 0
				end if;
		When S2 => -- logica do estado 2
				if (digit /= "0011") then -- verifica se o digit é diferente de 3
					count <= 0; -- count é settado como 0
				end if;
		When S3 => -- logica do estado 3
				if (count >= time2) then -- verifica se o ontador é igual ao tempo p/ reiniciar.
					count <= 0; -- count é settado como 0
				end if;
		END CASE;
		state <= nextstate; -- estado atual recebe o proximo estado.
	END IF;
end process; -- fim do programa
end behavior; -- fim da arquitetura
