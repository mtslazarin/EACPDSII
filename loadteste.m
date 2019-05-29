%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2019.1 Sidney Volney C�ndido - Subrotina de load
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Vers�o 2 faz a m�dia das 3 medi��es 11/05
%% LEIA-ME
% Subrotina:
% 1 - Carrega o .mat das medi��es (do pytta)
% 2 - Para cada medi��o (3 fontes x 3 sinais x 5 receptores x 3 vezes = 135
% medi��es), gera um itaAudio, cujo no vetor de tempos � inserido a m�dia aritm�tica
% dos vetores de tempo de cada medi��o.
% 3 - Exporta 2 structs e 1 matriz: 1 struct de sinais de entrada, 1 struct
% com 45 itaAudios e uma matriz com a m�dia aritm�tica das temperaturas, umidades relativas e time
% stamps de cada medi��o
% OBS: As medi��es com sweep est�o com coment�rios carregando as
% informa��es de temperatura, umidade relativa e timestamp
 function [calib ent med] = loadteste(Data,MeasurementSetup)
%% Carregando Dados
    %% calib
    
        % Orelha Esquerda (Canal 1) 
        calib.ch1 = itaAudio; calib.ch1.channelUnits = {'Pa'}; calib.ch1.channelNames = {'Calibra��o orelha esquerda'};
        calib.ch1.time = Data.measuredData.calibration.OrelhaE.T0.T0.timeSignal; 
        % Orelha Direita  (Canal 2)
        calib.ch2 = itaAudio; calib.ch2.channelUnits = {'Pa'}; calib.ch2.channelNames = {'Calibra��o orelha direita'};
        calib.ch2.time = Data.measuredData.calibration.OrelhaD.T0.T0.timeSignal;         
        % Mic 1           (Canal 3)
        calib.ch3 = itaAudio; calib.ch3.channelUnits = {'Pa'}; calib.ch3.channelNames = {'Calibra��o microfone 1'};
        calib.ch3.time = Data.measuredData.calibration.Mic1.T0.T0.timeSignal;         
        % Mic 2           (Canal 4)
        calib.ch4 = itaAudio; calib.ch4.channelUnits = {'Pa'}; calib.ch4.channelNames = {'Calibra��o microfone 2'};
        calib.ch4.time = Data.measuredData.calibration.Mic2.T0.T0.timeSignal;
    %% Ru�do de Fundo
%         % Orelha Esquerda
%         noise.ch1 = itaAudio; noise.ch1.channelNames = {'Ru�do de fundo canal 1'};
%         noise.ch1.time = (Data.measuredData.noisefloor.T0.R1.T0.timeSignal(:,1)+...
%             Data.measuredData.noisefloor.T0.R1.T1.timeSignal(:,1)+...
%             Data.measuredData.noisefloor.T0.R1.T2.timeSignal(:,1))/3;
%         % Orelha Direita
%         noise.ch2 = itaAudio; noise.ch2.channelNames = {'Ru�do de fundo canal 2'};
%         noise.ch2.time = (Data.measuredData.noisefloor.T0.R1.T0.timeSignal(:,2)+...
%             Data.measuredData.noisefloor.T0.R1.T1.timeSignal(:,2)+...
%             Data.measuredData.noisefloor.T0.R1.T2.timeSignal(:,2))/3;
%         % Mic 1
%         noise.ch3 = itaAudio; noise.ch3.channelNames = {'Ru�do de fundo canal 3'};
%         noise.ch3.time = (Data.measuredData.noisefloor.T0.R1.T0.timeSignal+...
%             Data.measuredData.noisefloor.T0.R2.T1.timeSignal+...
%             Data.measuredData.noisefloor.T0.R2.T2.timeSignal)/3;
%         % Mic 2
%         noise.ch1 = itaAudio; noise.ch1.channelNames = {'Ru�do de fundo canal 4'};
%         noise.ch1.time = (Data.measuredData.noisefloor.T0.R3.T0.timeSignal+...
%             Data.measuredData.noisefloor.T0.R3.T1.timeSignal+...
%             Data.measuredData.noisefloor.T0.R3.T2.timeSignal)/3;
    %% Entradas
        % Sweep
        ent.sweep = itaAudio;              %Vetor do sweep de entrada. ItaAudio?
        ent.sweep.samplingRate = 44100;
        ent.sweep.timeData = MeasurementSetup.excitationSignals.varredura.timeSignal;             % Vetor de tempo
        ent.sweep.channelNames ={ 'Sweep de Entrada' };
        % M�sica
        ent.music = itaAudio; ent.music.samplingRate = 44100; ent.music.channelNames = {'Entrance Music'};
        ent.music.timeData = MeasurementSetup.excitationSignals.musica.timeSignal;  %Tr�s pa noix a musiquinha
        % Fala
        ent.falaney = itaAudio; ent.falaney.samplingRate = 44100; ent.falaney.channelNames = {'Fala'};
        ent.falaney.timeData = MeasurementSetup.excitationSignals.fala.timeSignal;  %lalalalalalalalalalaaaaaa faaaaaaaaalaaaaaa
    %% Sa�das (ou medi��es)   
        %% S1R1
            %% Sweep [SW] (ja � a m�dia?)
                %% Sistema Bi Auricular
                    
                med.S1R1SW.esq = itaAudio;                % ita[]
                med.S1R1SW.esq.channelNames={'S1R1-Sweep-Orelha esquerda'};
                % Carrega a informa��o do sinal no canal 1
                med.S1R1SW.esq.timeData = (Data.measuredData.S1R1.varredura.binaural.T0.timeSignal(:,1)+...
                    Data.measuredData.S1R1.varredura.binaural.T1.timeSignal(:,1)+ ...
                    Data.measuredData.S1R1.varredura.binaural.T2.timeSignal(:,1))/3;            
                med.S1R1SW.dir = itaAudio;                % ita[]

                % Carrega a informa��o do sinal no canal 2
                med.S1R1SW.dir.timeData = (Data.measuredData.S1R1.varredura.binaural.T0.timeSignal(:,2)+...
                    Data.measuredData.S1R1.varredura.binaural.T1.timeSignal(:,2)+...
                    Data.measuredData.S1R1.varredura.binaural.T2.timeSignal(:,2))/3; 
                med.S1R1SW.dir.channelNames={'S1R1-Sweep-Orelha direita'};
                % Temperatura e umidade relativa do ar, bem como a data
                med.S1R1SW.dir.comment = ['Temperatura (C�): ' num2str(Data.measuredData.S1R1.varredura.binaural.T0.temp)...
                    ' , Umidade relativa (%): ' num2str(Data.measuredData.S1R1.varredura.binaural.T0.RH)...
                    ' "time stamp" ' Data.measuredData.S1R1.varredura.binaural.T0.timeStamp ]; 
                %% Centro da cabe�a
