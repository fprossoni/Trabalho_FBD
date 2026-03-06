TRUNCATE TABLE 
    Conteudo_Tag,
    Tag,
    Comentario,
    Reacao,
    Visualizacao,
    Inscricao,
    AoVivo,
    Video_Musica,
    Musica,
    Legenda,
    Video,
    Post,
    Playlist_Producao,
    Playlist,
    Producao,
    Conteudo,
    Propaganda,
    Canal,
    Usuario
RESTART IDENTITY CASCADE;

-- Usuarios
INSERT INTO Usuario (email, nome, nascimento, senha, pais) VALUES
('ana@email.com', 'Ana Silva', '1990-05-10', 'senha1', 'Brasil'),
('bruno@email.com', 'Bruno Souza', '1995-03-12', 'senha2', 'Brasil'),
('carla@email.com', 'Carla Dias', '1999-07-22', 'senha3', 'EUA'),
('davi@email.com', 'Davi Costa', '2000-11-01', 'senha4', 'França');

-- Canais
INSERT INTO Canal (handle, descricao, dataCriacao, pais, usuario) VALUES
('TechZone', 'Canal de tecnologia e reviews', '2020-02-01', 'Brasil', 1),
('MusicVibes', 'Canal de música e cultura pop', '2019-06-15', 'EUA', 3),
('DailyNews', 'Notícias diárias do mundo', '2021-04-10', 'França', 4),
('BrasilNoticias', 'Canal de noticias brasileiro', '2016-02-02', 'Brasil', 1);

-- Inscrições
INSERT INTO Inscricao (id_canal, id_usuario, notificacao) VALUES
(1, 1, TRUE), (1, 2, TRUE), (2, 3, FALSE), (1, 4, TRUE), (4, 1, TRUE);

-- Propagandas
INSERT INTO Propaganda (titulo, empresa, siteEmpresa, url) VALUES
('Promoção Verão', 'Coca-Cola', 'https://www.cocacola.com', 'https://ads/coca1'),
('Headphones X', 'Sony', 'https://www.sony.com', 'https://ads/sony1');

-- Conteúdos
INSERT INTO Conteudo (descricao, dataPublicacao, canal, propaganda) VALUES
('Review de notebook', '2022-01-10', 1, 1),
('Lançamento de smartphone', '2022-02-20', 1, 2),
('Top 10 músicas 2023', '2023-03-05', 2, 2),
('Notícias do dia', '2023-04-01', 3, 1),
('Análise de placa de vídeo', '2023-05-10', 1, 1),
('Cobertura de evento tech', '2023-06-20', 1, NULL),
('Playlist de rock', '2023-07-15', 2, NULL),
('Urgente: notícia internacional', '2023-07-16', 3, 1),
('Boletim da manhã', '2023-07-17', 4, NULL),
('Notícias de economia', '2023-07-18', 4, 2);

-- Produções
INSERT INTO Producao (id_producao, titulo, url, thumbnail) VALUES
(1, 'Review de notebook', 'https://techzone/review', 'https://img/thumb1'),
(2, 'Lançamento de smartphone', 'https://techzone/smart', 'https://img/thumb2'),
(3, 'Top 10 músicas', 'https://music/top10', 'https://img/thumb3'),
(4, 'Notícias do dia', 'https://daily/news1', 'https://img/news1'),
(5, 'Análise de placa de vídeo', 'https://techzone/gpu', 'https://img/gpu'),
(6, 'Cobertura de evento tech', 'https://techzone/event', 'https://img/event'),
(7, 'Playlist de rock', 'https://music/rock', 'https://img/rock'),
(8, 'Urgente: notícia internacional', 'https://daily/urgent', 'https://img/urgent'),
(9, 'Boletim da manhã', 'https://brasilnews/morning', 'https://img/morning'),
(10, 'Notícias de economia', 'https://brasilnews/economy', 'https://img/economy');

-- Vídeos
INSERT INTO Video (id_video, duracao) VALUES
(1, 720), (2, 600), (3, 510),(4, 300), (5, 900), (6, 760), (7, 500), (8, 450), (9, 350), (10, 400);

