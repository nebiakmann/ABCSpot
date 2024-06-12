create database abc_spot;
use abc_spot;

CREATE TABLE abc_musteriler
(
	musteri_id  	varchar(64) 	not null,
    musteri_ad		varchar(64) 	not null,
    musteri_soyad 	varchar(64) 	not null,
    musteri_tel 	varchar(25) 	not null,
    musteri_mail 	varchar(250) 	not null,
    musteri_adres 	varchar(250) 	not null,
    
    primary key(musteri_id)
);

CREATE TABLE abc_urunler
(
	urun_id			varchar(64) 	not null,
    urun_ad 		varchar(250) 	not null,
    urun_kategori 	varchar(250) 	not null,
	urun_fiyat 		float 			not null,
    urun_stok		float 			not null,
    urun_birim		varchar(16) 	not null,
    urun_detay	   	varchar(250) 	not null,
    
	primary key(urun_id)
);

CREATE TABLE abc_satislar
(
	satis_id		varchar(64) 	not null,
	musteri_id		varchar(64) 	not null,
	urun_id			varchar(64) 	not null,    
    satis_tarih 	datetime 		not null,
	satis_fiyat 	float 			not null,
    
	primary key(satis_id),
   
	foreign key(musteri_id)	references abc_musteriler(musteri_id)
		on delete cascade on update cascade,
        
	foreign key(urun_id)	references abc_urunler(urun_id)
		on delete cascade on update cascade                         
);

CREATE TABLE abc_odemeler
(
	odeme_id		varchar(64) 	not null,
	musteri_id		varchar(64) 	not null,    
    odeme_tarih 	datetime 		not null,
	odeme_tutar 	float 			not null,    
    odeme_tur 		varchar(25) 	not null,    
    odeme_aciklama	varchar(250) 	not null,
    
   primary key(odeme_id),
   
   foreign key(musteri_id) 	references abc_musteriler(musteri_id)
		on delete cascade on update cascade
);
-- -------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE abc_MusterilerHepsi ()
BEGIN
	SELECT 
		musteri_id 		as ID,
		musteri_ad 		as Adı,
		musteri_soyad 	as Soyadı,
		musteri_tel		as Telefon, 
		musteri_mail 	as Mail,
		musteri_adres 	as Adres
    FROM abc_musteriler;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE abc_MusteriEkle (
	id  	varchar(64) ,
    ad		varchar(64) ,
    soy 	varchar(64) ,
    tel 	varchar(25) ,
    mail 	varchar(250),
    adr 	varchar(250)
)
BEGIN
	INSERT INTO abc_musteriler
    VALUES 	(id, ad, soy, tel, mail, adr);
END $$
DELIMITER ;

call abc_MusteriEkle('id1', 'ad', 'soyad', 'telefon', 'mail', 'adres');
select * from abc_musteriler;

DELIMITER $$
CREATE PROCEDURE abc_MusteriGuncelle (
	id  	varchar(64) ,
    ad		varchar(64) ,
    soy 	varchar(64) ,
    tel 	varchar(25) ,
    mail 	varchar(250),
    adr 	varchar(250)
)
BEGIN
	UPDATE abc_musteriler
    SET 
		musteri_ad		= ad,
		musteri_soyad 	= soy,
		musteri_tel 	= tel,
		musteri_mail 	= mail,
		musteri_adres 	= adr
	WHERE 
    	musteri_id  	= id;
END $$
DELIMITER ;

call abc_MusteriGuncelle('id1', 'ad1', 'soyad', 'telefon', 'mail', 'adres');
select * from abc_musteriler;

DELIMITER $$
CREATE PROCEDURE abc_MusteriSil (
	id  	varchar(64) 
)
BEGIN
	DELETE FROM abc_musteriler
	WHERE  	musteri_id  = id;
END $$
DELIMITER ;

call abc_MusteriSil('id1');
select * from abc_musteriler;

