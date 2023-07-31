create database svdh;
use svdh;

create table dmkhoa(
Makhoa nvarchar(20) primary key ,
TenKhoa nvarchar(255)
);

create table dmnganh(
MaNganh int primary key auto_increment,
TenNganh nvarchar(255),
MaKhoa nvarchar(20),
foreign key (Makhoa) references dmkhoa(Makhoa)
);

create table dmlop(
Malop nvarchar(20) primary key ,
Tenlop nvarchar(255),
MaNganh int,
KhoaHoc int,
HeDT nvarchar(255),
NamNhapHoc int,
foreign key (MaNganh) references dmnganh(MaNganh)
);

create table dmhocphan(
MaHp int primary key auto_increment,
TenHp nvarchar(255),
Sodvht int,
MaNganh int,
HocKy int,
foreign key (MaNganh) references dmnganh(MaNganh)
);

create table sinhvien(
MaSV int primary key auto_increment,
HoTen nvarchar(255),
Malop nvarchar(20),
GioiTinh tinyint(1),
NgaySinh date,
Diachi nvarchar(255)
);

create table diemhp(
masv int,
mahp int,
diemhp float,
foreign key (masv) references sinhvien(masv),
foreign key (mahp) references dmhocphan(mahp)
);

-- thêm dữ liệu vào bảng diemhp
insert into diemhp value 
(2,2,5.9),
(2,3,4.5),
(3,1,4.3),
(3,2,6.7),
(3,3,7.3),
(4,1,4.0),
(4,2,5.2),
(4,3,3.5),
(5,1,9.8),
(5,2,7.9),
(5,3,7.5),
(6,1,6.1),
(6,2,5.6),
(6,3,4.0),
(7,1,6.2);

-- Thêm dữ liệu vào bảng dmkhoa 
insert into dmkhoa (Makhoa, TenKhoa) 
values
	('CNTT','Công Nghệ Thông Tin'),
    ('KT','Kế Toán'),
    ('SP','Sư Phạm');

-- thêm dữ liệu vào bảng dmnganh
insert into dmnganh (MaNganh, TenNganh, MaKhoa)
values
	(140902,'Sư phạm toán tin','SP'),
    (480202,'Tin học ứng dụng','CNTT');
    
-- thêm dữ liệu vào bảng dmlop
insert into dmlop (MaLop, TenLop, MaNganh, KhoaHoc, HeDT, NamNhapHoc)
values 
	('CT11','Cao đẳng tin học',480202,11,'TC',2013),
	('CT12','Cao đẳng tin học',480202,12,'CĐ',2013),
	('CT13','Cao đẳng tin học',480202,13,'TC',2014);
    
-- thêm dữ liệu vào bảng dmhocphan
insert into dmhocphan (MaHP, TenHP, Sodvht, Manganh, HocKy)
values 
	(1,'Toán cao cấp A1',4,480202,1),
	(2,'Tiếng Anh 1',3,480202,1),
	(3,'Vật lý đại cương',4,480202,1),
	(4,'Tiếng Anh 2',7,480202,1),
	(5,'Tiếng Anh 1',3,140902,2),
	(6,'Xác suất thống kê',3,480202,2);
    
-- thêm dữ liệu vào bảng sinhvien
insert into sinhvien (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, DiaChi)
values
	(1,'Phan Thanh','CT12',0,'1990-09-12','Tuy Phước'),
	(2,'Nguyễn Thị Cẩm','CT12',1,'1990-01-12','Quy Nhơn'),
	(3,'Võ Thị Hà','CT12',1,'1990-07-02','An Nhơn'),
	(4,'Trần Hoài Nam','CT12',0,'1990-04-05','Tây Sơn'),
	(5,'Trần Văn Hoàng','CT13',0,'1990-08-04','Vĩnh Thạnh'),
	(6,'Đặng Thị Thảo','CT13',1,'1990-06-12','Quy Nhơn'),
	(7,'Lê Thị Sen','CT13',1,'1990-08-12','Phú Mỹ'),
	(8,'Nguyễn Văn Huy','CT11',0,'1990-06-04','Tuy Phước'),
	(9,'Trần Thị Hoa','CT11',1,'1990-08-09','Hoài Nhơn');

-- 1. Hiển thị danh sách gồm MaSV, HoTên, MaLop, DiemHP, MaHP của những sinh viên có điểm HP >= 5 (5đ)
select sv.MaSV, sv.HoTen, sv.MaLop, dh.DiemHP, dh.MaHP
from sinhvien sv
join diemhp dh on sv.MaSV = dh.masv
where dh.DiemHP >= 5;

-- 2. Hiển thị danh sách MaSV, HoTen, MaLop, MaHP, DiemHP, MaHP được sắp xếp theo ưu tiên MaLop, HoTen tăng dần. (5đ)
select sv.MaSV, sv.HoTen, sv.MaLop, dh.MaHP, dh.DiemHP
from sinhvien sv
join diemhp dh on sv.MaSV = dh.masv
order by sv.MaLop asc, sv.HoTen asc;

