CREATE USER IF NOT EXISTS batch_user IDENTIFIED BY 'yasuyuki';

CREATE DATABASE IF NOT EXISTS batch_processing_for_rails_dev DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

GRANT ALL PRIVILEGES on batch_processing_for_rails_dev.* to batch_user;

CREATE DATABASE IF NOT EXISTS batch_processing_for_rails_test DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;

GRANT ALL PRIVILEGES on batch_processing_for_rails_test.* to batch_user;
