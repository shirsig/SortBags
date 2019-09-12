# SortBags
Bag sorting for Classic WoW (1.13).<br/>
__IMPORTANT: Use this branch for classic: https://github.com/shirsig/SortBags/tree/retail__<br/>
__IMPORTANT: The folder name must be "SortBags"__<br/>
__IMPORTANT: If you want buttons then get this too: https://github.com/shirsig/Cleanup__

```
/run SortBags() -- Sort bags
/run SortBankBags() -- Sort bank
/run SetSortBagsRightToLeft(Boolean) -- Set sort direction
/run GetSortBagsRightToLeft(): Boolean -- Get sort direction
/run SetBagSlotFlag(bagId, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP, Boolean) -- Set bag ignore status - bagId in (0, 1, 2, 3, 4)
/run GetBagSlotFlag(bagId, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP): Boolean -- Get bag ignore status
/run SetBankBagSlotFlag(bagId, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP, Boolean) -- Set bag ignore status - bagId in (-1, 5, 6, 7, 8, 9, 10)
/run GetBankBagSlotFlag(bagId, LE_BAG_FILTER_FLAG_IGNORE_CLEANUP): Boolean -- Get bag ignore status
```