%                 med.S1R1SW.cen = itaAudio;  med.S1R1SW.cen.time = (Data.measuredData.S1R1.varredura.hc.T0.timeSignal(:,1)+...
%                     Data.measuredData.S1R1.varredura.hc.T1.timeSignal(:,1)+...
%                     Data.measuredData.S1R1.varredura.hc.T2.timeSignal(:,1))/3;   
%                 med.S1R1SW.cen.channelNames={'S1R1-Sweep-Centro da cabe�a'};                 
            %% Music [MS]
                %% Sistema Bi Auricular
                med.S1R1MS.esq = itaAudio;      med.S1R1MS.esq.channelNames={'S1R1-M�sica-orelha esquerda'};
                med.S1R1MS.esq.timeData = (Data.measuredData.S1R1.musica.binaural.T0.timeSignal(:,1)+...
                    Data.measuredData.S1R1.musica.binaural.T1.timeSignal(:,1)+...
                    Data.measuredData.S1R1.musica.binaural.T2.timeSignal(:,1))/3;
                med.S1R1MS.dir = itaAudio;  med.S1R1MS.dir.channelNames={'S1R1-M�sica-orelha direita'};
                med.S1R1MS.dir.timeData = (Data.measuredData.S1R1.musica.binaural.T0.timeSignal(:,2)+...
                    Data.measuredData.S1R1.musica.binaural.T1.timeSignal(:,2)+...
                    Data.measuredData.S1R1.musica.binaural.T2.timeSignal(:,2))/3;                
                %% Centro da cabe�a
%                 med.S1R1MS.cen = itaAudio;  med.S1R1MS.dir.channelNames={'S1R1-M�sica-centro de cabe�a'};
%                 med.S1R1MS.cen.timeData = (Data.measuredData.S1R1.musica.hc.T0.timeSignal(:,1)+...
%                     Data.measuredData.S1R1.musica.hc.T1.timeSignal(:,1)+...
%                     Data.measuredData.S1R1.musica.hc.T2.timeSignal(:,1))/3;
            %% Falaney [FN]
                %% Sistema Bi Auricular
                med.S1R1FN.esq = itaAudio;      med.S1R1FN.esq.channelNames={'S1R1-Fala-Orelha esquerda'};
                med.S1R1FN.esq.timeData = (Data.measuredData.S1R1.fala.binaural.T0.timeSignal(:,1)+...
                    Data.measuredData.S1R1.fala.binaural.T1.timeSignal(:,1)+...
                    Data.measuredData.S1R1.fala.binaural.T2.timeSignal(:,1))/3;
                med.S1R1FN.dir = itaAudio;  med.S1R1FN.dir.channelNames={'S1R1-Fala-Orelha direita'};
                med.S1R1FN.dir.timeData = (Data.measuredData.S1R1.fala.binaural.T0.timeSignal(:,2)+...
                    Data.measuredData.S1R1.fala.binaural.T1.timeSignal(:,2)+...
                    Data.measuredData.S1R1.fala.binaural.T2.timeSignal(:,2))/3;                
                %% Centro da cabe�a
