// this is sample schema
/*
DROP TABLE NhanVien CASCADE CONSTRAINTS;
DROP TABLE ChiNhanh CASCADE CONSTRAINTS;
DROP TABLE ChiTieu CASCADE CONSTRAINTS;
DROP TABLE DuAn CASCADE CONSTRAINTS;
DROP TABLE PhongBan CASCADE CONSTRAINTS;
DROP TABLE PhanCong CASCADE CONSTRAINTS;
*/

create table NhanVien
(
  maNV char(10) primary key,
  hoTen nvarchar2(50),
  diaChi nvarchar2(100),
  dienThoai number,
  email varchar2(50),
  maPhong char(10),
  chiNhanh char(10),
  luong raw(2000)
);

create table PhongBan
(
  maPhong char(10) primary key,
  tenPhong nvarchar2(50),
  truongPhong char(10),
  ngayNhanChuc date,
  soNhanVien number,
  chiNhanh char(10)
);

create table DuAn
(
  maDA char(10) primary key,
  tenDA nvarchar2(50),
  kinhPhi number,
  phongChuTri char(10),
  truongDA char(10)
);

create table ChiNhanh
(
  maCN char(10) primary key,
  tenCN nvarchar2(50),
  truongChiNhanh char(10)
);

create table ChiTieu
(
  maChiTieu char(10) primary key,
  tenChiTieu nvarchar2(50),
  soTien number,
  duAn char(10)
);

create table PhanCong
(
  maNV char(10),
  duAn char(10),
  vaiTro nvarchar2(50),
  phuCap number,
  primary key (maNV,duAn)
);

	
	alter table NhanVien
	add constraint fk_NhanVien_PhongBan
	foreign key (maPhong)
	references PhongBan(maPhong);
  
  alter table NhanVien
	add	constraint fk_NhanVien_ChiNhanh
	foreign key (chiNhanh)
	references ChiNhanh(maCN);

	alter table PhongBan
	add constraint fk_PhongBan_ChiNhanh
	foreign key (chiNhanh)
	references ChiNhanh(maCN);
  
  alter table PhongBan
	add	constraint fk_PhongBan_NhanVien
	foreign key (truongPhong)
	references NhanVien(maNV);

	alter table ChiNhanh
	add constraint ChiNhanh_NhanVien
	foreign key (truongChiNhanh)
	references NhanVien(maNV);

	alter table DuAn
	add constraint fk_DuAn_PhongBan
	foreign key (phongChuTri)
	references PhongBan(maPhong);
  
  alter table DuAn
	add	constraint fk_DuAn_NhanVien
	foreign key (truongDA)
	references NhanVien(maNV);

	alter table ChiTieu
	add constraint fk_ChiTieu_DuAn
	foreign key (duAn)
	references DuAn(maDA);

	alter table PhanCong
	add constraint fk_PhanCong_NhanVien
	foreign key (maNV)
	references NhanVien(maNV);
  
  alter table PhanCong
	add	constraint fk_PhanCong_DuAn
	foreign key (duAn)
	references DuAn(maDA);
  
 
