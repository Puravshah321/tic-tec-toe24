--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `classroom_attendance`
--

DROP TABLE IF EXISTS `classroom_attendance`;
CREATE TABLE `classroom_attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `is_present` tinyint(1) NOT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_attendance_student_id_5f5e5f5f_fk_classroom_student_id` (`student_id`),
  CONSTRAINT `classroom_attendance_student_id_5f5e5f5f_fk_classroom_student_id` FOREIGN KEY (`student_id`) REFERENCES `classroom_student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `classroom_classassignment`
--

DROP TABLE IF EXISTS `classroom_classassignment`;
CREATE TABLE `classroom_classassignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `assignment_name` varchar(255) NOT NULL,
  `assignment` varchar(255) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_classassignment_teacher_id_5f5e5f5f_fk_classroom_teacher_id` (`teacher_id`),
  CONSTRAINT `classroom_classassignment_teacher_id_5f5e5f5f_fk_classroom_teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `classroom_teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `classroom_classassignment_student`
--

DROP TABLE IF EXISTS `classroom_classassignment_student`;
CREATE TABLE `classroom_classassignment_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
 `classassignment_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `classroom_classassignment_student_classassignment_id_student_id_5f5e5f5f_uniq` (`classassignment_id`,`student_id`),
  KEY `classroom_classassignment_student_student_id_5f5e5f5f_fk_classroom_student_id` (`student_id`),
  CONSTRAINT `classroom_classassignment_student_classassignment_id_5f5e5f5f_fk_classroom_classassignment_id` FOREIGN KEY (`classassignment_id`) REFERENCES `classroom_classassignment` (`id`),
  CONSTRAINT `classroom_classassignment_student_student_id_5f5e5f5f_fk_classroom_student_id` FOREIGN KEY (`student_id`) REFERENCES `classroom_student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `classroom_classnotice`
--

DROP TABLE IF EXISTS `classroom_classnotice`;
CREATE TABLE `classroom_classnotice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `message` varchar(255) NOT NULL,
  `message_html` varchar(255) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_classnotice_teacher_id_5f5e5f5f_fk_classroom_teacher_id` (`teacher_id`),
  CONSTRAINT `classroom_classnotice_teacher_id_5f5e5f5f_fk_classroom_teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `classroom_teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `classroom_classnotice_students`
--

DROP TABLE IF EXISTS `classroom_classnotice_students`;
CREATE TABLE `classroom_classnotice_students` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `classnotice_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `classroom_classnotice_students_classnotice_id_student_id_5f5e5f5f_uniq` (`classnotice_id`,`student_id`),
  KEY `classroom_classnotice_students_student_id_5f5e5f5f_fk_classroom_student_id` (`student_id`),
  CONSTRAINT `classroom_classnotice_students_classnotice_id_5f5e5f5f_fk_classroom_classnotice_id` FOREIGN KEY (`classnotice_id`) REFERENCES `classroom_classnotice` (`id`),
  CONSTRAINT `classroom_classnotice_students_student_id_5f5e5f5f_fk_classroom_student_id` FOREIGN KEY (`student_id`) REFERENCES `classroom_student` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `classroom_messagetoteacher`
--

DROP TABLE IF EXISTS `classroom_messagetoteacher`;
CREATE TABLE `classroom_messagetoteacher` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `message` varchar(255) NOT NULL,
  `message_html` varchar(255) NOT NULL,
  `student_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_messagetoteacher_student_id_5f5e5f5f_fk_classroom_student_id` (`student_id`),
  KEY `classroom_messagetoteacher_teacher_id_5f5e5f5f_fk_classroom_teacher_id` (`teacher_id`),
  CONSTRAINT `classroom_messagetoteacher_student_id_5f5e5f5f_fk_classroom_student_id` FOREIGN KEY (`student_id`) REFERENCES `classroom_student` (`id`),
  CONSTRAINT `classroom_messagetoteacher_teacher_id_5f5e5f5f_fk_classroom_teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `classroom_teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `classroom_qrcodeattendance`
--

DROP TABLE IF EXISTS `classroom_qrcodeattendance`;
CREATE TABLE `classroom_qrcodeattendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qr_code_image` varchar(255) NOT NULL,
  `generated_at` datetime(6) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_qrcodeattendance_teacher_id_5f5e5f5f_fk_classroom_teacher_id` (`teacher_id`),
  CONSTRAINT `classroom_qrcodeattendance_teacher_id_5f5e5f5f_fk_classroom _teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `classroom_teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `classroom_student`
--