%                 med.S1R1FN.cen = itaAudio;  med.S1R1FN.dir.channelNames={'S1R1-Fala-centro de cabe�a'};
%                 med.S1R1FN.cen.timeData = (Data.measuredData.S1R1.fala.hc.T0.timeSignal(:,1)+...
%                     Data.measuredData.S1R1.fala.hc.T1.timeSignal(:,1)+...
%                     Data.measuredData.S1R1.fala.hc.T2.timeSignal(:,1))/3;        %S1R3
        %% S1R2
            %% Sweep [SW] (ja � a m�dia?)
                %% Sistema Bi Auricular
%                     
%                 med.S1R2SW.esq = itaAudio;                % ita[]
%                 med.S1R2SW.esq.channelNames={'S1R2-Sweep-Orelha esquerda'};
%                 % Carrega a informa��o do sinal no canal 1
%                 med.S1R2SW.esq.timeData = (Data.measuredData.S1R2.varredura.binaural.T0.timeSignal(:,1)+...
%                     Data.measuredData.S1R2.varredura.binaural.T1.timeSignal(:,1)+ ...
%                     Data.measuredData.S1R2.varredura.binaural.T2.timeSignal(:,1))/3;            
%                 med.S1R2SW.dir = itaAudio;                % ita[]
%                 med.S1R2SW.dir.channelNames={'S1R2-Sweep-Orelha direita'};
%                 % Carrega a informa��o do sinal no canal 2
%                 med.S1R2SW.dir.timeData = (Data.measuredData.S1R2.varredura.binaural.T0.timeSignal(:,2)+...
%                     Data.measuredData.S1R2.varredura.binaural.T1.timeSignal(:,2)+...
%                     Data.measuredData.S1R2.varredura.binaural.T2.timeSignal(:,2))/3; 
%                 % Temperatura e umidade relativa do ar, bem como a data
%                 med.S1R2SW.dir.comment = ['Temperatura (C�): ' num2str(Data.measuredData.S1R2.varredura.binaural.T0.temp)...
%                     ' , Umidade relativa (%): ' num2str(Data.measuredData.S1R2.varredura.binaural.T0.RH)...
%                     ' "time stamp" ' Data.measuredData.S1R2.varredura.binaural.T0.timeStamp ]; 
                %% Centro da cabe�a
                med.S1R2SW.cen = itaAudio;    med.S1R2SW.cen.channelNames={'S1R2-Sweep-Centro da cabe�a'};
                med.S1R2SW.cen.timeData = (Data.measuredData.S1R2.varredura.hc.T0.timeSignal(:,1)+...
                    Data.measuredData.S1R2.varredura.hc.T1.timeSignal(:,1)+...
                    Data.measuredData.S1R2.varredura.hc.T2.timeSignal(:,1))/3;            % Carrega a informa��o do sinal no canal do mic                 
            %% Music [MS]
%                 %% Sistema Bi Auricular
%                 med.S1R2MS.esq = itaAudio;      med.S1R2MS.esq.channelNames={'S1R2-M�sica-orelha esquerda'};
%                 med.S1R2MS.esq.timeData = (Data.measuredData.S1R2.musica.binaural.T0.timeSignal(:,1)+...
%                     Data.measuredData.S1R2.musica.binaural.T1.timeSignal(:,1)+...
%                     Data.measuredData.S1R2.musica.binaural.T2.timeSignal(:,1))/3;
%                 med.S1R2MS.dir = itaAudio;  med.S1R2MS.dir.channelNames={'S1R2-M�sica-orelha direita'};
%                 med.S1R2MS.dir.timeData = (Data.measuredData.S1R2.musica.binaural.T0.timeSignal(:,2)+...
%                     Data.measuredData.S1R2.musica.binaural.T1.timeSignal(:,2)+...
%                     Data.measuredData.S1R2.musica.binaural.T2.timeSignal(:,2))/3;                
                %% Centro da cabe�a
                med.S1R2MS.cen = itaAudio;  med.S1R2MS.dir.channelNames={'S1R2-M�sica-centro de cabe�a'};
                med.S1R2MS.cen.timeData = (Data.measuredData.S1R2.musica.hc.T0.timeSignal(:,1)+...
                    Data.measuredData.S1R2.musica.hc.T1.timeSignal(:,1)+...
                    Data.measuredData.S1R2.musica.hc.T2.timeSignal(:,1))/3;
            %% Falaney [FN]
