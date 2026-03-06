drop view if exists ProducaoVideo;

-- Conteúdos que são vídeos.
create view ProducaoVideo as
select 
    Conteudo.id_conteudo    as id_video,
    Conteudo.descricao      as descricao,
    Conteudo.dataPublicacao as dataPublicacao,
    Conteudo.canal          as id_canal,
    Conteudo.propaganda     as id_propaganda,
    Producao.titulo         as titulo,
    Producao.url            as url,
    Producao.thumbnail      as thumbnail,
    Video.duracao           as duracao
from Video
join Producao on Video.id_video = Producao.id_producao
join Conteudo on Producao.id_producao = Conteudo.id_conteudo;


-- 1) Lista o nome do usuário e estado de notificação de usuários inscritos num canal específico. Exemplo, canal = ‘TechZone’.
select Usuario.nome as nome, Inscricao.notificacao as notificacaoAtivada
from Usuario
join Inscricao on Usuario.id_usuario = Inscricao.id_usuario
join Canal on Inscricao.id_canal = Canal.id_canal
where Canal.handle = 'TechZone';


-- 2) Listar vídeos longos (+10min) que usam músicas de um artista (ou banda) específica. Exemplo, artista = 'AC/DC' 
select Video.id_video, Producao.titulo as titulo_video, Musica.titulo as musica, Musica.artista 
from Video
join Producao on Video.id_video = Producao.id_producao 
join Video_Musica on Video.id_video = Video_Musica.id_video 
join Musica on Video_Musica.id_musica = Musica.id_musica
where Musica.artista = 'AC/DC' 
and Video.duracao > 600;


-- 3) Título dos conteúdos e id do canal que possuem simultaneamente tag de tecnologia e de review
select vi.titulo, vi.id_canal
from ProducaoVideo vi
join Conteudo_Tag on Conteudo_Tag.id_conteudo = vi.id_video
join Tag on Tag.id_tag = Conteudo_Tag.id_tag
where Tag.nome = 'tecnologia'
intersect 
select vi.titulo, vi.id_canal
from ProducaoVideo vi
join Conteudo_Tag on Conteudo_Tag.id_conteudo = vi.id_video
join Tag on Tag.id_tag = Conteudo_Tag.id_tag
where Tag.nome = 'review';


-- 4) Quantidade de vídeos de cada playlist do youtube
select Playlist.titulo, count(*) as quantidade_de_videos
from Playlist
join Playlist_Producao on Playlist.id_playlist = Playlist_Producao.id_playlist
join Producao on Producao.id_producao = Playlist_Producao.id_producao
join Video on Video.id_video = Producao.id_producao
group by Playlist.id_playlist, Playlist.titulo;


-- 5) Listar nome da música, artista e título do vídeo para músicas que foram usadas em apenas um vídeo.
select Musica.titulo, Musica.artista, Producao.titulo
from Musica
join Video_Musica on Musica.id_musica = Video_musica.id_musica
join Video on Video_musica.id_video = Video.id_video
join Producao on Producao.id_producao = Video.id_video
where Musica.id_musica in (
    select vm.id_musica 
    from Video_Musica vm
    group by vm.id_musica
    having count(*) = 1
);


-- 6) Seleciona a produção mais recentemente publicada por canal do youtube.
select Producao.titulo, Conteudo.dataPublicacao, Canal.handle
from Producao
join Conteudo on Producao.id_producao = Conteudo.id_conteudo
join Canal on Conteudo.canal = Canal.id_canal
where Conteudo.dataPublicacao = (
    select max(ConteudoInt.dataPublicacao)
    from Conteudo ConteudoInt
    where ConteudoInt.canal = Conteudo.canal
);


-- 7) Usuários que assistiram a conteúdos que pertencem a canais com mais de um conteúdo publicado
select distinct Usuario.nome
from Usuario
join Visualizacao on Usuario.id_usuario = Visualizacao.id_usuario
where Visualizacao.id_conteudo in (
    select id_conteudo 
    from Conteudo
    where canal in (
        select canal 
        from Conteudo
        group by canal 
        having count(*) > 1 
    )
);


-- 8) Conteúdos que receberam reações positivas de TODOS os usuários inscritos do canal
select Conteudo.id_conteudo, Conteudo.descricao
from Conteudo
where not exists (
    select *
    from Inscricao
    where Inscricao.id_canal = Conteudo.canal
      and Inscricao.id_usuario not in (
            select Reacao.id_usuario
            from Reacao
            where Reacao.id_conteudo = Conteudo.id_conteudo
              and Reacao.tipo = true
      )
);



-- 9) Soma da quantidade de visualizações de vídeos que possuam propaganda por canal (canais sem propaganda podem ser ignorados)
select Canal.handle, count(Visualizacao.id_usuario) as num_visualizacoes
from ProducaoVideo
join Canal on ProducaoVideo.id_canal = Canal.id_canal
join Visualizacao on Visualizacao.id_conteudo = ProducaoVideo.id_video
where ProducaoVideo.id_propaganda is not null
group by Canal.id_canal, Canal.handle;


-- 10) Quantidade de vídeos por canal com tag de tecnologia (canais sem vídeos com essa tag podem ser ignorados)
select Canal.handle as canal, count(ProducaoVideo.id_video) as numVideos
from Canal
join ProducaoVideo on ProducaoVideo.id_canal = Canal.id_canal
join Conteudo_Tag on Conteudo_Tag.id_conteudo = ProducaoVideo.id_video
join Tag on Tag.id_tag = Conteudo_Tag.id_tag
where Tag.nome = 'tecnologia'
group by Canal.handle;