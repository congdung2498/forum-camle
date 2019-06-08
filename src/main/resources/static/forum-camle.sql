-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1:3306
-- Thời gian đã tạo: Th6 08, 2019 lúc 05:08 AM
-- Phiên bản máy phục vụ: 5.7.22-log
-- Phiên bản PHP: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `forum-camle`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `ID` int(20) NOT NULL AUTO_INCREMENT,
  `CateName` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `category`
--

INSERT INTO `category` (`ID`, `CateName`) VALUES
(1, 'Đời sống');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `NewsID` int(11) NOT NULL,
  `Content` text,
  `Date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  KEY `NewsID` (`NewsID`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `comment`
--

INSERT INTO `comment` (`ID`, `UserID`, `NewsID`, `Content`, `Date`) VALUES
(2, 124, 14, 'Hay quá', '2019-06-02 10:24:06'),
(3, 124, 14, 'Hay Bình thường', '2019-06-02 10:24:48'),
(4, 233, 14, 'heen', '2019-06-02 11:10:50'),
(5, 233, 14, 'aa', '2019-06-02 11:11:02'),
(6, 124, 14, 'aaaa', '2019-06-03 10:20:46'),
(7, 124, 16, 'hêlllo', '2019-06-03 10:21:45'),
(19, 124, 16, '1', '2019-06-03 10:45:32'),
(22, 227, 16, 'Hêlloo', '2019-06-03 11:13:28'),
(27, 233, 16, 'ccc', '2019-06-03 12:09:30'),
(29, 124, 18, 'Đẹp quá  !!!', '2019-06-04 08:28:57'),
(31, 233, 18, 'Tuyệt vời !!!', '2019-06-04 08:31:28'),
(33, 225, 18, 'Chất quá !!!', '2019-06-05 10:03:52'),
(34, 239, 18, 'aaaa', '2019-06-05 11:39:27');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `file_news`
--

DROP TABLE IF EXISTS `file_news`;
CREATE TABLE IF NOT EXISTS `file_news` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NewsID` int(11) DEFAULT NULL,
  `FileName` mediumtext,
  PRIMARY KEY (`ID`),
  KEY `NewsID` (`NewsID`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `file_news`
--

INSERT INTO `file_news` (`ID`, `NewsID`, `FileName`) VALUES
(33, 16, '/downloadFile/image_2019-05-21_10-53-47169473.png'),
(34, 16, '/downloadFile/image_2019-05-21_10-56-54074550.png'),
(36, 14, '/downloadFile/image_2019-05-21_10-56-54627166.png'),
(40, 18, '/downloadFile/image_2019-05-21_10-53-47939346.png'),
(42, 18, '/downloadFile/image_2019-05-22_14-40-28888082.png');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `news`
--

DROP TABLE IF EXISTS `news`;
CREATE TABLE IF NOT EXISTS `news` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `CateID` int(11) DEFAULT NULL,
  `Title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Content` longtext COLLATE utf8_unicode_ci,
  `Author` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Date` datetime DEFAULT CURRENT_TIMESTAMP,
  `Type` int(10) DEFAULT NULL,
  `Summary` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`),
  KEY `FK_cate` (`CateID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `news`
--

INSERT INTO `news` (`ID`, `CateID`, `Title`, `Content`, `Author`, `Date`, `Type`, `Summary`) VALUES
(10, 1, 'Quang Hải: Khi “Quả bóng Vàng Việt Nam” làm Đại sứ bảo vệ môi trường', '<p><img alt=\"\" src=\"https://cdn.24h.com.vn/upload/2-2019/images/2019-04-11/Quang-Hai-Khi-Qua-bong-Vang-Viet-Nam-lam-dai-su-bao-ve-moi-truong-qua-bong-vang--1-1554969263-578-width660height440.jpg\" style=\"height:440px; width:660px\" /></p>\n\n<p>Quang Hải t&iacute;ch cực gia c&aacute;c hoạt động thu gom r&aacute;c thải, bảo vệ m&ocirc;i trường v&agrave; k&ecirc;u gọi cộng đồng c&ugrave;ng h&agrave;nh động v&igrave; một m&ocirc;i trường xanh, sạch, an to&agrave;n cho sức khỏe</p>\n\n<p>B&oacute;ng đ&aacute; Việt Nam hiện đang sở hữu một t&agrave;i năng lớn, một &ldquo;vi&ecirc;n ngọc qu&yacute;&rdquo; đặc biệt m&agrave; rất l&acirc;u rồi, ch&uacute;ng ta mới được chứng kiến. Đ&oacute; ch&iacute;nh l&agrave; Nguyễn Quang Hải. Từ năm 2018 đến nay, dưới sự dẫn dắt của HLV Park Hang Seo, tiền vệ người Đ&ocirc;ng Anh (H&agrave; Nội) đ&atilde; thi đấu xuất sắc v&agrave; gi&uacute;p b&oacute;ng đ&aacute; nước nh&agrave; đạt được rất nhiều th&agrave;nh tựu vượt bậc.</p>\n\n<p>Đ&oacute; l&agrave; ng&ocirc;i &aacute; qu&acirc;n U23 ch&acirc;u &Aacute; 2018, v&agrave;o đến b&aacute;n kết ASIAD 18, v&ocirc; địch AFF Cup 2018, c&oacute; mặt ở tứ kết Asian Cup 2019 hay mới đ&acirc;y nhất l&agrave; c&ugrave;ng U23 Việt Nam đại thắng U23 Th&aacute;i Lan 4-0 để gi&agrave;nh v&eacute; ch&iacute;nh thức dự VCK giải U23 ch&acirc;u &Aacute; đầu năm sau.</p>\n\n<p>Kh&ocirc;ng chỉ l&agrave; ng&ocirc;i sao số 1 hiện tại của b&oacute;ng đ&aacute; Việt Nam, Quang Hải c&ograve;n nhận được sự y&ecirc;u mến của đ&ocirc;ng đảo người h&acirc;m mộ nước nh&agrave; v&igrave; sự trưởng th&agrave;nh vượt bậc về suy nghĩ v&agrave; h&agrave;nh động c&oacute; tr&aacute;ch nhiệm với m&ocirc;i trường cộng đồng d&ugrave; anh mới 21 tuổi.</p>\n\n<p>Ở Quang Hải, người ta lu&ocirc;n thấy một ch&agrave;ng thanh ni&ecirc;n vui vẻ, với nụ cười tươi r&oacute;i, gương mặt cương nghị nhưng lại v&ocirc; c&ugrave;ng th&acirc;n thiện, kh&ocirc;ng hề mắc &ldquo;bệnh ng&ocirc;i sao&rdquo;, chảnh chọe v&agrave; kh&ocirc;ng hề &ldquo;ngủ qu&ecirc;n tr&ecirc;n chiến thắng&rdquo;. Thay v&agrave;o đ&oacute; l&agrave; một cầu thủ t&agrave;i năng nhưng lu&ocirc;n cầu tiến, kh&aacute;t khao ho&agrave;n thiện m&igrave;nh như đ&uacute;ng tinh thần anh đ&atilde; đề ra: &ldquo;Ở mỗi giải đấu, t&ocirc;i lu&ocirc;n cố gắng thể hiện được một điều g&igrave; đ&oacute;.&rdquo;</p>\n\n<p><img alt=\"\" src=\"https://cdn.24h.com.vn/upload/2-2019/images/2019-04-11/Quang-Hai-Khi-Qua-bong-Vang-Viet-Nam-lam-dai-su-bao-ve-moi-truong-qua-bong-vang--2--1554969263-260-width660height440.jpg\" style=\"height:440px; width:660px\" /></p>\n\n<p>Quang Hải đ&atilde; đi ti&ecirc;n phong giới thiệu một d&ograve;ng nh&atilde;n hiệu d&agrave;nh cho c&aacute;c sản phẩm vi sinh ph&acirc;n hủy rất th&acirc;n thiết với m&ocirc;i trường, bao gồm: c&aacute;c loại t&uacute;i vi sinh tự hủy ho&agrave;n to&agrave;n (t&uacute;i thực phẩm, t&uacute;i c&oacute; quai, t&uacute;i đựng r&aacute;c), dao-th&igrave;a-nĩa, găng tay vi sinh tự hủy, ống h&uacute;t vi sinh tự hủy v&agrave; cốc giấy vi sinh tự hủy v&agrave; sắp tới l&agrave; găng tay vi sinh tự hủy.</p>\n\n<p>D&ograve;ng sản phẩm tự hủy m&agrave; Quang Hải giới thiệu c&oacute; sự kh&aacute;c biệt đ&aacute;ng kể so với c&aacute;c sản phẩm gắn m&aacute;c &ldquo;tự hủy&rdquo; kh&aacute;c tr&ecirc;n thị trường khi ch&uacute;ng được l&agrave;m ho&agrave;n to&agrave;n từ tinh bột ng&ocirc;, nguy&ecirc;n liệu tự hủy nhập khẩu từ Đức, ph&acirc;n hủy ho&agrave;n to&agrave;n th&agrave;nh c&aacute;c th&agrave;nh phần hữu cơ, nước, CO2 v&agrave; m&ugrave;n sinh học c&oacute; thể nu&ocirc;i c&acirc;y trong v&ograve;ng 6 th&aacute;ng đến 1 năm m&agrave; kh&ocirc;ng g&acirc;y &ocirc; nhiễm m&ocirc;i trường.</p>\n\n<p>Trong khi đ&oacute;, c&aacute;c sản phẩm tự hủy kh&aacute;c tr&ecirc;n thị trường lại bị pha trộn nhựa PP, hạt phụ gia, &hellip; chứ kh&ocirc;ng phải sử dụng 100% nguy&ecirc;n liệu tự hủy compostable n&ecirc;n kh&oacute; ph&acirc;n hủy v&agrave; khi ph&acirc;n hủy vẫn th&agrave;nh c&aacute;c vi nhựa h&ograve;a lẫn trong đất v&agrave; ảnh hưởng đến m&ocirc;i trường tương tự như t&uacute;i nilon th&ocirc;ng thường.</p>\n', 'admin', '2019-04-18 00:00:00', 0, 'Nguyễn Quang Hải đã thể hiện phong độ rực sáng giúp bóng đá Việt Nam có được rất nhiều thành tựu đáng tự hào từ năm ngoái đến nay. Ngôi sao đạt danh hiệu “Quả bóng Vàng 2018” còn vừa gây chú ý với việc trở thành Đại sứ bảo vệ môi trường của thương hiệu AnEco (thuộc Tập đoàn An Phát Holdings) và góp phần tích cực trong việc khuyến khích cộng đồng sử dụng các sản phẩm tự phân hủy thay thế túi nhựa, túi nilon.'),
(12, 1, 'Everton - MU: Tỷ số kinh hoàng, 4 bàn sấp mặt', '<p>Sau thất bại trước Barcelona ở&nbsp;<a href=\"https://www.24h.com.vn/cup-c1-champions-league-c153.html\">Champions League</a>,&nbsp;MU h&agrave;nh qu&acirc;n&nbsp;đến s&acirc;n Goodison Park trong t&acirc;m thế cực kỳ&nbsp;bất an.&nbsp;</p>\n\n<p><img alt=\"\" src=\"https://cdn.24h.com.vn/upload/2-2019/images/2019-04-21/Video-ket-qua-bong-da-Everton---MU-c5-1555853459-149-width660height462.jpg\" style=\"height:462px; width:660px\" /></p>\n\n<p>Điều n&agrave;y được thể hiện r&otilde; trong những ph&uacute;t đầu ti&ecirc;n, đo&agrave;n qu&acirc;n Solskjaer chơi l&eacute;p vế ho&agrave;n to&agrave;n trước&nbsp;<a href=\"https://www.24h.com.vn/everton-fc-c48e4442.html\">Everton</a>. Kết cục tất yếu xảy ra v&agrave;o ph&uacute;t 13, Richarlison c&oacute; pha tung người m&oacute;c b&oacute;ng đẹp mắt, mở tỷ số trận đấu.</p>\n\n<p>Chỉ&nbsp;15 ph&uacute;t sau, Everton tiếp tục gieo sầu cho đội kh&aacute;ch với&nbsp;c&uacute; s&uacute;t xa đập đất của&nbsp;Sigurdsson. Trong qu&atilde;ng thời gian c&ograve;n lại của hiệp 1,&nbsp;<a href=\"https://www.24h.com.vn/manchester-united-c48e1521.html\">MU</a>&nbsp;tiếp tục chơi bế tắc v&agrave; kh&ocirc;ng thể t&igrave;m được b&agrave;n r&uacute;t ngắn tỷ số.&nbsp;</p>\n\n<p>Sau giờ nghỉ, cục diện trận đấu kh&ocirc;ng&nbsp;c&oacute; g&igrave; thay đổi khi chủ nh&agrave; Everton vẫn l&agrave; những người chơi hay hơn. Ph&uacute;t 56, Lucas Digne tung c&uacute; s&uacute;t&nbsp;qua rừng cầu thủ v&agrave; găm thẳng v&agrave;o g&oacute;c xa b&ecirc;n tr&aacute;i khung th&agrave;nh MU. Trong t&igrave;nh huống n&agrave;y, De Gea chỉ biết đứng ch&ocirc;n ch&acirc;n.</p>\n\n<p>Nhận 3 b&agrave;n thua, bi kịch vẫn chưa dừng lại với MU. V&agrave;o ph&uacute;t thứ&nbsp;64,&nbsp;Walcott ph&aacute; bẫy việt vị tho&aacute;t xuống đ&aacute;nh bại De Gea, n&acirc;ng tỷ số l&ecirc;n 4-0. Qu&atilde;ng thời gian cuối trận, &quot;Quỷ đỏ&quot; với tinh thần suy sụp kh&ocirc;ng thể c&oacute; được b&agrave;n gỡ danh dự.</p>\n\n<p>Với kết quả n&agrave;y, đo&agrave;n qu&acirc;n Solskjaer đang gặp bất lợi cực lớn trong cuộc đua đến Top 4 khi tiếp tục&nbsp;giậm ch&acirc;n tại chỗ ở vị tr&iacute; thứ 6 với 64 điểm.</p>\n\n<p><strong>Tỷ số trận đấu:</strong>&nbsp;Everton 4-0&nbsp;MU&nbsp;(H1: 2-0)&nbsp;</p>\n\n<p><strong>Ghi b&agrave;n:</strong></p>\n\n<p>Richarlison (13&#39;),&nbsp;Sigurdsson (28&#39;),&nbsp;Digne (56&#39;),&nbsp;Walcott (64&#39;)</p>\n\n<p><strong>Đội h&igrave;nh xuất ph&aacute;t:</strong></p>\n\n<p>Everton:&nbsp;Pickford, Coleman, Digne, Zouma, Keane, Schneiderlin, &nbsp;Sigur&eth;sson, Gueye, Bernard, Calvert-Lewin, Richarlison</p>\n\n<p>MU:&nbsp;De Gea, Smalling, Jones, Lindelof, Diogo Dalot, Matic, Pogba, Fred, Lukaku, Martial, Rashford</p>\n', 'admin', '2019-04-22 00:00:00', 0, 'Kết quả bóng đá Everton - MU, vòng 35 Ngoại hạng Anh) Với tinh thần thi đấu thảm hại, đoàn quân Solskjaer đã có một trận đấu đáng quên trên sân Goodison Park.'),
(13, 1, 'Quảng Ninh thắng tưng bừng, đội nhà bầu Tam chơi đẹp cả trong lẫn ngoài sân cỏ', '<p>Trở về s&acirc;n nh&agrave; tiếp S&agrave;i G&ograve;n, đội b&oacute;ng chơi kh&aacute; tốt trong thời gian gần đ&acirc;y, Quảng Ninh tr&agrave;n đầy kh&iacute; thế quyết t&acirc;m lấy điểm khi nhận được sự ủng hộ của l&atilde;nh đạo, sự cổ vũ nhiệt t&igrave;nh của fan v&ugrave;ng Mỏ, đặc biệt sự quan t&acirc;m đặc biệt của &ocirc;ng bầu Phạm Văn Tam, Chủ tịch Tập đo&agrave;n Asanzo, nh&agrave; t&agrave;i trợ lớn của CLB.</p>\n\n<p><img alt=\"\" src=\"https://cdn.24h.com.vn/upload/2-2019/images/2019-04-21/Quang-Ninh-thang-tung-bung-doi-nha-bau-Tam-choi-dep-ca-trong-lan-ngoai-san-co-pvt_4605-1555818905-610-width660height440.jpg\" style=\"height:440px; width:660px\" /></p>\n\n<p>Với phong độ tốt của Dyachenko v&agrave; c&aacute;c trụ cột, đội qu&acirc;n của HLV Phan Thanh H&ugrave;ng đ&atilde; tạo được thế trận chắc chắn để c&oacute; nhiều cơ hội g&acirc;y s&oacute;ng gi&oacute; trước khung th&agrave;nh S&agrave;i G&ograve;n. Quảng Ninh sớm c&oacute; b&agrave;n thắng dẫn trước do c&ocirc;ng của&nbsp;Dyachenko ở ph&uacute;t thứ 9. Một ngoại binh kh&aacute;c l&agrave; Yao Hermann nh&acirc;n đ&ocirc;i c&aacute;ch biệt cho Quảng Ninh ph&uacute;t 29 v&agrave; ch&iacute;nh Dyachenko ghi th&ecirc;m b&agrave;n thắng ở hiệp 2 để ấn định trận thắng đậm 3-0 cho đội chủ nh&agrave;.&nbsp;</p>\n\n<p><img alt=\"\" src=\"https://cdn.24h.com.vn/upload/2-2019/images/2019-04-21/Quang-Ninh-thang-tung-bung-doi-nha-bau-Tam-choi-dep-ca-trong-lan-ngoai-san-co-pvt_4613-1555818905-390-width660height440.jpg\" style=\"height:440px; width:660px\" /></p>\n\n<p>Tinh thần thi đấu đến c&ugrave;ng của c&aacute;c cầu thủ Quảng Ninh đ&atilde; nhận được sự cổ vũ nhiệt t&igrave;nh của cổ động vi&ecirc;n đất Mỏ. Đến s&acirc;n xem b&oacute;ng đ&aacute;, lại nhận được phần qu&agrave; l&agrave; quạt l&agrave;m m&aacute;t giữa trời h&egrave; n&oacute;ng nực của Asanzo, fan Quảng Ninh như được tận hưởng niềm vui nh&acirc;n đ&ocirc;i.</p>\n\n<p>1 ng&agrave;y trước giờ thi đấu với S&agrave;i G&ograve;n, c&aacute;c cầu thủ Quảng Ninh c&ograve;n &ldquo;ghi điểm&rdquo; ấn tượng kh&ocirc;ng k&eacute;m với người h&acirc;m mộ khi họ c&ugrave;ng &ocirc;ng bầu Phạm Văn Tam tham gia thử th&aacute;ch dọn r&aacute;c tr&ecirc;n biển Cẩm Phả (Quảng Ninh). Đ&acirc;y l&agrave; hoạt động đang được hưởng ứng khắp nơi tr&ecirc;n thế giới v&agrave; cả ở Việt Nam nhằm tạo ra phong tr&agrave;o s&acirc;u rộng trong cộng đồng, chung tay l&agrave;m sạch m&ocirc;i trường.</p>\n', 'admin', '2019-04-22 00:00:00', 0, 'Hai ngày cuối tuần, CLB Quảng Ninh thời ông bầu Phạm Văn Tam nhận niềm vui lớn khi họ nỗ lực hết mình cả trong và ngoài sân cỏ.'),
(14, 1, 'Đại tiệc F1 Việt Nam Grand Prix: Trải nghiệm tốc độ mãn nhãn tại Hà Nội', '<p>Cuối tuần qua, sự kiện &ldquo;Khởi động Formula 1 Việt Nam Grand Prix&rdquo; đ&atilde; mang đến cho kh&aacute;n giả m&agrave;n tr&igrave;nh diễn tốc độ ngoạn mục của những chiếc xe đua F1 thực thụ được điều khiển bởi tay đua F1 huyền thoại David Coulthard c&ugrave;ng c&ugrave;ng tay đua Jake Dennis của đội Aston Martin Red Bull. Đ&acirc;y l&agrave; sự kiện do Sở Văn h&oacute;a v&agrave; Thể thao H&agrave; Nội (Ủy ban Nh&acirc;n d&acirc;n h&agrave;nh phố H&agrave; Nội), C&ocirc;ng ty Việt Nam Grand Prix (VGPC) c&ugrave;ng với Heineken Việt Nam</p>\n\n<p>Hơn chục ngh&igrave;n kh&aacute;n giả c&oacute; mặt tại khu vực s&acirc;n Mỹ Đ&igrave;nh được trực tiếp ngắm nh&igrave;n v&agrave; trải nghiệm tốc độ, &acirc;m thanh v&agrave; những m&agrave;n &ldquo;drift&rdquo; kinh điển của những chiếc xe F1 huyền thoại ngay ch&iacute;nh &nbsp;tại&nbsp; đường đua tương lai ch&iacute;nh thức của Việt Nam &ndash; Đường đua C&ocirc;ng thức 1 H&agrave; Nội.</p>\n\n<p><img alt=\"\" src=\"https://cdn.24h.com.vn/upload/2-2019/images/2019-04-22/dai-tiec-F1-Viet-Nam-Grand-Prix-Trai-nghiem-toc-do-man-nhan-tai-Ha-Noi-armin-trai-nghiem-cung-f1-selected-1555894265-133-width660height441.jpg\" style=\"height:441px; width:660px\" /></p>\n\n<p>Đặc biệt, kh&aacute;n giả tại sự kiện c&ograve;n được gặp gỡ, giao lưu trực tiếp với huyền thoại F1 David Coulthard v&agrave; đội đua Aston Martin Red Bull. Với 13 lần chiến thắng Grand Prix đồng thời l&agrave; Đại sứ F1 của nh&atilde;n hiệu Heineken, David Coulthard chia sẻ: &ldquo;Đ&acirc;y l&agrave; lần thứ hai t&ocirc;i được c&ugrave;ng đội đua Aston Martin Red Bull tr&igrave;nh diễn tại Việt Nam. T&ocirc;i đặc biệt h&aacute;o hức khi Việt Nam sẽ đăng cai tổ chức Giải F1 Grand Prix ch&iacute;nh thức v&agrave;o năm tới&quot;.</p>\n\n<p>&nbsp;</p>\n\n<p>&quot;Đ&atilde; được tận mắt chứng kiến sự h&agrave;o hứng v&agrave; cuồng nhiệt của người h&acirc;m mộ Việt Nam d&agrave;nh cho F1, t&ocirc;i tin rằng Việt Nam sẽ trở th&agrave;nh một trong những giải đua hấp dẫn nhất thế giới v&agrave; được y&ecirc;u mến bởi đ&ocirc;ng đảo c&aacute;c tay đua v&agrave; đội đua F1.&rdquo;</p>\n\n<p>Đ&aacute;ng ch&uacute; &yacute;, m&agrave;n drift cực ấn tượng, những tiếng &ldquo;gầm th&eacute;t&rdquo; x&eacute; toang bầu kh&ocirc;ng kh&iacute; của hai tay đua F1 đội Red Bull, mang tới những cảm x&uacute;c rất th&uacute; vị với những người lần đầu trực tiếp xem&nbsp;<a href=\"https://www.24h.com.vn/dua-xe-f1-c118.html\">đua xe</a>&nbsp;c&ocirc;ng thức 1.<img alt=\"\" src=\"https://cdn.24h.com.vn/upload/2-2019/images/2019-04-22/dai-tiec-F1-Viet-Nam-Grand-Prix-Trai-nghiem-toc-do-man-nhan-tai-Ha-Noi-david-tung-co-vietnam-1555894265-834-width660height440.jpg\" /></p>\n\n<p>Huyền thoại F1 David Coulthard c&ugrave;ng Jake Dennis đ&atilde; ho&agrave;n th&agrave;nh hai lượt biểu diễn trước sự chứng kiến của h&agrave;ng chục ngh&igrave;n người dọc theo quảng trường trước cửa s&acirc;n vận động Mỹ Đ&igrave;nh. Chiếc xe thực hiện những m&agrave;n biểu diễn m&atilde;n nh&atilde;n như tăng tốc, drift.</p>\n\n<p>Tiếng gầm r&uacute; của cỗ m&aacute;y c&oacute; c&ocirc;ng suất gần 1.000 m&atilde; lực, c&ugrave;ng tiếng nhạc sống động, g&acirc;y ấn tượng đặc biệt cho đ&aacute;m đ&ocirc;ng. Đặc biệt, ở lượt biểu diễn cuối, hai chiếc xe song h&agrave;nh c&ugrave;ng biểu diễn. Một trong hai chiếc kết th&uacute;c m&agrave;n biểu diễn bằng c&uacute; drift nhiều v&ograve;ng tr&ograve;n li&ecirc;n tục. M&agrave;n biểu diễn tạo ra đ&aacute;m kh&oacute;i m&ugrave; mịt bao tr&ugrave;m chiếc xe.</p>\n\n<p>Sau khi kết th&uacute;c m&agrave;n biểu diễn, David Coulthard đứng l&ecirc;n chiếc F1 vẫy ch&agrave;o kh&aacute;n giả. David Coulthard b&agrave;y tỏ cảm gi&aacute;c rất th&iacute;ch th&uacute; khi lần đầu được chạy xe tr&ecirc;n đường phố H&agrave; Nội. Sau c&ugrave;ng, tay đua từng đạt 13 chiến thắng Grand Prix v&agrave; 62 lần được vinh danh tr&ecirc;n bục nhận giải (Polium finish) trong suốt sự nghiệp gắn b&oacute; với đường đua F1, đ&atilde; cầm cờ Việt Nam, l&ecirc;n xe mui trần để đi cảm ơn người xem. Đ&acirc;y l&agrave; lần đầu ti&ecirc;n chiếc xe F1 chạy tr&ecirc;n đường H&agrave; Nội, trước khi chặng đua ch&iacute;nh thức dự kiến sẽ khởi tranh v&agrave;o th&aacute;ng 4/2020.</p>\n\n<p>Đường đua F1 Việt Nam được khởi c&ocirc;ng th&aacute;ng 3/2019, dự kiến ho&agrave;n tất sau 12 th&aacute;ng. Đường đua d&agrave;i khoảng 5,5km, gồm 22 g&oacute;c cua được thiết kế lấy cảm hứng từ những đường đua hấp dẫn nhất thế giới ở Đức, Monaco hay Nhật Bản. Ban tổ chức đ&atilde; c&ocirc;ng bố ch&iacute;nh s&aacute;ch gi&aacute; v&eacute; cho cuộc đua năm sau. Theo đ&oacute;, c&oacute; c&aacute;c loại v&eacute; doanh nghiệp, v&eacute; kh&aacute;n đ&agrave;i v&agrave; v&eacute; phổ th&ocirc;ng. Tổng cộng, c&oacute; 5.565 tấm v&eacute; sắp được mở b&aacute;n, với ưu đ&atilde;i cho những người mua đầu ti&ecirc;n.</p>\n\n<p><strong>Đại tiệc đẳng cấp của huyền thoại F1 v&agrave; ng&ocirc;i sao ca nhạc</strong></p>\n', 'admin', '2019-04-22 00:00:00', 0, 'Được tận mắt chứng kiến những chiếc xe F1 siêu tốc độ được trình diễn bởi huyền thoại F1 ngay tại sân Mỹ Đình, người hâm mộ đã được tận hưởng bữa tiệc đẳng cấp bởi sự kiện “Khởi động Formula 1 Việt Nam Grand Prix”.'),
(16, 1, 'Tổng giám đốc Nhật Cường bị cáo buộc cầm đầu tội phạm có tổ chức', '<p>Ng&agrave;y 14/5,&nbsp;Cơ quan Cảnh s&aacute;t điều tra tội phạm về kinh tế, tham nhũng, bu&ocirc;n lậu (C03, Bộ C&ocirc;ng an) khởi tố vụ &aacute;n, khởi tố bị can, ra lệnh bắt tạm giam, kh&aacute;m x&eacute;t với B&ugrave;i Quang Huy, 45 tuổi, Tổng gi&aacute;m đốc C&ocirc;ng ty TNHH Thương mại v&agrave; Dịch vụ kỹ thuật Nhật Cường, để điều tra về tội&nbsp;<em>Bu&ocirc;n lậu&nbsp;</em>theo khoản 4 điều 188 Bộ luật H&igrave;nh sự 2015 v&agrave; tội&nbsp;<em>Vi phạm quy định về kế to&aacute;n g&acirc;y hậu quả nghi&ecirc;m trọng,&nbsp;</em>theo điều 211 Bộ luật H&igrave;nh sự 2015.</p>\n\n<p>Li&ecirc;n quan vụ &aacute;n, 8 người kh&aacute;c bị khởi tố, tạm giam về c&ugrave;ng tội danh với vai tr&ograve; đồng phạm.&nbsp;Cơ quan điều tra c&aacute;o buộc &ocirc;ng Huy cầm đầu đường d&acirc;y tội phạm c&oacute; tổ chức. &Ocirc;ng&nbsp;v&agrave; c&aacute;c đồng phạm đ&atilde; thực hiện h&agrave;nh vi phạm tội bu&ocirc;n lậu xuy&ecirc;n quốc gia; lập, sử dụng hai hệ thống sổ s&aacute;ch kế to&aacute;n nhằm để ngo&agrave;i sổ s&aacute;ch h&agrave;ng ngh&igrave;n tỷ đồng doanh thu.</p>\n\n<p>Trong th&ocirc;ng b&aacute;o khởi tố, nh&agrave; chức tr&aacute;ch cho hay đ&atilde; thu giữ h&agrave;ng ngh&igrave;n điện thoại di động, iPad, phụ kiện điện tử c&aacute;c loại...</p>\n\n<p><img alt=\"\" src=\"https://i-vnexpress.vnecdn.net/2019/05/14/nhat-cuong-cong-an-kham-xet-22-6883-2011-1557843202.jpg\" style=\"height:474px; width:750px\" /></p>\n\n<p>Năm ng&agrave;y trước, h&ocirc;m 9/5, C03 đ&atilde; kh&aacute;m x&eacute;t&nbsp;9 cửa h&agrave;ng, trung t&acirc;m bảo h&agrave;nh thuộc Nhật Cường Mobile. Cơ quan điều tra đưa h&agrave;ng chục th&ugrave;ng c&aacute;c-t&ocirc;ng ni&ecirc;m phong ra khỏi c&aacute;c cửa h&agrave;ng.&nbsp;Chuỗi Nhật Cường Mobile đ&oacute;ng cửa từ h&ocirc;m đ&oacute;.&nbsp;</p>\n\n<p>C03 th&ocirc;ng b&aacute;o đang mở rộng vụ &aacute;n để điều tra vai tr&ograve;, h&agrave;nh vi phạm tội của 9 bị can v&agrave; những người c&oacute; li&ecirc;n quan; sẽ x&aacute;c minh để thu hồi, k&ecirc; bi&ecirc;n triệt để t&agrave;i sản cho Nh&agrave; nước.</p>\n\n<p>Với tội&nbsp;<em>Bu&ocirc;n lậu</em>, &ocirc;ng Huy v&agrave; 8 đồng phạm bị khởi tố theo khung h&igrave;nh phạt từ 12 đến 20 năm t&ugrave;; tội&nbsp;<em>Vi phạm quy định về kế to&aacute;n g&acirc;y hậu quả nghi&ecirc;m trọng&nbsp;</em>c&oacute;khung h&igrave;nh phạt từ 3 đến 12 năm.</p>\n\n<p>Nhật Cường Mobile l&agrave; thương hiệu thuộc sở hữu của C&ocirc;ng ty TNHH Thương mại v&agrave; Dịch vụ kỹ thuật Nhật Cường, hoạt động từ năm 2001 với tiền th&acirc;n l&agrave; cửa h&agrave;ng sửa chữa điện thoại. Hệ thống c&oacute; 9 cửa h&agrave;ng b&aacute;n lẻ tại H&agrave; Nội, một trung t&acirc;m bảo h&agrave;nh v&agrave; một trung t&acirc;m ERP tại TP HCM.</p>\n', 'Lê Công Dũng', '2019-05-15 00:00:00', 0, 'Ông Bùi Quang Huy bị khởi tố, ra lệnh bắt tạm giam với cáo buộc buôn lậu xuyên quốc gia, giấu doanh thu hàng nghìn tỷ đồng. '),
(18, 1, 'Trụ sở mới độc đáo của Viettel nhìn từ trên cao', '<p><img alt=\"\" src=\"https://zNews-photo.zadn.vn/w1024/Uploaded/ovhunut/2019_05_30/map_hoasen.jpg\" style=\"height:578px; width:1024px\" />Trụ sở mới của Viettel nằm ở l&ocirc; D26, khu đ&ocirc; thị mới Cầu Giấy,&nbsp;<a href=\"https://News.zing.vn/tieu-diem/ha-noi.html\">H&agrave; Nội</a>. Trước mặt dự &aacute;n l&agrave; khu đất rộng 32 ha được quy hoạch l&agrave;m c&ocirc;ng vi&ecirc;n hồ điều h&ograve;a CV1, với 19 ha diện t&iacute;ch mặt nước (ảnh chụp năm 2018).</p>\n\n<p><img alt=\"\" src=\"https://zNews-photo.zadn.vn/w1024/Uploaded/ovhunut/2019_05_30/trusoViettel_1.jpg\" style=\"height:660px; width:959px\" /><img alt=\"\" src=\"https://zNews-photo.zadn.vn/w1024/Uploaded/ovhunut/2019_05_30/1_zing.jpg\" style=\"height:682px; width:1024px\" />Trụ sở mới tập đo&agrave;n n&agrave;y với kiến tr&uacute;c độc đ&aacute;o đang được ho&agrave;n thiện, chuẩn bị đi v&agrave;o vận h&agrave;nh, khai th&aacute;c.&nbsp;</p>\n', 'admin', '2019-06-04 00:00:00', 0, 'Tòa nhà trụ sở mới của Tập đoàn Công nghiệp - Viễn thông Quân đội (Viettel), tọa lạc tại lô D26 khu đô thị mới Cầu Giấy (Hà Nội), nhìn thẳng ra công viên hồ điều hòa rộng 32 ha.');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '0',
  `password` varchar(50) NOT NULL DEFAULT '0',
  `role` varchar(50) NOT NULL DEFAULT '0',
  `hovaten` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `role`, `hovaten`) VALUES
(124, 'admin', 'MTIzNDU2', 'ROLE_ADMIN', 'admin'),
(225, '043211', 'MTIzNDU2', 'ROLE_ADMIN', 'Lê Thị Thanh Thoảng'),
(226, '175662', 'MzAzNDU0', 'ROLE_USER', 'Nguyễn Thị Thanh'),
(227, '042971', 'MTIzNDU2', 'ROLE_USER', 'Trần Trung Hưng'),
(228, '011350', 'ODY1Mzg4', 'ROLE_USER', 'Nguyễn Hoàng Long'),
(229, '013969', 'NTk3NzYy', 'ROLE_USER', 'Chu Kim Thoa'),
(230, '015282', 'MzM3NDI3', 'ROLE_USER', 'Nguyễn Đắc Luân'),
(231, '022917', 'MzI0NjU0', 'ROLE_USER', 'Đinh Thanh Sơn'),
(232, '064660', 'NzUxNzg4', 'ROLE_USER', 'Nguyễn Chí Kiên'),
(233, '111', 'MTIzNDU2', 'ROLE_USER', 'Nguyễn Duy Hưng'),
(234, '112', 'ODgyMDI2', 'ROLE_USER', 'Nguyễn Văn A'),
(235, '113', 'NDkzNzY2', 'ROLE_USER', 'Nguyễn Văn B'),
(236, '012130', 'MDA1MzA4', 'ROLE_USER', 'Nguyễn Ngọc Anh'),
(239, 'A2019', 'Njk0NjY2', 'ROLE_USER', 'Barack Obama'),
(240, 'A20191', 'MDAzOTI0', 'ROLE_USER', 'Cristano Ronaldo');

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `Comment_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `Comment_ibfk_2` FOREIGN KEY (`NewsID`) REFERENCES `news` (`ID`);

--
-- Các ràng buộc cho bảng `file_news`
--
ALTER TABLE `file_news`
  ADD CONSTRAINT `File_News_ibfk_1` FOREIGN KEY (`NewsID`) REFERENCES `news` (`ID`);

--
-- Các ràng buộc cho bảng `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `FK_cate` FOREIGN KEY (`CateID`) REFERENCES `category` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