%                 %% Sistema Bi Auricular
%                 med.S1R2FN.esq = itaAudio;      med.S1R2FN.esq.channelNames={'S1R2-Fala-Orelha esquerda'};
%                 med.S1R2FN.esq.timeData = (Data.measuredData.S1R2.fala.binaural.T0.timeSignal(:,1)+...
%                     Data.measuredData.S1R2.fala.binaural.T1.timeSignal(:,1)+...
%                     Data.measuredData.S1R2.fala.binaural.T2.timeSignal(:,1))/3;
%                 med.S1R2FN.dir = itaAudio;  med.S1R2FN.dir.channelNames={'S1R2-Fala-Orelha direita'};
%                 med.S1R2FN.dir.timeData = (Data.measuredData.S1R2.fala.binaural.T0.timeSignal(:,2)+...
%                     Data.measuredData.S1R2.fala.binaural.T1.timeSignal(:,2)+...
%                     Data.measuredData.S1R2.fala.binaural.T2.timeSignal(:,2))/3;                
                %% Centro da cabe�a
                med.S1R2FN.cen = itaAudio;  med.S1R2FN.dir.channelNames={'S1R2-Fala-centro de cabe�a'};
                med.S1R2FN.cen.timeData = (Data.measuredData.S1R2.fala.hc.T0.timeSignal(:,1)+...
                    Data.measuredData.S1R2.fala.hc.T1.timeSignal(:,1)+...
                    Data.measuredData.S1R2.fala.hc.T2.timeSignal(:,1))/3;           