-- 3. Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, HocKy của những sinh viên có DiemHP từ 5 -> 7 ở học kỳ I. (5đ)
select sv.MaSV, sv.HoTen, sv.MaLop, dh.DiemHP, hp.HocKy
from sinhvien sv
join diemhp dh on sv.MaSV = dh.masv
join dmhocphan hp on dh.MaHP = hp.MaHP
where dh.DiemHP >= 5 and dh.DiemHP <= 7 and hp.HocKy = 1;

-- 4. Hiển thị danh sách sinh viên gồm MaSV, HoTen, MaLop, TenLop, MaKhoa của Khoa có mã CNTT (5đ)
select sv.MaSV, sv.HoTen, sv.MaLop, dl.TenLop, kh.MaKhoa
from sinhvien sv
join dmlop dl on sv.MaLop = dl.Malop
join dmnganh ng on dl.MaNganh = ng.MaNganh
join dmkhoa kh on ng.MaKhoa = kh.Makhoa
where kh.Makhoa = 'CNTT';

-- 5. Cho biết MaLop, TenLop, tổng số sinh viên của mỗi lớp (SiSo): (5đ)
select dl.MaLop, dl.TenLop, COUNT(sv.MaSV) AS SiSo
from dmlop dl
left join sinhvien sv on dl.MaLop = sv.MaLop
group by dl.MaLop, dl.TenLop;

-- 6. Cho biết điểm trung bình chung của mỗi sinh viên ở mỗi học kỳ, biết công thức tính DiemTBC như sau:
-- DiemTBC = ∑(𝐷𝑖𝑒𝑚𝐻𝑃∗𝑆𝑜𝑑𝑣ℎ𝑝)/∑(𝑆𝑜𝑑𝑣ℎ𝑝)

-- 7. Cho biết MaLop, TenLop, số lượng nam nữ theo từng lớp.
select dl.MaLop, dl.TenLop,
       SUM(case when sv.GioiTinh = 0 then 1 else 0 end) as SoLuongNam,
       SUM(case when sv.GioiTinh = 1 then 1 else 0 end) as SoLuongNu
from dmlop dl
left join sinhvien sv on dl.MaLop = sv.MaLop
group by dl.MaLop, dl.TenLop;

-- 8. Cho biết điểm trung bình chung của mỗi sinh viên ở học kỳ 1
-- Biết: DiemTBC = ∑(𝐷𝑖𝑒𝑚𝐻𝑃∗𝑆𝑜𝑑𝑣ℎ𝑝)/∑(𝑆𝑜𝑑𝑣ℎ𝑝)

-- 9. Cho biết MaSV, HoTen, Số các học phần thiếu điểm (DiemHP<5) của mỗi sinh viên
select sv.MaSV, sv.HoTen,
       SUM(case when dh.DiemHP < 5 then 1 else 0 end) as SoLuong
from sinhvien sv
left join diemhp dh on sv.MaSV = dh.masv
group by sv.MaSV, sv.HoTen;

-- 10. Đếm số sinh viên có điểm HP <5 của mỗi học phần
select dh.MaHP,
       SUM(case when dh.DiemHP < 5 then 1 else 0 end) as SL_SV_Thieu
from diemhp dh
join dmhocphan hp on dh.MaHP = hp.MaHP
group by dh.MaHP;

-- 11. Tính tổng số đơn vị học trình có điểm HP<5 của mỗi sinh viên
select sv.MaSV, sv.HoTen, sum(d2.Sodvht) as 'tongdiem'
from sinhvien sv
         join diemhp d on sv.MaSV = d.MaSV
         join dmhocphan d2 on d2.MaHP = d.MaHP
where DiemHP < 5
group by d.MaSV;

-- 12. Cho biết MaLop, TenLop có tổng số sinh viên >2.
select dl.MaLop, dl.TenLop
from dmlop dl
left join sinhvien sv on dl.MaLop = sv.MaLop
group by dl.MaLop, dl.TenLop
having COUNT(sv.MaSV) > 2;

-- 13. Cho biết HoTen sinh viên có ít nhất 2 học phần có điểm <5. (10đ)
select sv.MaSV, sv.HoTen, COUNT(distinct dh.MaHP) as Soluong
from sinhvien sv
inner join diemhp dh on sv.MaSV = dh.masv
where dh.DiemHP < 5
group by sv.MaSV, sv.HoTen
having COUNT(distinct dh.MaHP) >= 2;


-- 14. Cho biết HoTen sinh viên học ít nhất 3 học phần mã 1,2,3 (10đ)
select sv.HoTen, COUNT(distinct dh.MaHP) as soluong
from sinhvien sv
inner join diemhp dh on sv.MaSV = dh.masv
where dh.MaHP in (1, 2, 3)
group by sv.HoTen
having COUNT(distinct dh.MaHP) >= 3;




