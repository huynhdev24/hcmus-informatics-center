----------------------------------------
---QUAN LY TRUNG TAM TIN HOC HCMUS------

------------ NHOM 06 ---------------------
------ 18120606 - Tran Thi Trang ---------
---- 18120609 - Ho Khac Minh Tri ---------
-- 18120634 - Nguyen Le Anh Tuan ---------
------------------------------------------

USE [master]
GO
CREATE DATABASE QLTTTH_HCMUS
GO
USE QLTTTH_HCMUS
GO

-------------- TAO BANG --------------
-- 1) BANG NGUOI DUNG
CREATE TABLE NGUOI_DUNG (
	MA_ND           VARCHAR(20) PRIMARY KEY,
	HO_TEN          NVARCHAR(50) NOT NULL,
	TUOI            INT NOT NULL CHECK ( TUOI > 15 ),
	GIOI_TINH       SMALLINT NOT NULL DEFAULT(0), -- 0: NAM, 1: NU
	DIA_CHI         NVARCHAR(150) NOT NULL,
	SDT             CHAR(11)     NOT NULL,
	AVATAR	VARCHAR(200),
	LOAI_NGUOI_DUNG SMALLINT  NOT NULL DEFAULT(1),-- 0: NHAN VIEN 1: HOC VIEN
	)

GO
-- 2) BANG TAI KHOAN
CREATE TABLE TAI_KHOAN (
	USERNAME         VARCHAR(20) PRIMARY KEY,
	EMAIL           VARCHAR(100)  NOT NULL,
	MAT_KHAU         VARCHAR(50) NOT NULL,
	NGAY_TAO         DATETIME NOT NULL DEFAULT(GETDATE()),
	SO_LAN_DANG_NHAP_SAI SMALLINT NOT NULL DEFAULT(0),
	CONSTRAINT UN_EMAIL UNIQUE(EMAIL) 
	)

GO
-- 3) BANG NHAN VIEN
CREATE TABLE NHAN_VIEN (
	MA_NV          VARCHAR(20) PRIMARY KEY,
	LOAI_NV        SMALLINT NOT NULL DEFAULT(0),
	CHUYEN_MON SMALLINT NOT NULL
	)

GO
-- 4) BANG KHACH HANG 
CREATE TABLE KHACH_HANG (
	MA_KH           VARCHAR(20) PRIMARY KEY,
	HO_TEN_KH       NVARCHAR(50) NOT NULL,
	EMAIL           VARCHAR(50)  NOT NULL,
	SDT             CHAR(11)     NOT NULL,
	MA_NV           VARCHAR(20)  NOT NULL
	)

GO
-- 5) BANG PHONG HOC
CREATE TABLE PHONG_HOC (
	MA_PHONG  VARCHAR(10) PRIMARY KEY,
	TEN_PHONG  NVARCHAR(20) NOT NULL,
	SL_HV_TOI_DA  INT NOT NULL DEFAULT(0)
	)

GO
-- 6) BANG PHONG THI
CREATE TABLE PHONG_THI (
	MA_PT   VARCHAR(10) PRIMARY KEY,
	MA_PHONG VARCHAR(10) NOT NULL,
	MA_MH    VARCHAR(10) NOT NULL,
	THOI_GIAN_THI DATETIME NOT NULL DEFAULT(GETDATE()),
	)

GO
-- 7) BANG BAI KIEM TRA
CREATE TABLE BAI_KIEM_TRA (
	ID_BAI_KT    INT PRIMARY KEY,
	MA_PT  VARCHAR(10) NOT NULL,
	MA_HV        VARCHAR(20) NOT NULL,
	DIEM         FLOAT NOT NULL DEFAULT(0) CHECK(DIEM > 0),
	LOAI_BT      INT NOT NULL,
	CONSTRAINT UN_BKT UNIQUE(MA_PT,MA_HV)
	)

GO
-- 8) BANG DON PHUC KHAO
CREATE TABLE DON_PHUC_KHAO (
	MA_DON         VARCHAR(10) PRIMARY KEY,
	ID_BAI_KT      INT NOT NULL,
	NGAY_LAP_DON   DATETIME NOT NULL DEFAULT(GETDATE()),
	DIEM_MONG_MUON FLOAT NOT NULL CHECK(DIEM_MONG_MUON > 0),
	LY_DO_PK       NVARCHAR(256),
	)

