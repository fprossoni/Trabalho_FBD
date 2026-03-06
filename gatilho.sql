-- Gatilho para impedir vídeo duplicado em uma playlist
--   Garantir que uma playlist nunca contenha o mesmo vídeo
--   duas vezes, a partir da verificação da existência da 
--   da tupla (id_playlist, id_conteudo) previamente.
-- ===============================================================

CREATE OR REPLACE PROCEDURE check_video_repetido(
    IN p_playlist INT,
    IN p_producao INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (
        SELECT *
        FROM Playlist_Producao
        WHERE id_playlist = p_playlist
          AND id_producao = p_producao
    ) THEN
        RAISE EXCEPTION 'Este vídeo já está na playlist.';
    END IF;
END;
$$;

-- Trigger function
CREATE OR REPLACE FUNCTION chama_check_video()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    CALL check_video_repetido(NEW.id_playlist, NEW.id_producao);
    RETURN NEW;
END;
$$;

-- Trigger
CREATE TRIGGER tg_playlist_video
BEFORE INSERT ON Playlist_Producao
FOR EACH ROW
EXECUTE FUNCTION chama_check_video();