DELIMITER $$
CREATE PROCEDURE abc_MusteriBul (
	filtre  varchar(32) 
)
BEGIN
	SELECT * FROM abc_musteriler
    WHERE 
    	musteri_id  	LIKE  CONCAT('%',filtre,'%') OR
		musteri_ad		LIKE  CONCAT('%',filtre,'%') OR
		musteri_soyad 	LIKE  CONCAT('%',filtre,'%') OR
		musteri_tel 	LIKE  CONCAT('%',filtre,'%') OR
		musteri_mail 	LIKE  CONCAT('%',filtre,'%') OR
		musteri_adres 	LIKE  CONCAT('%',filtre,'%');
END $$
DELIMITER ;

call abc_MusteriBul('tele');
select * from abc_musteriler;

DELIMITER $$
CREATE PROCEDURE abc_MusteriSatislar(
	id			varchar(64)  
)
BEGIN
	SELECT * FROM abc_satislar
    WHERE musteri_id = id;
END $$
DELIMITER ;

-- -------------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE abc_UrunlerHepsi ()
BEGIN
	SELECT * FROM abc_urunler;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE abc_UrunEkle (
	id			varchar(64)  ,
    ad 			varchar(250) ,
    kategori 	varchar(250) ,
	fiyat 		float		 ,
    stok		float 		 ,
    birim		varchar(16)  ,
    detay	   	varchar(250) 
)
BEGIN
	INSERT INTO abc_urunler
    VALUES 	(id, ad, kategori, fiyat, stok, birim, detay);
END $$
DELIMITER ;

call abc_UrunEkle('ur11', 'urun1', 'kat1', 123, 12, 'Adet', 'detay');
select * from abc_urunler;

DELIMITER $$
CREATE PROCEDURE abc_UrunGuncelle (
	id			varchar(64)  ,
    ad 			varchar(250) ,
    kategori 	varchar(250) ,
	fiyat 		float 	     ,
    stok		float 		 ,
    birim		varchar(16)  ,
    detay	   	varchar(250) 
)
BEGIN
	UPDATE abc_urunler
    SET 
		urun_ad 	  = ad,
		urun_kategori = kategori,
		urun_fiyat 	  = fiyat,
		urun_stok	  = stok,
		urun_birim	  = birim,
		urun_detay	  = detay
	WHERE 
    	urun_id  	  = id;
END $$
DELIMITER ;

call abc_UrunGuncelle('ur1', 'urun11', 'kat1', 123, 12, 'Adet', 'detay');
select * from abc_urunler;

DELIMITER $$
CREATE PROCEDURE abc_UrunStokGuncelle (
	id			varchar(64)  ,
    stok		float 		 
)
BEGIN
	UPDATE abc_urunler
    SET 
		urun_stok	  = stok
	WHERE 
    	urun_id  	  = id;
END $$
DELIMITER ;

call abc_UrunStokGuncelle('ur1', 13);
select * from abc_urunler;

DELIMITER $$
CREATE PROCEDURE abc_UrunSil (
	id			varchar(64)  
)
BEGIN
	DELETE FROM abc_urunler
	WHERE urun_id  = id;
END $$
DELIMITER ;

call abc_UrunSil('ur11');
select * from abc_urunler;

DELIMITER $$
CREATE PROCEDURE abc_UrunBul (
	filtre		varchar(32)
)
BEGIN
	SELECT * FROM abc_urunler
    WHERE 
    	urun_id  	  LIKE  CONCAT('%',filtre,'%') OR
		urun_ad 	  LIKE  CONCAT('%',filtre,'%') OR
		urun_kategori LIKE  CONCAT('%',filtre,'%') OR
		urun_fiyat 	  LIKE  CONCAT('%',filtre,'%') OR
		urun_stok	  LIKE  CONCAT('%',filtre,'%') OR
		urun_birim	  LIKE  CONCAT('%',filtre,'%') OR
		urun_detay	  LIKE  CONCAT('%',filtre,'%') ;