-- Músicas
INSERT INTO Musica (url, titulo, artista, anoLancamento, duracao) VALUES
('https://music/track1', 'Homecoming', 'Kanye West', '2008-02-02', 203),
('https://music/track2', 'T.N.T.', 'AC/DC', '1976-03-01', 215),
('https://music/track3', 'Stronger', 'Kanye West', '2007-07-31', 312),
('https://music/track4', 'Back in Black', 'AC/DC', '1980-07-25', 255),
('https://music/track5', 'Yellow', 'Coldplay', '2000-06-26', 260);

-- Associação vídeo–música
INSERT INTO Video_Musica (id_video, id_musica) VALUES 
(1, 2), (1, 4),
(2, 1), (2, 5), 
(4,3),(4,1),
(5, 1), (5, 4), (5, 5),
(6,4),
(7,2),(7, 5);

-- Visualizações
INSERT INTO Visualizacao (id_conteudo, id_usuario, dataVisualizacao, duracaoVisualizacao) VALUES
(1, 1, '2023-05-01', 600),(1, 2, '2023-05-03', 480),
(2, 1, '2023-06-01', 540),
(3, 3, '2023-06-10', 420),
(4, 1, '2023-08-01', 250),(4, 2, '2023-08-02', 280),
(5, 1, '2023-08-03', 700),(5, 2, '2023-08-04', 820),
(6, 3, '2023-08-05', 600),(6, 4, '2023-08-06', 760),
(7, 3, '2023-08-07', 490),(7, 1, '2023-08-07', 480),
(8, 4, '2023-08-08', 440),
(9, 1, '2023-08-09', 330),(9, 2, '2023-08-09', 340),
(10, 1, '2023-08-10', 380),(10, 3, '2023-08-10', 390);

-- Reações
INSERT INTO Reacao (id_conteudo, id_usuario, dataReacao, tipo) VALUES
(1, 1, '2023-05-01', TRUE),(1, 2, '2023-05-03', TRUE),
(2, 1, '2023-06-01', FALSE),
(3, 3, '2023-06-10', TRUE),
(4, 1, '2023-08-01', TRUE),(4, 2, '2023-08-02', TRUE),
(5, 1, '2023-08-03', TRUE),(5, 2, '2023-08-04', FALSE),
(6, 3, '2023-08-05', TRUE),(6, 4, '2023-08-06', TRUE),
(7, 3, '2023-08-07', TRUE),(7, 1, '2023-08-07', TRUE),
(8, 4, '2023-08-08', FALSE),
(9, 1, '2023-08-09', TRUE),(9, 2, '2023-08-09', TRUE),
(10, 1, '2023-08-10', TRUE),(10, 3, '2023-08-10', FALSE);

-- Tags
INSERT INTO Tag (nome) VALUES
('tecnologia'),
('musica'),
('noticias'),
('economia'),
('review'),
('rock'),
('internacional'),
('smartphone'),
('gpu'),
('evento');

-- Conteudo_Tag
INSERT INTO Conteudo_Tag (id_tag, id_conteudo) VALUES
(1, 1), (1, 2), (1, 5), (1, 6),(1,8),
(2, 3), (2, 7),
(3, 4), (3, 9),
(4, 10),
(5, 1),
(6, 3), (6, 7),
(7, 8),
(8, 2),
(9, 5),
(10, 6);

-- Playlists
INSERT INTO Playlist (titulo, descricao, dataPublicacao, privacidade, canal) VALUES
('Tech Reviews', 'Playlist de análises tecnológicas', '2023-08-01', FALSE, 1),
('Músicas Favoritas', 'Coletânea de músicas populares', '2023-08-02', FALSE, 2),
('Notícias Importantes', 'Principais notícias da semana', '2023-08-03', TRUE, 3),
('Compilado Brasil', 'Seleção de conteúdos brasileiros', '2023-08-04', FALSE, 4),
('Rock Hits', 'Playlist com produções de rock', '2023-08-05', FALSE, 2),
('Technology Deep Dive', 'Conteúdos sobre hardware e eventos', '2023-08-06', TRUE, 1);

-- Playlist_Producao
INSERT INTO Playlist_Producao (id_playlist, id_producao) VALUES
(1, 1), (1, 2), (1, 5), (1, 6),
(2, 3), (2, 7),
(3, 4), (3, 8), (3, 10),
(4, 9), (4, 1),
(5, 7), (5, 3),
(6, 5), (6, 6), (6, 8);