%         %% S1R3
%             %% Sweep [SW] (ja � a m�dia?)
%                 %% Sistema Bi Auricular
%                     
%                 med.S1R3SW.esq = itaAudio;                % ita[]
%                 med.S1R3SW.esq.channelNames={'S1R3-Sweep-Orelha esquerda'};
%                 % Carrega a informa��o do sinal no canal 1
%                 med.S1R3SW.esq.timeData = (Data.measuredData.S1R3.varredura.binaural.T0.timeSignal(:,1)+...
%                     Data.measuredData.S1R3.varredura.binaural.T1.timeSignal(:,1)+ ...
%                     Data.measuredData.S1R3.varredura.binaural.T2.timeSignal(:,1))/3;            
%                 med.S1R3SW.dir = itaAudio;                % ita[]
%                 med.S1R3SW.dir.channelNames={'S1R3-Sweep-Orelha direita'};
%                 % Carrega a informa��o do sinal no canal 2
%                 med.S1R3SW.dir.timeData = (Data.measuredData.S1R3.varredura.binaural.T0.timeSignal(:,2)+...
%                     Data.measuredData.S1R3.varredura.binaural.T1.timeSignal(:,2)+...
%                     Data.measuredData.S1R3.varredura.binaural.T2.timeSignal(:,2))/3; 
%                 % Temperatura e umidade relativa do ar, bem como a data
%                 med.S1R3SW.dir.comment = ['Temperatura (C�): ' num2str(Data.measuredData.S1R3.varredura.binaural.T0.temp)...
%                     ' , Umidade relativa (%): ' num2str(Data.measuredData.S1R3.varredura.binaural.T0.RH)...
%                     ' "time stamp" ' Data.measuredData.S1R3.varredura.binaural.T0.timeStamp ]; 
%                 %% Centro da cabe�a
%                 med.S1R3SW.cen = itaAudio;    med.S1R3SW.cen.channelNames={'S1R3-Sweep-Centro da cabe�a'};
%                 med.S1R3SW.cen.timeData = (Data.measuredData.S1R3.varredura.hc.T0.timeSignal(:,1)+...
%                     Data.measuredData.S1R3.varredura.hc.T1.timeSignal(:,1)+...
%                     Data.measuredData.S1R3.varredura.hc.T2.timeSignal(:,1))/3;            % Carrega a informa��o do sinal no canal do mic                 
%             %% Music [MS]
%                 %% Sistema Bi Auricular
%                 med.S1R3MS.esq = itaAudio;      med.S1R3MS.esq.channelNames={'S1R3-M�sica-orelha esquerda'};
%                 med.S1R3MS.esq.timeData = (Data.measuredData.S1R3.musica.binaural.T0.timeSignal(:,1)+...
%                     Data.measuredData.S1R3.musica.binaural.T1.timeSignal(:,1)+...
%                     Data.measuredData.S1R3.musica.binaural.T2.timeSignal(:,1))/3;
%                 med.S1R3MS.dir = itaAudio;  med.S1R3MS.dir.channelNames={'S1R3-M�sica-orelha direita'};
%                 med.S1R3MS.dir.timeData = (Data.measuredData.S1R3.musica.binaural.T0.timeSignal(:,2)+...
%                     Data.measuredData.S1R3.musica.binaural.T1.timeSignal(:,2)+...
%                     Data.measuredData.S1R3.musica.binaural.T2.timeSignal(:,2))/3;                
%                 %% Centro da cabe�a
%                 med.S1R3MS.cen = itaAudio;  med.S1R3MS.dir.channelNames={'S1R3-M�sica-centro de cabe�a'};
%                 med.S1R3MS.cen.timeData = (Data.measuredData.S1R3.musica.hc.T0.timeSignal(:,1)+...
%                     Data.measuredData.S1R3.musica.hc.T1.timeSignal(:,1)+...
%                     Data.measuredData.S1R3.musica.hc.T2.timeSignal(:,1))/3;
%             %% Falaney [FN]
%                 %% Sistema Bi Auricular
%                 med.S1R3FN.esq = itaAudio;      med.S1R3FN.esq.channelNames={'S1R3-Fala-Orelha esquerda'};
%                 med.S1R3FN.esq.timeData = (Data.measuredData.S1R3.fala.binaural.T0.timeSignal(:,1)+...
%                     Data.measuredData.S1R3.fala.binaural.T1.timeSignal(:,1)+...
%                     Data.measuredData.S1R3.fala.binaural.T2.timeSignal(:,1))/3;
%                 med.S1R3FN.dir = itaAudio;  med.S1R3FN.dir.channelNames={'S1R3-Fala-Orelha direita'};
%                 med.S1R3FN.dir.timeData = (Data.measuredData.S1R3.fala.binaural.T0.timeSignal(:,2)+...
%                     Data.measuredData.S1R3.fala.binaural.T1.timeSignal(:,2)+...
%                     Data.measuredData.S1R3.fala.binaural.T2.timeSignal(:,2))/3;                
%                 %% Centro da cabe�a
%                 med.S1R3FN.cen = itaAudio;  med.S1R3FN.dir.channelNames={'S1R3-Fala-centro de cabe�a'};
%                 med.S1R3FN.cen.timeData = (Data.measuredData.S1R3.fala.hc.T0.timeSignal(:,1)+...
%                     Data.measuredData.S1R3.fala.hc.T1.timeSignal(:,1)+...
%                     Data.measuredData.S1R3.fala.hc.T2.timeSignal(:,1))/3;        %S1R3
%      
        %% S2R1
            %% Sweep [SW] (ja � a m�dia?)
                %% Sistema Bi Auricular
                    
                med.S2R1SW.esq = itaAudio;                % ita[]
                med.S2R1SW.esq.channelNames={'S2R1-Sweep-Orelha esquerda'};
                % Carrega a informa��o do sinal no canal 1
                med.S2R1SW.esq.timeData = (Data.measuredData.S2R1.varredura.binaural.T0.timeSignal(:,1)+...
                    Data.measuredData.S2R1.varredura.binaural.T1.timeSignal(:,1)+ ...
                    Data.measuredData.S2R1.varredura.binaural.T2.timeSignal(:,1))/3;            
                med.S2R1SW.dir = itaAudio;                % ita[]
                med.S2R1SW.dir.channelNames={'S2R1-Sweep-Orelha direita'};
                % Carrega a informa��o do sinal no canal 2
                med.S2R1SW.dir.timeData = (Data.measuredData.S2R1.varredura.binaural.T0.timeSignal(:,2)+...
                    Data.measuredData.S2R1.varredura.binaural.T1.timeSignal(:,2)+...
                    Data.measuredData.S2R1.varredura.binaural.T2.timeSignal(:,2))/3; 
                % Temperatura e umidade relativa do ar, bem como a data
                med.S2R1SW.dir.comment = ['Temperatura (C�): ' num2str(Data.measuredData.S2R1.varredura.binaural.T0.temp)...
                    ' , Umidade relativa (%): ' num2str(Data.measuredData.S2R1.varredura.binaural.T0.RH)...
                    ' "time stamp" ' Data.measuredData.S2R1.varredura.binaural.T0.timeStamp ]; 
%                 %% Centro da cabe�a
%                 med.S2R1SW.cen = itaAudio;    med.S2R1SW.cen.channelNames={'S2R1-Sweep-Centro da cabe�a'};
%                 med.S2R1SW.cen.timeData = (Data.measuredData.S2R1.varredura.hc.T0.timeSignal(:,1)+...
%                     Data.measuredData.S2R1.varredura.hc.T1.timeSignal(:,1)+...
%                     Data.measuredData.S2R1.varredura.hc.T2.timeSignal(:,1))/3;            % Carrega a informa��o do sinal no canal do mic                 
            %% Music [MS]
                %% Sistema Bi Auricular
                med.S2R1MS.esq = itaAudio;      med.S2R1MS.esq.channelNames={'S2R1-M�sica-orelha esquerda'};
                med.S2R1MS.esq.timeData = (Data.measuredData.S2R1.musica.binaural.T0.timeSignal(:,1)+...
                    Data.measuredData.S2R1.musica.binaural.T1.timeSignal(:,1)+...
                    Data.measuredData.S2R1.musica.binaural.T2.timeSignal(:,1))/3;
                med.S2R1MS.dir = itaAudio;  med.S2R1MS.dir.channelNames={'S2R1-M�sica-orelha direita'};
                med.S2R1MS.dir.timeData = (Data.measuredData.S2R1.musica.binaural.T0.timeSignal(:,2)+...
                    Data.measuredData.S2R1.musica.binaural.T1.timeSignal(:,2)+...
                    Data.measuredData.S2R1.musica.binaural.T2.timeSignal(:,2))/3;                