GO
-- 9) BANG KET QUA PHUC KHAO
CREATE TABLE KET_QUA_PHUC_KHAO (
	ID_KQ	       INT PRIMARY KEY,
	MA_DON         VARCHAR(10) NOT NULL,
	MA_NV          VARCHAR(20) NOT NULL,
	DIEM_PK        FLOAT NOT NULL CHECK(DIEM_PK > 0),
	LY_DO          NVARCHAR(256),
	CONSTRAINT UN_KQPK UNIQUE(MA_DON,MA_NV)
	)

GO
-- 10) BANG BIEN LAI
CREATE TABLE BIEN_LAI (
	MA_BL     VARCHAR(10) PRIMARY KEY,
	TEN_BL    NVARCHAR(20) NOT NULL,
	NGAY_THU  DATETIME NOT NULL DEFAULT(GETDATE()),
	SO_TIEN   FLOAT NOT NULL CHECK (SO_TIEN > 0),
	MA_HV     VARCHAR(20) NOT NULL, --CUA HOC VIEN NAO
	MA_NV     VARCHAR(20) NOT NULL ---NHAN VIEN NAO THU
	)

GO
-- 11) BANG MON HOC
CREATE TABLE MON_HOC (
	MA_MH    VARCHAR(10) PRIMARY KEY,
	MA_LH    VARCHAR(10) NOT NULL,
	TEN_MH   NVARCHAR(20) NOT NULL,
	CT_MH    NVARCHAR(50),
	MA_PHONG   VARCHAR(10) NOT NULL,
	BUOI_HOC VARCHAR(15) NOT NULL
)

GO
-- 12) BANG KHOA HOC
CREATE TABLE KHOA_HOC (
	MA_KH   VARCHAR(10) PRIMARY KEY,
	NHOM_KH SMALLINT NOT NULL DEFAULT(0),
	HOC_PHI  MONEY NOT NULL CHECK(HOC_PHI > 0),
	TEN_KH  NVARCHAR(50) NOT NULL,
	MO_TA   NVARCHAR(150),
	TG_BAT_DAU DATETIME NOT NULL DEFAULT(GETDATE()),
	TG_KET_THUC DATETIME NOT NULL,
	CONSTRAINT CHECK_TG CHECK(TG_KET_THUC > TG_BAT_DAU)
)
GO

-- BANG LOP HOC
CREATE TABLE LOP_HOC(
	MA_LH VARCHAR(10) PRIMARY KEY,
	MA_KH VARCHAR(10) NOT NULL,
	THOI_GIAN_HOC VARCHAR(10) NOT NULL,
	SL_TOI_DA INT NOT NULL,
	SL_DA_DANG_KY INT DEFAULT(0),
	NGAY_KHAI_GIANG DATE NOT NULL,
	DIA_DIEM_HOC SMALLINT NOT NULL DEFAULT(0), -- 0 - CS1, 1 - CS2, 2 - ONLINE
)
GO

-- BANG HOC VIEN & LOP HOC
CREATE TABLE HV_LH(
	ID VARCHAR(10) PRIMARY KEY,
	MA_HV VARCHAR(10) NOT NULL,
	MA_LH VARCHAR(10) NOT NULL
)
GO

-- 13) BANG PHIEU DIEM DANH
CREATE TABLE PHIEU_DIEM_DANH (
	ID_PDD   INT PRIMARY KEY,
	MA_HV    VARCHAR(20) NOT NULL,
	MA_MH    VARCHAR(10) NOT NULL,
	HIEN_DIEN  SMALLINT NOT NULL DEFAULT(0),
	NGAY_DD     DATETIME  NOT NULL DEFAULT(GETDATE()),
	CONSTRAINT UN_PDD UNIQUE(MA_HV,MA_MH)
	)

GO
-- 14) BANG DANG_KY_THI_LAI
CREATE TABLE DANG_KY_THI_LAI (
	MA_DON_DKTL VARCHAR(10) PRIMARY KEY,
	NGAY_LAP   DATETIME NOT NULL DEFAULT(GETDATE()),
	XET_DUYET  SMALLINT NOT NULL DEFAULT(0), ---0: CHUA XET  1: XET
	MA_HV       VARCHAR(20) NOT NULL,
	MA_MH       VARCHAR(10) NOT NULL
	)

