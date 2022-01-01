use Covid;

select * from NashvilleHousing;



------------------------------------------------------------------
-- standardize date format
------------------------------------------------------------------
select SaleDate, convert(date, SaleDate) as SaleDateConverted
from NashvilleHousing;

alter table NashvilleHousing
add SaleDateConverted date;

update NashvilleHousing
set SaleDateConverted = convert(date, SaleDate);

select SaleDate, SaleDateConverted, convert(date, SaleDateConverted)
from NashvilleHousing;



------------------------------------------------------------------
-- populate property address data
------------------------------------------------------------------
select *
from NashvilleHousing
where PropertyAddress is null;


select	
	a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress,
	ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
	on a.ParcelID = b.ParcelID and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null;


update a
set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
	on a.ParcelID = b.ParcelID and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null;


select PropertyAddress
from NashvilleHousing
where PropertyAddress is null;



------------------------------------------------------------------
-- breaking out address into individual columns: address, city, state
------------------------------------------------------------------
select PropertyAddress
from NashvilleHousing;


select 
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))  as City
from NashvilleHousing;


alter table NashvilleHousing
add PropertySplitAddress nvarchar(255), PropertySplitCity nvarchar(255);


select * from NashvilleHousing;


update NashvilleHousing
set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1);


update NashvilleHousing
set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress));



------------------------------------------------------------------
-- split owner address
------------------------------------------------------------------
select OwnerAddress
from NashvilleHousing;


select
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
from NashvilleHousing;


alter table NashvilleHousing
add 
	OwnerSplitAddress nvarchar(255),
	OwnerSplitCity nvarchar(255),
	OwnerSplitState nvarchar(255);


select * from NashvilleHousing;


update NashvilleHousing
set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3);

update NashvilleHousing
set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2);

update NashvilleHousing
set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1);



------------------------------------------------------------------
-- change Y and N to Yes and No in "sold vs vacant" field
------------------------------------------------------------------
select distinct(SoldAsVacant), count(SoldAsVacant) as total
from NashvilleHousing
group by SoldAsVacant
order by total desc;


select 
	SoldAsVacant,
	CASE
		when SoldAsVacant = 'Y' then 'Yes'
		when SoldAsVacant = 'N' then 'No'
		else SoldAsVacant
	END NewSoldAsVacant
from NashvilleHousing;


update NashvilleHousing
set SoldAsVacant = CASE
		when SoldAsVacant = 'Y' then 'Yes'
		when SoldAsVacant = 'N' then 'No'
		else SoldAsVacant
	END



------------------------------------------------------------------
-- remove duplicates
------------------------------------------------------------------

--find duplicates first
select	
	*,
	ROW_NUMBER() over (
		partition by ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
		order by UniqueID
	) row_num
from NashvilleHousing;


-- filter the duplicate rows using CTE
with RowNumCTE as
(
	select 
		*,
		ROW_NUMBER() over (
			partition by ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference
			order by UniqueID
		) row_num
	from NashvilleHousing
)
select * from RowNumCTE where row_num > 1;


-- delete the duplicate rows using CTE
with RowNumCTE as
(
	select 
		*,
		ROW_NUMBER() over (
			partition by ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference
			order by UniqueID
		) row_num
	from NashvilleHousing
)
Delete from RowNumCTE where row_num > 1;


-- select all columns from CTE
with RowNumCTE as
(
	select 
		*,
		ROW_NUMBER() over (
			partition by ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference
			order by UniqueID
		) row_num
	from NashvilleHousing
)
select * 
from RowNumCTE 
--where row_num > 1;



------------------------------------------------------------------
-- drop unnecessary columns
------------------------------------------------------------------
alter table NashvilleHousing
drop column OwnerAddress, TaxDistrict, PropertyAddress;

alter table NashvilleHousing
drop column SaleDate;

-- show the final table
select * from NashvilleHousing;