DROP TABLE IF EXISTS `classroom_student`;
CREATE TABLE `classroom_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `roll_no` int(11) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `username` varchar(150) NOT NULL,
  `password` varchar(128) NOT NULL,
  `student_profile_pic` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `classroom_studentmarks`
--

DROP TABLE IF EXISTS `classroom_studentmarks`;
CREATE TABLE `classroom_studentmarks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_name` varchar(255) NOT NULL,
  `marks_obtained` int(11) NOT NULL,
  `maximum_marks` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_studentmarks_student_id_5f5e5f5f_fk_classroom_student_id` (`student_id`),
  KEY `classroom_studentmarks_teacher_id_5f5e5f5f_fk_classroom_teacher_id` (`teacher_id`),
  CONSTRAINT `classroom_studentmarks_student_id_5f5e5f5f_fk_classroom_student_id` FOREIGN KEY (`student_id`) REFERENCES `classroom_student` (`id`),
  CONSTRAINT `classroom_studentmarks_teacher_id_5f5e5f5f_fk_classroom_teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `classroom_teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `classroom_studentsinclass`
--

DROP TABLE IF EXISTS `classroom_studentsinclass`;
CREATE TABLE `classroom_studentsinclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `classroom_studentsinclass_student_id_teacher_id_5f5e5f5f_uniq` (`student_id`,`teacher_id`),
  KEY `classroom_studentsinclass_teacher_id_5f5e5f5f_fk_classroom_teacher_id` (`teacher_id`),
  CONSTRAINT `classroom_studentsinclass_student_id_5f5e5f5f_fk_classroom_student_id` FOREIGN KEY (`student_id`) REFERENCES `classroom_student` (`id`),
  CONSTRAINT `classroom_studentsinclass_teacher_id_5f5e5f5f_fk_classroom_teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `classroom_teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `classroom_submitassignment`
--

DROP TABLE IF EXISTS `classroom_submitassignment`;
CREATE TABLE `classroom_submitassignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `submit` varchar(255) NOT NULL,
  `submitted_assignment_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `classroom_submitassignment_submitted_assignment_id_5f5e5f5f_fk_classroom_classassignment_id` (`submitted_assignment_id`),
  KEY `classroom_submitassignment_student_id_5f5e5f5f_fk_classroom_student_id` (`student_id`),
  KEY `classroom_submitassignment_teacher_id_5f5e5f5f_fk_classroom_teacher_id` (`teacher_id`),
  CONSTRAINT `classroom_submitassignment_student_id_5f5e5f5f_fk_classroom_student_id` FOREIGN KEY (`student_id`) REFERENCES `classroom_student` (`id`),
  CONSTRAINT `classroom_submitassignment_submitted_assignment_id_5f5e5f5f_fk_classroom_classassignment_id` FOREIGN KEY (`submitted_assignment_id`) REFERENCES `classroom_classassignment` (`id`),
  CONSTRAINT `classroom_submitassignment_teacher_id_5f5e5f5f_fk_classroom_teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `classroom_teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `classroom_teacher`
--

DROP TABLE IF EXISTS `classroom_teacher`;
CREATE TABLE `classroom_teacher` (
  ` id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `subject_name` varchar(255) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `username` varchar(150) NOT NULL,
  `password` varchar(128) NOT NULL,
  `teacher_profile_pic` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `classroom_user`
--

DROP TABLE IF EXISTS `classroom_user`;
CREATE TABLE `classroom_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `is_student` tinyint(1) NOT NULL,
  `is_teacher` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `classroom_user_groups`
--

DROP TABLE IF EXISTS `classroom_user_groups`;
CREATE TABLE `classroom_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `classroom_user_groups_user_id_group_id_5f5e5f5f_uniq` (`user_id`,`group_id`),
  KEY `classroom_user_groups_group_id_5f5e5f5f_fk_auth_group_id` (`group_id`),
  CONSTRAINT `classroom_user_groups_group_id_5f5e5f5f_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `classroom_user_groups_user_id_5f5e5f5f_fk_classroom_user_id` FOREIGN KEY (`user_id`) REFERENCES `classroom_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `classroom_user_user_permissions`
--

DROP TABLE IF EXISTS `classroom_user_user_permissions`;
CREATE TABLE `classroom_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `classroom_user_user_permissions_user_id_permission_id_5f5e5f5f_uniq` (`user_id`,`permission_id`),
  KEY `classroom_user_user_permissions_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `classroom_user_user_permissions_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `classroom_user_user_permissions_user_id_5f5e5f5f_fk_classroom_user_id` FOREIGN KEY (`user_id`) REFERENCES `classroom_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` int(11) DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `change_message` varchar(255) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_classroom_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_classroom_user_id` FOREIGN KEY (`user_id`) REFERENCES `classroom_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_61c3a763` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `sqlite_sequence`
--

DROP TABLE IF EXISTS `sqlite_sequence`;
CREATE TABLE `sqlite_sequence` (
  `name` varchar(255) NOT NULL,
  `seq` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;