﻿

DELETE FROM Patient
GO

DBCC CHECKIDENT ('Patient', RESEED, 0);
GO