END $$
DELIMITER ;

call abc_UrunBul('ur1');
select * from abc_urunler;

DELIMITER $$
CREATE PROCEDURE abc_UrunSatislar(
	id			varchar(64)  
)
BEGIN
	SELECT * FROM abc_satislar
    WHERE urun_id = id;
END $$
DELIMITER ;

-- -----------------------------------------------------------

DELIMITER $$
CREATE PROCEDURE abc_SatisEkle (
	sid		varchar(64) ,
	mid		varchar(64) ,
	uid		varchar(64) ,    
    tarih 	datetime 	,
	fiyat 	float 		
)
BEGIN
	INSERT INTO abc_satislar
    VALUES 	(sid, mid, uid, tarih, fiyat);
END $$
DELIMITER ;

call abc_SatisEkle('sat3', 'id1', 'ur1', '2009-10-10', 120);
select * from abc_satislar;

DELIMITER $$
CREATE PROCEDURE abc_SatisGuncelle (
	sid			varchar(64),
	mid			varchar(64),
    uid 		varchar(64),
    tarih 		datetime   ,
	fiyat 		float      
)
BEGIN
	UPDATE abc_satislar
    SET 
		musteri_id    = mid,
		urun_id 	  = uid,
		satis_tarih	  = tarih,
		satis_fiyat	  = fiyat
	WHERE 
		satis_id 	  = sid;
END $$
DELIMITER ;

call abc_SatisGuncelle('sat1', 'id1', 'ur1', '2009-10-11', 120);
select * from abc_satislar;

DELIMITER $$
CREATE PROCEDURE abc_SatisSil (
	id			varchar(64)  
)
BEGIN
	DELETE FROM abc_satislar
	WHERE satis_id  = id;
END $$
DELIMITER ;

call abc_SatisSil('sat1');
select * from abc_satislar;

DELIMITER $$
CREATE PROCEDURE abc_SatisDetay (
)
BEGIN
SELECT   
		s.satis_id,
        m.musteri_id,
        u.urun_id,
        CONCAT(musteri_ad,' ', musteri_soyad ) as `Müşteri Ad Soyad`,
        urun_ad as `Ürün`,
        urun_kategori as `Kategori`,
        urun_fiyat as `Birim Fiyat`,
        satis_fiyat as `Satış Fiyatı`,
		satis_tarih as `Satış Tarihi`
FROM  	abc_musteriler m inner join  abc_satislar s 
	on m.musteri_id = s.musteri_id 
		inner join abc_urunler u on s.urun_id = u.urun_id;
END $$
DELIMITER ;

-- ------------------------------------------------------------

DELIMITER $$
CREATE PROCEDURE abc_OdemeEkle (
	oid		varchar(64) ,
	mid		varchar(64) ,   
    tarih 	datetime 	,
	tutar 	float 		,
	tur		varchar(25) ,
    aciklama varchar(250)
)
BEGIN
	INSERT INTO abc_odemeler
    VALUES 	(oid, mid, tarih, tutar, tur, aciklama);
END $$
DELIMITER ;


call abc_OdemeEkle('oid1', 'id1', '2020-01-01', 150, 'Nakit', 'Ali Elden ödeme');
select * from abc_odemeler;

DELIMITER $$
CREATE PROCEDURE abc_OdemeDetay (
)
BEGIN
SELECT   
		o.odeme_id,
        m.musteri_id,
        CONCAT(musteri_ad,' ', musteri_soyad ) as `Müşteri Ad Soyad`,
        o.odeme_tarih as `Ödeme Tarihi`,
        o.odeme_tutar as `Ödeme Tutarı`,
        o.odeme_tur as `Ödeme Türü`,
        o.odeme_aciklama as `Açıklama`
		
