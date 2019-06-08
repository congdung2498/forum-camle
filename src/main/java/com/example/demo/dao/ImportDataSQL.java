package com.example.demo.dao;

import com.example.demo.dao.config.MyConnectionSql;
import com.example.demo.model.Profile;
import com.example.demo.model.Recruitment;
import com.example.demo.model.Salary;

import java.sql.*;

public class ImportDataSQL {
    static MyConnectionSql myConnectionSQL = new MyConnectionSql();
    public static Connection connection = myConnectionSQL.getConnection();

    public int importStaffProfileByExcel(Profile profile, String password) { // return 0 - success , 1 - skip , 2 - error, 3 - accError
        if (importStaffProfile(profile)==1) {
            return 1;
        }
        if (importStaffProfile(profile)==2) {
            return 2;
        }
        if (!createAccount(profile.getMaNV(), password,  "ROLE_USER" , profile.getHoVaTen())) {
            return 3;
        }
        int accountId = getIdAccountByMaNV(profile.getMaNV());
        if (accountId != 0) {
            updateAccountIdProfile(accountId, profile.getMaNV());
        }

        return 0;
    }

    public int importStaffProfile(Profile profile) {      // return 0 - success , 1 - skip , 2 - error
        try {
            Statement statement = connection.createStatement();
            if (checkExistStaff(profile.getMaNV(), profile.getSoCMND()) == true) {
                return 1;
            } else {
                String sql = "insert into Profile (MaNV,HoVaTen,NgaySinh,DonVi,SoDT,SoCMND,NgayCap,NoiCap,Mail,SoTaiKhoan,NganHangHuong,ChucDanh) values (" +
                        "'" + profile.getMaNV() + "'," +
                        "'" + profile.getHoVaTen() + "'," +
                        "'" + profile.getNgaySinh() + "'," +
                        "'" + profile.getDonVi() + "'," +
                        "'" + profile.getSoDT() + "'," +
                        "'" + profile.getSoCMND() + "'," +
                        "'" + profile.getNgayCap() + "'," +
                        "'" + profile.getNoiCap() + "'," +
                        "'" + profile.getMail() + "'," +
                        "'" + profile.getSoTaiKhoan() + "'," +
                        "'" + profile.getNganHangHuong() + "'," +
                        "'" + profile.getChucDanh() + "')";
                statement.executeUpdate(sql);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return 2;
        }

        return 0;
    }

    public Boolean createAccount(String userName, String passWord , String role, String hovaten) {
        try {
            Statement statement = connection.createStatement();
            String sql = "insert into user (username,password,role,hovaten) values ('" + userName + "','" + passWord + "','" + role + "','" + hovaten + "')";
            statement.executeUpdate(sql);

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public Boolean updateAccountIdProfile(int userID, String maNV) {
        try {
            Statement statement = connection.createStatement();
            String sql = "update Profile set UserID = " + userID + " where maNV = '" + maNV + "'";
            statement.executeUpdate(sql);

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public int getIdAccountByMaNV(String maNV) {
        int accountId = 0;
        try {
            Statement statement = connection.createStatement();
            String sql = "select id from user WHERE username = '" + maNV + "'";
            ResultSet resultSet = statement.executeQuery(sql);

            if (!resultSet.next()) {
                return accountId;
            } else {
                accountId = resultSet.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return accountId;
    }

    public boolean checkExistStaff(String maNV, String SoCMND) {
        try {
            Statement statement = connection.createStatement();
            String sql = "select * from Profile WHERE MaNV = '" + maNV + "' or SoCMND = '" + SoCMND + "'";
            ResultSet resultSet = statement.executeQuery(sql);

            if (!resultSet.next()) {
                return false;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return true;
    }

    public boolean importCVProfile(Recruitment recruitment) {
        try {
            Statement statement = connection.createStatement();
            if (checkExistCV(recruitment.getMaCV()) == true) {
                return false;
            } else {

                int ketQuaVong1, ketQuaVong2;
                if (recruitment.isKetQuaV1() == true)
                    ketQuaVong1 = 1;
                else ketQuaVong1 = 0;
                if (recruitment.isKetQuaV2() == true)
                    ketQuaVong2 = 1;
                else ketQuaVong2 = 0;

                String sql = "insert into Recruitment (MaCV, Hunter, HoVaTen, NamSinh, SoDT, Email, Truong, Nganh, DoiTuong, ViTri," +
                        " DonViPV, NguoiPV, NguonCV, NguoiGT, NgayPVVong1, KetQuaV1, NgayPVVong2, KetQuaV2, KetQuaCuoi, NhanXet, Note)" +
                        " values (" +
                        "'" + recruitment.getMaCV() + "'," +
                        "'" + recruitment.getHunter() + "'," +
                        "'" + recruitment.getHoVaTen() + "'," +
                        "'" + recruitment.getNamSinh() + "'," +
                        "'" + recruitment.getSoDT() + "'," +
                        "'" + recruitment.getEmail() + "'," +
                        "'" + recruitment.getTruong() + "'," +
                        "'" + recruitment.getNganh() + "'," +
                        "'" + recruitment.getDoiTuong() + "'," +
                        "'" + recruitment.getViTri() + "'," +
                        "'" + recruitment.getDonViPV() + "'," +
                        "'" + recruitment.getNguoiPV() + "'," +
                        "'" + recruitment.getNguonCV() + "'," +
                        "'" + recruitment.getNguoiGT() + "'," +
                        "'" + recruitment.getNgayPVVong1() + "'," +
                        ketQuaVong1 + "," +
                        "'" + recruitment.getNgayPVVong2() + "'," +
                        ketQuaVong2 + "," +
                        recruitment.getKetQuaCuoi() + "," +
                        "'" + recruitment.getNhanXet() + "'," +
                        "'" + recruitment.getNote() + "')";

                statement.executeUpdate(sql);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean checkExistCV(String maCV) {
        try {
            Statement statement = connection.createStatement();
            String sql = "select * from Recruitment WHERE MaCV = '" + maCV + "'";
            ResultSet resultSet = statement.executeQuery(sql);

            if (!resultSet.next()) {
                return false;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return true;
    }

    public boolean importSalary(Salary salary) {
        try {
            int profileID = convertMaNvToProfileId(salary.getMaNV());
            if (profileID == 0 || salary.getThang().equals("")) {
                return false;
            }

            Statement statement = connection.createStatement();
            if (checkExistSalary(profileID, salary.getThang()) == true) {
                return false;
            } else {

                String sql = "insert into Salary (ProfileID,Thang, LuongChucDanh, ThamNien, LePhep, BoiDuongTruc," +
                        "DieuChinhBoSung, PhuCapDoanThe, PhuCapAnCa, PhuCapDienThoai, TongThuNhap, BHXH," +
                        "BHYT, BHTN, KinhPhiCongDoan, ThueTNCN, TongKhauTru, SoTienChuyenKhoan," +
                        "CongCheDo, CongThucTe, NgayNghiLePhep, NgayTruc, KI)" +
                        " values (" +
                        profileID + "," +
                        "STR_TO_DATE('"+salary.getThang()+"', '%m/%Y') ," +
                        salary.getLuongChucDanh() + "," +
                        salary.getLuongThamNien() + "," +
                        salary.getLuongLePhep() + "," +
                        salary.getBoiDuongTruc() + "," +
                        salary.getDieuChinhBoSung() + "," +
                        salary.getPhuCapDoanThe() + "," +
                        salary.getPhuCapAnCa() + "," +
                        salary.getPhuCapDienThoai() + "," +
                        salary.getTongThuNhap() + "," +
                        salary.getBHXH() + "," +
                        salary.getBHYT() + "," +
                        salary.getBHTN() + "," +
                        salary.getKinhPhiCongDoan() + "," +
                        salary.getThueTNCN() + "," +
                        salary.getTongKhauTru() + "," +
                        salary.getSoTienChuyenKhoan() + "," +
                        salary.getCongCheDo() + "," +
                        salary.getCongThucTe() + "," +
                        salary.getNgayNghiLePhep() + "," +
                        salary.getNgayTruc() + "," +
                        "'" + salary.getKI() + "')";
                statement.executeUpdate(sql);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean checkExistSalary(int profileID, String thang) {
        try {
            Statement statement = connection.createStatement();
            String sql = "select * from Salary WHERE ProfileID = " + profileID + " and Thang = " +   "STR_TO_DATE('"+thang+"', '%m/%Y') ";
            System.out.println(sql);
            ResultSet resultSet = statement.executeQuery(sql);
            if (!resultSet.next()) {
                return false;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return true;
    }

    public int convertMaNvToProfileId(String maNV) {
        int profileID = 0;
        try {
            Statement statement = connection.createStatement();
            String sql = "select * from Profile WHERE MaNV = '" + maNV + "'";
            ResultSet resultSet = statement.executeQuery(sql);

            if (!resultSet.next()) {
                return profileID;
            }
            profileID = resultSet.getInt(1);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return profileID;
    }

    public boolean updateImg(String strImg, String maNV) {
        try {
            int profileID = convertMaNvToProfileId(maNV);
            if (profileID == 0) {
                return false;
            }

            PreparedStatement ps = connection.prepareStatement("update Profile set Avata =  ? where id = ?");
            ps.setString(1, strImg);
            ps.setInt(2, profileID);
            ps.executeUpdate();

            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public String getImageByMaNV(String maNV) {
        String str_img = "";
        try {
            Statement statement = connection.createStatement();
            String sql = "select Avata from Profile WHERE MaNV = '" + maNV + "'";
            ResultSet resultSet = statement.executeQuery(sql);

            if (!resultSet.next()) {
                return str_img;
            }

            str_img = resultSet.getString(1);

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return str_img;
    }
}