%                 %% Centro da cabe�a
%                 med.S2R1MS.cen = itaAudio;  med.S2R1MS.dir.channelNames={'S2R1-M�sica-centro de cabe�a'};
%                 med.S2R1MS.cen.timeData = (Data.measuredData.S2R1.musica.hc.T0.timeSignal(:,1)+...
%                     Data.measuredData.S2R1.musica.hc.T1.timeSignal(:,1)+...
%                     Data.measuredData.S2R1.musica.hc.T2.timeSignal(:,1))/3;
            %% Falaney [FN]
                %% Sistema Bi Auricular
                med.S2R1FN.esq = itaAudio;      med.S2R1FN.esq.channelNames={'S2R1-Fala-Orelha esquerda'};
                med.S2R1FN.esq.timeData = (Data.measuredData.S2R1.fala.binaural.T0.timeSignal(:,1)+...
                    Data.measuredData.S2R1.fala.binaural.T1.timeSignal(:,1)+...
                    Data.measuredData.S2R1.fala.binaural.T2.timeSignal(:,1))/3;
                med.S2R1FN.dir = itaAudio;  med.S2R1FN.dir.channelNames={'S2R1-Fala-Orelha direita'};
                med.S2R1FN.dir.timeData = (Data.measuredData.S2R1.fala.binaural.T0.timeSignal(:,2)+...
                    Data.measuredData.S2R1.fala.binaural.T1.timeSignal(:,2)+...
                    Data.measuredData.S2R1.fala.binaural.T2.timeSignal(:,2))/3;                
%                 %% Centro da cabe�a
%                 med.S2R1FN.cen = itaAudio;  med.S2R1FN.dir.channelNames={'S2R1-Fala-centro de cabe�a'};
%                 med.S2R1FN.cen.timeData = (Data.measuredData.S2R1.fala.hc.T0.timeSignal(:,1)+...
%                     Data.measuredData.S2R1.fala.hc.T1.timeSignal(:,1)+...
%                     Data.measuredData.S2R1.fala.hc.T2.timeSignal(:,1))/3;             
        %% S2R2
            %% Sweep [SW] (ja � a m�dia?)
%                 %% Sistema Bi Auricular
%                     
%                 med.S2R2SW.esq = itaAudio;                % ita[]
%                 med.S2R2SW.esq.channelNames={'S2R2-Sweep-Orelha esquerda'};
%                 % Carrega a informa��o do sinal no canal 1
%                 med.S2R2SW.esq.timeData = (Data.measuredData.S2R2.varredura.binaural.T0.timeSignal(:,1)+...
%                     Data.measuredData.S2R2.varredura.binaural.T1.timeSignal(:,1)+ ...
%                     Data.measuredData.S2R2.varredura.binaural.T2.timeSignal(:,1))/3;            
%                 med.S2R2SW.dir = itaAudio;                % ita[]
%                 med.S2R2SW.dir.channelNames={'S2R2-Sweep-Orelha direita'};
%                 % Carrega a informa��o do sinal no canal 2
%                 med.S2R2SW.dir.timeData = (Data.measuredData.S2R2.varredura.binaural.T0.timeSignal(:,2)+...
%                     Data.measuredData.S2R2.varredura.binaural.T1.timeSignal(:,2)+...
%                     Data.measuredData.S2R2.varredura.binaural.T2.timeSignal(:,2))/3; 
%                 % Temperatura e umidade relativa do ar, bem como a data
%                 med.S2R2SW.dir.comment = ['Temperatura (C�): ' num2str(Data.measuredData.S2R2.varredura.binaural.T0.temp)...
%                     ' , Umidade relativa (%): ' num2str(Data.measuredData.S2R2.varredura.binaural.T0.RH)...
%                     ' "time stamp" ' Data.measuredData.S2R2.varredura.binaural.T0.timeStamp ]; 
                %% Centro da cabe�a
                med.S2R2SW.cen = itaAudio;    med.S2R2SW.cen.channelNames={'S2R2-Sweep-Centro da cabe�a'};
                med.S2R2SW.cen.timeData = (Data.measuredData.S2R2.varredura.hc.T0.timeSignal(:,1)+...
                    Data.measuredData.S2R2.varredura.hc.T1.timeSignal(:,1)+...
                    Data.measuredData.S2R2.varredura.hc.T2.timeSignal(:,1))/3;            % Carrega a informa��o do sinal no canal do mic                 
            %% Music [MS]
