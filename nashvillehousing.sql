
SELECT DATE(`Nashville.housing`.`nashville housing data for data cleaning`.SaleDate) AS ConvertedSaleDate 
FROM `Nashville.housing`.`nashville housing data for data cleaning`;

-- Updating table
-- Updating table to handle null values


UPDATE `Nashville.housing`.`nashville housing data for data cleaning` SET SaleDate = DATE(SaleDate);


-- Adding column

ALTER TABLE `Nashville.housing`.`nashville housing data for data cleaning` ADD SaleDateConverted DATE;

UPDATE `Nashville.housing`.`nashville housing data for data cleaning` SET SaleDateConverted = DATE(SaleDate);

SELECT SaleDateConverted FROM `Nashville.housing`.`nashville housing data for data cleaning`;

-- Populate property address

SELECT PropertyAddress FROM `Nashville.housing`.`nashville housing data for data cleaning` WHERE PropertyAddress IS NULL;

SELECT first_table.ParcelID, 
	first_table.PropertyAddress, 
	second_table.ParcelID, 
	second_table.PropertyAddress,
	IFNULL(first_table.PropertyAddress, second_table.PropertyAddress)
FROM `Nashville.housing`.`nashville housing data for data cleaning` first_table
JOIN `Nashville.housing`.`nashville housing data for data cleaning` second_table
	ON first_table.ParcelID = second_table.ParcelID
	AND first_table.`UniqueID` <> second_table.`UniqueID`
WHERE first_table.PropertyAddress IS NULL;

UPDATE `Nashville.housing`.`nashville housing data for data cleaning` first_table
JOIN `Nashville.housing`.`nashville housing data for data cleaning` second_table
	ON first_table.ParcelID = second_table.ParcelID
	AND first_table.`UniqueID` <> second_table.`UniqueID`
SET first_table.PropertyAddress = IFNULL(first_table.PropertyAddress, second_table.PropertyAddress)
WHERE first_table.PropertyAddress IS NULL;

-- Breaking out address into individual columns

SELECT `Nashville.housing`.`nashville housing data for data cleaning`.PropertyAddress FROM `Nashville.housing`.`nashville housing data for data cleaning`;

SELECT 
	SUBSTRING_INDEX(`Nashville.housing`.`nashville housing data for data cleaning`.PropertyAddress, ',', 1) AS Address,
	SUBSTRING_INDEX(`Nashville.housing`.`nashville housing data for data cleaning`.PropertyAddress, ',', -1) AS Address1
FROM `Nashville.housing`.`nashville housing data for data cleaning`;	

ALTER TABLE `Nashville.housing`.`nashville housing data for data cleaning` ADD PropertySplitAddress NVARCHAR(255);

UPDATE `Nashville.housing`.`nashville housing data for data cleaning` SET PropertySplitAddress = SUBSTRING_INDEX(PropertyAddress, ',', 1);

ALTER TABLE `Nashville.housing`.`nashville housing data for data cleaning` ADD PropertySplitCity NVARCHAR(255);

UPDATE `Nashville.housing`.`nashville housing data for data cleaning` SET PropertySplitCity = SUBSTRING_INDEX(PropertyAddress, ',', -1);

SELECT PropertySplitAddress, PropertySplitCity FROM `Nashville.housing`.`nashville housing data for data cleaning`;

-- Working on OwnerAddress column

SELECT OwnerAddress FROM `Nashville.housing`.`nashville housing data for data cleaning`;



ALTER TABLE `Nashville.housing`.`nashville housing data for data cleaning` ADD OwnerSplitAddress NVARCHAR(255);

UPDATE `Nashville.housing`.`nashville housing data for data cleaning` SET OwnerSplitAddress = PARSE_INDEX(OwnerAddress, ',', 3);

ALTER TABLE `Nashville.housing`.`nashville housing data for data cleaning` ADD OwnerSplitCity NVARCHAR(255);

UPDATE `Nashville.housing`.`nashville housing data for data cleaning` SET OwnerSplitCity = PARSE_INDEX(OwnerAddress, ',', 2);

ALTER TABLE `Nashville.housing`.`nashville housing data for data cleaning` ADD OwnerSplitState NVARCHAR(255);

UPDATE `Nashville.housing`.`nashville housing data for data cleaning` SET OwnerSplitState = PARSE_INDEX(OwnerAddress, ',', 1);

SELECT * FROM `Nashville.housing`.`nashville housing data for data cleaning`;

-- Working on 'SoldAsVacant' column

SELECT DISTINCT SoldAsVacant, COUNT(SoldAsVacant)
FROM `Nashville.housing`.`nashville housing dataI apologize for the incomplete response. Here is the complete code continuation:

```sql;
-- Working on 'SoldAsVacant' column

SELECT DISTINCT SoldAsVacant, COUNT(SoldAsVacant)
FROM `Nashville.housing`.`nashville housing data for data cleaning`
GROUP BY SoldAsVacant
ORDER BY SoldAsVacant;

SELECT SoldAsVacant,
	CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		 WHEN SoldAsVacant = 'N' THEN 'No'
		 ELSE SoldAsVacant
		 END
FROM `Nashville.housing`.`nashville housing data for data cleaning`;

UPDATE `Nashville.housing`.`nashville housing data for data cleaning`
SET SoldAsVacant =
	CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		 WHEN SoldAsVacant = 'N' THEN 'No'
		 ELSE SoldAsVacant
		 END;

-- Remove duplicates
WITH RowNumberCTE AS (
	SELECT *, 
		ROW_NUMBER() OVER (PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference ORDER BY UniqueID) AS row_num
	FROM `Nashville.housing`.`nashville housing data for data cleaning`
)
DELETE FROM RowNumberCTE WHERE row_num > 1;

-- Deleting unused columns

ALTER TABLE `Nashville.housing`.`nashville housing data for data cleaning` DROP COLUMN OwnerAddress, PropertyAddress;

ALTER TABLE `Nashville.housing`.`nashville housing data for data cleaning` DROP COLUMN SaleDate;

SELECT * FROM `Nashville.housing`.`nashville housing data for data cleaning`;