GO
-- 15) BANG HOC VIEN HOC MH
CREATE TABLE HOC_VIEN_HOC_MH (
	ID_HVMH   INT PRIMARY KEY,
	MA_HV   VARCHAR(20) NOT NULL,
	MA_MH      VARCHAR(10) NOT NULL,
	DIEM_TB   FLOAT NOT NULL DEFAULT(0),
	CONSTRAINT UN_HVMH UNIQUE(MA_HV,MA_MH)
	)

GO
-- 16) BANG DE THI
CREATE TABLE DE_THI (
	ID_MA_DE   INT PRIMARY KEY,
	MA_DE   VARCHAR(10),
	NGAY_THI  DATETIME NOT NULL DEFAULT(GETDATE()),
	MA_MH      VARCHAR(10) NOT NULL
	CONSTRAINT UN_DTMH UNIQUE(MA_DE,MA_MH)
	)

GO
-- 17) BANG CAU HOI
CREATE TABLE CAU_HOI (
	ID_CH   INT PRIMARY KEY,
	STT     INT NOT NULL,
	ID_MA_DE     INT NOT NULL,
	CAU_HOI     NVARCHAR(256) NOT NULL,
	DAP_AN      NVARCHAR(256) NOT NULL,
	CONSTRAINT UN_CH UNIQUE(STT,ID_MA_DE)
	)

GO
-- 18) BANG CAU TRA LOI
CREATE TABLE CAU_TRA_LOI (
	ID_CTL       INT PRIMARY KEY,
	ID_BAI_KT    INT NOT NULL,
	ID_CH        INT NOT NULL,
	CAU_TL       NVARCHAR(20),
	DIEM_TL      FLOAT NOT NULL CHECK(DIEM_TL > 0),
	CONSTRAINT UN_HV_MH UNIQUE(ID_BAI_KT,ID_CH)
	)

GO
-- 19) BANG VAN BANG
CREATE TABLE VAN_BANG (
	MA_VB     VARCHAR(10) PRIMARY KEY,
	MA_HV       VARCHAR(20) NOT NULL,
	MA_KH      VARCHAR(10)  NOT NULL,
	TEN_VB      VARCHAR(30) NOT NULL,
	DIEM_TB_KHOA    FLOAT NOT NULL CHECK(DIEM_TB_KHOA > 0),
	NGAY_CAP       DATETIME NOT NULL,
	XEP_LOAI        INT NOT NULL DEFAULT(0)
	)

GO
-- 20) BANG NHO CHUYEN DE
CREATE TABLE NHOM_CD (
	MA_NHOM     VARCHAR(10) PRIMARY KEY,
	MA_KH        VARCHAR(10)  NOT NULL,
	MO_TA       NVARCHAR(30) NOT NULL,
	TGBD       DATETIME   NOT NULL,
	TGKT        DATETIME NOT NULL,
	CONSTRAINT CHECK_TGKT CHECK(TGKT > TGBD)
	)

GO
-- 21) BANG CHUYEN DE
CREATE TABLE CHUYEN_DE (
	MA_CD     VARCHAR(10) PRIMARY KEY,
	MA_NHOM     VARCHAR(10) NOT NULL,
	MO_TA       NVARCHAR(30) NOT NULL,
	TG_BD      DATETIME   NOT NULL,
	TG_KT        DATETIME NOT NULL,
	CONSTRAINT CHECK_TGG CHECK(TG_KT > TG_BD)
	)

-- 22) CAM NHAN HOC VIEN
CREATE TABLE CAM_NHAN_HV (
	MA_HV VARCHAR(20) PRIMARY KEY,
	CAM_NHAN NVARCHAR(500)
)

-------------- RANG BUOC KHOA NGOAI --------------
-- BANG NGUOI DUNG
ALTER TABLE [dbo].[NGUOI_DUNG]
ADD CONSTRAINT FK_TK_ND
FOREIGN KEY(MA_ND) REFERENCES [dbo].[TAI_KHOAN](USERNAME)
GO