%                 %% Sistema Bi Auricular
%                 med.S2R2MS.esq = itaAudio;      med.S2R2MS.esq.channelNames={'S2R2-M�sica-orelha esquerda'};
%                 med.S2R2MS.esq.timeData = (Data.measuredData.S2R2.musica.binaural.T0.timeSignal(:,1)+...
%                     Data.measuredData.S2R2.musica.binaural.T1.timeSignal(:,1)+...
%                     Data.measuredData.S2R2.musica.binaural.T2.timeSignal(:,1))/3;
%                 med.S2R2MS.dir = itaAudio;  med.S2R2MS.dir.channelNames={'S2R2-M�sica-orelha direita'};
%                 med.S2R2MS.dir.timeData = (Data.measuredData.S2R2.musica.binaural.T0.timeSignal(:,2)+...
%                     Data.measuredData.S2R2.musica.binaural.T1.timeSignal(:,2)+...
%                     Data.measuredData.S2R2.musica.binaural.T2.timeSignal(:,2))/3;                
                %% Centro da cabe�a
                med.S2R2MS.cen = itaAudio;  med.S2R2MS.dir.channelNames={'S2R2-M�sica-centro de cabe�a'};
                med.S2R2MS.cen.timeData = (Data.measuredData.S2R2.musica.hc.T0.timeSignal(:,1)+...
                    Data.measuredData.S2R2.musica.hc.T1.timeSignal(:,1)+...
                    Data.measuredData.S2R2.musica.hc.T2.timeSignal(:,1))/3;
            %% Falaney [FN]
%                 %% Sistema Bi Auricular
%                 med.S2R2FN.esq = itaAudio;      med.S2R2FN.esq.channelNames={'S2R2-Fala-Orelha esquerda'};
%                 med.S2R2FN.esq.timeData = (Data.measuredData.S2R2.fala.binaural.T0.timeSignal(:,1)+...
%                     Data.measuredData.S2R2.fala.binaural.T1.timeSignal(:,1)+...
%                     Data.measuredData.S2R2.fala.binaural.T2.timeSignal(:,1))/3;
%                 med.S2R2FN.dir = itaAudio;  med.S2R2FN.dir.channelNames={'S2R2-Fala-Orelha direita'};
%                 med.S2R2FN.dir.timeData = (Data.measuredData.S2R2.fala.binaural.T0.timeSignal(:,2)+...
%                     Data.measuredData.S2R2.fala.binaural.T1.timeSignal(:,2)+...
%                     Data.measuredData.S2R2.fala.binaural.T2.timeSignal(:,2))/3;                
                %% Centro da cabe�a
                med.S2R2FN.cen = itaAudio;  med.S2R2FN.dir.channelNames={'S2R2-Fala-centro de cabe�a'};
                med.S2R2FN.cen.timeData = (Data.measuredData.S2R2.fala.hc.T0.timeSignal(:,1)+...
                    Data.measuredData.S2R2.fala.hc.T1.timeSignal(:,1)+...
                    Data.measuredData.S2R2.fala.hc.T2.timeSignal(:,1))/3;       
        %% S2R3