FROM  	abc_musteriler m inner join  abc_odemeler o 
	on m.musteri_id = o.musteri_id;
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE abc_OdemeGuncelle (
	oid		varchar(64) ,
	mid		varchar(64) ,   
    tarih 	datetime 	,
	tutar 	float 		,
	tur		varchar(25) ,
    aciklama varchar(250)
)
BEGIN
	UPDATE abc_odemeler
    SET
		musteri_id		= mid,
        odeme_tarih		= tarih,
        odeme_tutar		= tutar,
        odeme_tur		= tur,
        odeme_aciklama 	= aciklama
 	WHERE 
		odeme_id = oid; 
END $$
DELIMITER ;

call abc_OdemeGuncelle('oid1', 'id1', '2020-11-11', 150, 'Nakit', 'Ali Elden ödeme yaptı');
select * from abc_odemeler;

DELIMITER $$
CREATE PROCEDURE abc_OdemeSil (
	oid		varchar(64) 
)
BEGIN
	DELETE FROM abc_odemeler
    WHERE odeme_id = oid;
END $$
DELIMITER ;

call abc_OdemeSil('oid1');
select * from abc_odemeler;


-- -----------------------------

DELIMITER $$
CREATE PROCEDURE abc_MusteriBakiye(
	id		varchar(64)
)
BEGIN
	declare borc  float;
    declare odeme float;
    
	SELECT 	SUM(satis_fiyat) into borc  
    FROM 	abc_satislar 
    WHERE 	musteri_id = id;
    
    SELECT 	SUM(odeme_tutar) into odeme  
    FROM 	abc_odemeler 
    WHERE 	musteri_id = id;
    
    SELECT odeme - borc;
END $$
DELIMITER ;

call abc_MusteriBakiye('id1');
-- -----------------------------------------------

DELIMITER $$
CREATE PROCEDURE abc_SatislarToplam()
BEGIN
	SELECT 	SUM(satis_fiyat)  
    FROM 	abc_satislar ;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE abc_OdemelerToplam()
BEGIN
    SELECT 	SUM(odeme_tutar)  
    FROM 	abc_odemeler ;
END $$
DELIMITER ;

call abc_SatislarToplam();
call abc_OdemelerToplam();


-- Eğer satılmak istenen adet stokta yoksa satışa izin vermesin:
DELIMITER //
CREATE TRIGGER tg_stok_kontrol 
BEFORE INSERT on abc_satislar FOR EACH ROW 
BEGIN
    declare uid int;   -- ürün id
    declare stk int;   -- stok adedi
    declare adt int;   -- satılan adet

    declare hatamesaj varchar(250);

    set uid = NEW.urun_id;
    set adt = 1; -- eğer birden fazla satış yapılacaksa NEW.satis_adet kullanılabilirdi;
    
    select urun_stok into stk  
    from abc_urunler where urun_id = uid;

    IF (adt > stk )  THEN
        set hatamesaj = CONCAT('hoop! ', adt, ' satılmak isteniyor, ancak ', stk, ' adet var!');
        SIGNAL SQLSTATE '45000'  SET MESSAGE_TEXT = hatamesaj;
    END IF;
    
END; //
DELIMITER ;


-- satış eklediğimizde ürünler tablosundan stok satılan adet kadar azaltılsın 
DELIMITER //
CREATE TRIGGER tg_stok_azalt 
AFTER INSERT on abc_satislar FOR EACH ROW 
BEGIN
    declare uid int;   -- ürün id
    declare stk int;   -- stok adedi

    declare sid int;   -- satış id
    declare adt int;   -- satılan adet

    set uid = NEW.urun_id ;
    set sid = NEW.satis_id ;
    set adt = 1; -- birden fazla satılmış olsaydı NEW.adet kullanılabilirdi.;
    
    select urun_stok into stk  
    from abc_urunler where urun_id = uid;
    
    update urunler set urun_stok = urun_stok - adt 
    where urun_id = uid;

END; //
DELIMITER ;