-- BANG NHAN VIEN
ALTER TABLE [dbo].[NHAN_VIEN]
ADD CONSTRAINT FK_NV_ND
FOREIGN KEY(MA_NV) REFERENCES [dbo].[NGUOI_DUNG](MA_ND)
GO

-- BANG KHACH HANG
ALTER TABLE [dbo].KHACH_HANG
ADD CONSTRAINT FK_NV_KH
FOREIGN KEY(MA_NV) REFERENCES [dbo].[NHAN_VIEN](MA_NV)
GO

-- BANG BIEN LAI
ALTER TABLE [dbo].[BIEN_LAI]
ADD CONSTRAINT FK_BL_NV
FOREIGN KEY(MA_NV) REFERENCES [dbo].[NHAN_VIEN](MA_NV)
GO

-- BANG BIEN LAI
ALTER TABLE [dbo].[BIEN_LAI]
ADD CONSTRAINT FK_BL_HV
FOREIGN KEY(MA_HV) REFERENCES [dbo].[NGUOI_DUNG](MA_ND)
GO

-- BANG PHIEU DIEM DANH
ALTER TABLE [dbo].[PHIEU_DIEM_DANH]
ADD CONSTRAINT FK_PDD_HV
FOREIGN KEY(MA_HV) REFERENCES [dbo].[NGUOI_DUNG](MA_ND)
GO

-- BANG PHIEU DIEM DANH
ALTER TABLE [dbo].[PHIEU_DIEM_DANH]
ADD CONSTRAINT FK_PDD_MH
FOREIGN KEY(MA_MH) REFERENCES [dbo].[MON_HOC](MA_MH)
GO

-- BANG DON PHUC KHAO
ALTER TABLE [dbo].[DON_PHUC_KHAO]
ADD CONSTRAINT FK_DPK_BKT
FOREIGN KEY(ID_BAI_KT) REFERENCES [dbo].[BAI_KIEM_TRA](ID_BAI_KT)
GO

-- BANG KET QUA PHUC KHAO
ALTER TABLE [dbo].[KET_QUA_PHUC_KHAO]
ADD CONSTRAINT FK_KQPK_NV
FOREIGN KEY(MA_NV) REFERENCES [dbo].[NHAN_VIEN](MA_NV)
GO

-- BANG KET QUA PHUC KHAO
ALTER TABLE [dbo].[KET_QUA_PHUC_KHAO]
ADD CONSTRAINT FK_KQPK_D
FOREIGN KEY(MA_DON) REFERENCES [dbo].[DON_PHUC_KHAO](MA_DON)
GO

-- BANG BAI KIEM TRA
ALTER TABLE [dbo].[BAI_KIEM_TRA]
ADD CONSTRAINT FK_BKT_PT
FOREIGN KEY(MA_PT) REFERENCES [dbo].[PHONG_THI](MA_PT)
GO

-- BANG BAI KIEM TRA
ALTER TABLE [dbo].[BAI_KIEM_TRA]
ADD CONSTRAINT FK_BKT_HV
FOREIGN KEY(MA_HV) REFERENCES [dbo].[NGUOI_DUNG](MA_ND)
GO

-- BANG DANG KY THI LAI
ALTER TABLE [dbo].[DANG_KY_THI_LAI]
ADD CONSTRAINT FK_DKTL_HV
FOREIGN KEY(MA_HV) REFERENCES [dbo].[NGUOI_DUNG](MA_ND)
GO

-- BANG DANG KY THI LAI
ALTER TABLE [dbo].[DANG_KY_THI_LAI]
ADD CONSTRAINT FK_DKTL_MH
FOREIGN KEY(MA_MH) REFERENCES [dbo].[MON_HOC](MA_MH)
GO

-- BANG PHONG THI
ALTER TABLE [dbo].[PHONG_THI]
ADD CONSTRAINT FK_PT_PH
FOREIGN KEY(MA_PHONG) REFERENCES [dbo].[PHONG_HOC](MA_PHONG)
GO

-- BANG PHONG THI
ALTER TABLE [dbo].[PHONG_THI]
ADD CONSTRAINT FK_PT_MH
FOREIGN KEY(MA_MH) REFERENCES [dbo].[MON_HOC](MA_MH)
GO

