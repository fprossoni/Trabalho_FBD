DROP TABLE IF EXISTS 
    Conteudo_Tag, Tag, Comentario, Reacao, Visualizacao, 
    Inscricao, AoVivo, Video_Musica, Musica, Legenda, Video, 
    Post, Playlist_Producao, Playlist, Producao, Conteudo, 
    Propaganda, Canal, Usuario 
CASCADE;

CREATE TABLE Usuario (
    id_usuario SERIAL PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    nascimento DATE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    pais VARCHAR(100) NOT NULL
);

CREATE TABLE Canal (
    id_canal SERIAL PRIMARY KEY,
    handle VARCHAR(100) UNIQUE NOT NULL,
    descricao TEXT,
    dataCriacao DATE NOT NULL,
    pais VARCHAR(100) NOT NULL,
    usuario INT NOT NULL REFERENCES Usuario
);

CREATE TABLE Propaganda (
    id_propaganda SERIAL PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    empresa VARCHAR(100) NOT NULL,
    siteEmpresa VARCHAR(255) NOT NULL,
    url TEXT NOT NULL UNIQUE
);

CREATE TABLE Conteudo (
    id_conteudo SERIAL PRIMARY KEY,
    descricao TEXT NOT NULL,
    dataPublicacao DATE NOT NULL,
    canal INT NOT NULL REFERENCES Canal,
    propaganda INT REFERENCES Propaganda
);

CREATE TABLE Producao (
    id_producao INT PRIMARY KEY REFERENCES Conteudo,
    titulo VARCHAR(100) NOT NULL,
    url TEXT NOT NULL,
    thumbnail TEXT NOT NULL
);

CREATE TABLE Playlist (
    id_playlist SERIAL PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    dataPublicacao DATE NOT NULL,
    privacidade BOOL NOT NULL,
    canal INT NOT NULL REFERENCES Canal
);

CREATE TABLE Playlist_Producao (
    id_playlist INT NOT NULL REFERENCES Playlist,
    id_producao INT NOT NULL REFERENCES Producao,
    PRIMARY KEY (id_playlist, id_producao)
);

CREATE TABLE Post (
    id_conteudo INT PRIMARY KEY REFERENCES Conteudo,
    texto TEXT NOT NULL,
    imagem TEXT
);

CREATE TABLE Video (
    id_video INT PRIMARY KEY REFERENCES Producao,
    duracao INT NOT NULL
);

CREATE TABLE Legenda (
    id_legenda SERIAL PRIMARY KEY,
    idioma VARCHAR(30) NOT NULL,
    traducao TEXT NOT NULL,
    id_video INT NOT NULL REFERENCES Video
);

CREATE TABLE Musica (
    id_musica SERIAL PRIMARY KEY,
    url TEXT NOT NULL UNIQUE,
    titulo VARCHAR(100) NOT NULL,
    artista VARCHAR(100) NOT NULL,
    anoLancamento DATE NOT NULL,
    duracao INT NOT NULL
);

CREATE TABLE Video_Musica (
    id_video INT NOT NULL REFERENCES Video,
    id_musica INT NOT NULL REFERENCES Musica,
    PRIMARY KEY (id_video, id_musica)
);

CREATE TABLE AoVivo (
    id_aovivo INT PRIMARY KEY REFERENCES Producao,
    duracao INT,
    espectadores INT NOT NULL,
    statusTransmissao BOOL NOT NULL
);

CREATE TABLE Inscricao (
    id_canal INT NOT NULL REFERENCES Canal,
    id_usuario INT NOT NULL REFERENCES Usuario,
    notificacao BOOL NOT NULL,
    PRIMARY KEY (id_canal, id_usuario)
);

CREATE TABLE Visualizacao (
    id_conteudo INT NOT NULL REFERENCES Conteudo,
    id_usuario INT NOT NULL REFERENCES Usuario,
    dataVisualizacao DATE NOT NULL,
    duracaoVisualizacao INT,
    PRIMARY KEY (id_conteudo, id_usuario, dataVisualizacao)
);

CREATE TABLE Reacao (
    id_conteudo INT NOT NULL REFERENCES Conteudo,
    id_usuario INT NOT NULL REFERENCES Usuario,
    dataReacao DATE NOT NULL,
    tipo BOOL NOT NULL,
    PRIMARY KEY (id_conteudo, id_usuario)
);

CREATE TABLE Comentario (
    id_comentario SERIAL PRIMARY KEY,
    conteudo TEXT NOT NULL,
    dataComentario DATE NOT NULL,
    usuario INT NOT NULL REFERENCES Usuario,
    id_comentario_resposta INT REFERENCES Comentario,
    id_conteudo INT REFERENCES Conteudo
);

CREATE TABLE Tag (
    id_tag SERIAL PRIMARY KEY,
    nome VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE Conteudo_Tag (
    id_tag INT NOT NULL REFERENCES Tag,
    id_conteudo INT NOT NULL REFERENCES Conteudo,
    PRIMARY KEY (id_tag, id_conteudo)
);