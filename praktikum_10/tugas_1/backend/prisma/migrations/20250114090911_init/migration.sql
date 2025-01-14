-- CreateTable
CREATE TABLE `product_table` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `purchase_price` INTEGER NOT NULL,
    `selling_price` INTEGER NOT NULL,
    `stock` INTEGER NOT NULL,
    `date` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