-- BANG MON_HOC
ALTER TABLE [dbo].[MON_HOC]
ADD CONSTRAINT FK_MH_LH
FOREIGN KEY(MA_LH) REFERENCES [dbo].[LOP_HOC](MA_LH)
GO

-- BANG MON_HOC
ALTER TABLE [dbo].[MON_HOC]
ADD CONSTRAINT FK_MH_PH
FOREIGN KEY(MA_PHONG) REFERENCES [dbo].[PHONG_HOC](MA_PHONG)
GO

-- BANG LOP HOC
ALTER TABLE dbo.LOP_HOC
ADD CONSTRAINT FK_LH_KH
FOREIGN KEY(MA_KH) REFERENCES dbo.KHOA_HOC(MA_KH)
GO

-- BANG HOC VIEN & LOP HOC
ALTER TABLE dbo.HV_LH
ADD CONSTRAINT FK_HV_LH_HV
FOREIGN KEY(MA_HV) REFERENCES dbo.NGUOI_DUNG(MA_ND)
GO

ALTER TABLE dbo.HV_LH
ADD CONSTRAINT FK_HV_LH_LH
FOREIGN KEY(MA_LH) REFERENCES dbo.LOP_HOC(MA_LH)
GO

-- BANG HOC VIEN HOC MH
ALTER TABLE [dbo].[HOC_VIEN_HOC_MH]
ADD CONSTRAINT FK_HVMH_HV
FOREIGN KEY(MA_HV) REFERENCES [dbo].[NGUOI_DUNG](MA_ND)
GO

-- BANG HOC VIEN HOC MH
ALTER TABLE [dbo].[HOC_VIEN_HOC_MH]
ADD CONSTRAINT FK_HVMH_MH
FOREIGN KEY(MA_MH) REFERENCES [dbo].[MON_HOC](MA_MH)
GO

-- BANG DE THI
ALTER TABLE [dbo].[DE_THI]
ADD CONSTRAINT FK_DT_MH
FOREIGN KEY(MA_MH) REFERENCES [dbo].[MON_HOC](MA_MH)
GO

-- BANG CAU HOI
ALTER TABLE [dbo].[CAU_HOI]
ADD CONSTRAINT FK_CH_DT
FOREIGN KEY(ID_MA_DE) REFERENCES [dbo].[DE_THI](ID_MA_DE)
GO

-- BANG CAU TRA LOI
ALTER TABLE [dbo].[CAU_TRA_LOI]
ADD CONSTRAINT FK_TL_CH
FOREIGN KEY(ID_CH) REFERENCES [dbo].[CAU_HOI](ID_CH)
GO

-- BANG CAU TRA LOI
ALTER TABLE [dbo].[CAU_TRA_LOI]
ADD CONSTRAINT FK_TL_BKT
FOREIGN KEY(ID_BAI_KT) REFERENCES [dbo].[BAI_KIEM_TRA](ID_BAI_KT)
GO

-- BANG VAN BANG
ALTER TABLE [dbo].[VAN_BANG]
ADD CONSTRAINT FK_VB_KH
FOREIGN KEY(MA_KH) REFERENCES [dbo].[KHOA_HOC](MA_KH)
GO

-- BANG VAN BANG
ALTER TABLE [dbo].[VAN_BANG]
ADD CONSTRAINT FK_VB_HV
FOREIGN KEY(MA_HV) REFERENCES [dbo].[NGUOI_DUNG](MA_ND)
GO

-- BANG NHOM CHUYEN DE
ALTER TABLE [dbo].[NHOM_CD]
ADD CONSTRAINT FK_NHOMCD_KH
FOREIGN KEY(MA_KH) REFERENCES [dbo].[KHOA_HOC](MA_KH)
GO

-- BANG CHUYEN DE
ALTER TABLE [dbo].[CHUYEN_DE]
ADD CONSTRAINT FK_CD_NCD
FOREIGN KEY(MA_NHOM) REFERENCES [dbo].[NHOM_CD](MA_NHOM)
GO

-- BANG CAM NHAN HOC VIEN
ALTER TABLE [dbo].CAM_NHAN_HV
ADD CONSTRAINT FK_CNHV_HV
FOREIGN KEY(MA_HV) REFERENCES dbo.NGUOI_DUNG(MA_ND)
GO

