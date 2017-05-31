-- Tạo user
declare
  cursor c_nhanvien is select * from NhanVien;
  v_nhanvien c_nhanvien%rowtype;
begin
  open c_nhanvien;
  loop
    fetch c_nhanvien into v_nhanvien; 
    exit when c_nhanvien%notfound;
    execute immediate 'create user ' || v_nhanvien.manv || ' identified by 123456';
    execute immediate 'grant create session to ' || v_nhanvien.manv;
  end loop;
  close c_nhanvien;
end;


-- Ma hoa luong Nhan Vien
declare
 input_string VARCHAR2 (200) := 'Secret Message';
 output_string VARCHAR2 (200);
 encrypted_raw RAW (2000); -- stores encrypted binary text
 decrypted_raw RAW (2000); -- stores decrypted binary text
 num_key_bytes NUMBER := 256/8; -- key length 256 bits (32 bytes)
 key_bytes_raw RAW (32); -- stores 256-bit encryption key 
 encryption_type PLS_INTEGER := -- total encryption type
 DBMS_CRYPTO.ENCRYPT_AES256
 + DBMS_CRYPTO.CHAIN_CBC
 + DBMS_CRYPTO.PAD_PKCS5;
begin
 DBMS_OUTPUT.PUT_LINE ('Original string: ' || input_string);
 key_bytes_raw := DBMS_CRYPTO.RANDOMBYTES (num_key_bytes);
 encrypted_raw := DBMS_CRYPTO.ENCRYPT
 ( src => UTL_I18N.STRING_TO_RAW (input_string, 'AL32UTF8'),
 typ => encryption_type,
 key => key_bytes_raw
 );

 -- The encrypted value in the encrypted_raw variable can be used here
 decrypted_raw := DBMS_CRYPTO.DECRYPT
 (
 src => encrypted_raw,
 typ => encryption_type,
 key => key_bytes_raw
 );
 output_string := UTL_I18N.RAW_TO_CHAR (decrypted_raw, 'AL32UTF8');
 DBMS_OUTPUT.PUT_LINE ('Decrypted string: ' || output_string);
 end;
 
 create view V_NhanVien as
 select maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh,
 substr (sys.dbcrypt.decrypt(luong), 1, 35) as luong
 from NhanVien_1312079_1312169_1312273;