%             %% Sweep [SW] (ja � a m�dia?)
%                 %% Sistema Bi Auricular
%                     
%                 med.S2R3SW.esq = itaAudio;                % ita[]
%                 med.S2R3SW.esq.channelNames={'S2R3-Sweep-Orelha esquerda'};
%                 % Carrega a informa��o do sinal no canal 1
%                 med.S2R3SW.esq.timeData = (Data.measuredData.S2R3.varredura.binaural.T0.timeSignal(:,1)+...
%                     Data.measuredData.S2R3.varredura.binaural.T1.timeSignal(:,1)+ ...
%                     Data.measuredData.S2R3.varredura.binaural.T2.timeSignal(:,1))/3;            
%                 med.S2R3SW.dir = itaAudio;                % ita[]
%                 med.S2R3SW.dir.channelNames={'S2R3-Sweep-Orelha direita'};
%                 % Carrega a informa��o do sinal no canal 2
%                 med.S2R3SW.dir.timeData = (Data.measuredData.S2R3.varredura.binaural.T0.timeSignal(:,2)+...
%                     Data.measuredData.S2R3.varredura.binaural.T1.timeSignal(:,2)+...
%                     Data.measuredData.S2R3.varredura.binaural.T2.timeSignal(:,2))/3; 
%                 % Temperatura e umidade relativa do ar, bem como a data
%                 med.S2R3SW.dir.comment = ['Temperatura (C�): ' num2str(Data.measuredData.S2R3.varredura.binaural.T0.temp)...
%                     ' , Umidade relativa (%): ' num2str(Data.measuredData.S2R3.varredura.binaural.T0.RH)...
%                     ' "time stamp" ' Data.measuredData.S2R3.varredura.binaural.T0.timeStamp ]; 
%                 %% Centro da cabe�a
%                 med.S2R3SW.cen = itaAudio;    med.S2R3SW.cen.channelNames={'S2R3-Sweep-Centro da cabe�a'};
%                 med.S2R3SW.cen.timeData = (Data.measuredData.S2R3.varredura.hc.T0.timeSignal(:,1)+...
%                     Data.measuredData.S2R3.varredura.hc.T1.timeSignal(:,1)+...
%                     Data.measuredData.S2R3.varredura.hc.T2.timeSignal(:,1))/3;            % Carrega a informa��o do sinal no canal do mic                 
%             %% Music [MS]
%                 %% Sistema Bi Auricular
%                 med.S2R3MS.esq = itaAudio;      med.S2R3MS.esq.channelNames={'S2R3-M�sica-orelha esquerda'};
%                 med.S2R3MS.esq.timeData = (Data.measuredData.S2R3.musica.binaural.T0.timeSignal(:,1)+...
%                     Data.measuredData.S2R3.musica.binaural.T1.timeSignal(:,1)+...
%                     Data.measuredData.S2R3.musica.binaural.T2.timeSignal(:,1))/3;
%                 med.S2R3MS.dir = itaAudio;  med.S2R3MS.dir.channelNames={'S2R3-M�sica-orelha direita'};
%                 med.S2R3MS.dir.timeData = (Data.measuredData.S2R3.musica.binaural.T0.timeSignal(:,2)+...
%                     Data.measuredData.S2R3.musica.binaural.T1.timeSignal(:,2)+...
%                     Data.measuredData.S2R3.musica.binaural.T2.timeSignal(:,2))/3;                
%                 %% Centro da cabe�a
%                 med.S2R3MS.cen = itaAudio;  med.S2R3MS.dir.channelNames={'S2R3-M�sica-centro de cabe�a'};
%                 med.S2R3MS.cen.timeData = (Data.measuredData.S2R3.musica.hc.T0.timeSignal(:,1)+...
%                     Data.measuredData.S2R3.musica.hc.T1.timeSignal(:,1)+...
%                     Data.measuredData.S2R3.musica.hc.T2.timeSignal(:,1))/3;
%             %% Falaney [FN]
%                 %% Sistema Bi Auricular
%                 med.S2R3FN.esq = itaAudio;      med.S2R3FN.esq.channelNames={'S2R3-Fala-Orelha esquerda'};
%                 med.S2R3FN.esq.timeData = (Data.measuredData.S2R3.fala.binaural.T0.timeSignal(:,1)+...
%                     Data.measuredData.S2R3.fala.binaural.T1.timeSignal(:,1)+...
%                     Data.measuredData.S2R3.fala.binaural.T2.timeSignal(:,1))/3;
%                 med.S2R3FN.dir = itaAudio;  med.S2R3FN.dir.channelNames={'S2R3-Fala-Orelha direita'};
%                 med.S2R3FN.dir.timeData = (Data.measuredData.S2R3.fala.binaural.T0.timeSignal(:,2)+...
%                     Data.measuredData.S2R3.fala.binaural.T1.timeSignal(:,2)+...
%                     Data.measuredData.S2R3.fala.binaural.T2.timeSignal(:,2))/3;                
%                 %% Centro da cabe�a
%                 med.S2R3FN.cen = itaAudio;  med.S2R3FN.dir.channelNames={'S2R3-Fala-centro de cabe�a'};
%                 med.S2R3FN.cen.timeData = (Data.measuredData.S2R3.fala.hc.T0.timeSignal(:,1)+...
%                     Data.measuredData.S2R3.fala.hc.T1.timeSignal(:,1)+...
%                     Data.measuredData.S2R3.fala.hc.T2.timeSignal(:,1))/3;
                %% Centro da cabe�a
                med.S3R2SW.cen = itaAudio;    med.S3R2SW.cen.channelNames={'S3R2-Sweep-Centro da cabe�a'};
                med.S3R2SW.cen.timeData = (Data.measuredData.S3R2.varredura.hc.T0.timeSignal(:,1)+...
                    Data.measuredData.S3R2.varredura.hc.T1.timeSignal(:,1)+...
                    Data.measuredData.S3R2.varredura.hc.T2.timeSignal(:,1))/3;            % Carrega a informa��o do sinal no canal do mic                 

%           
 end
    
    