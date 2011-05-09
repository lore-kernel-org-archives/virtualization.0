From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 199/206] Staging: hv: Get rid of version_info.h
Date: Mon,  9 May 2011 14:58:01 -0700
Message-ID: <1304978288-22999-199-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now, get rid of version_info.h.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/version_info.h |   48 -------------------------------------
 1 files changed, 0 insertions(+), 48 deletions(-)
 delete mode 100644 drivers/staging/hv/version_info.h

diff --git a/drivers/staging/hv/version_info.h b/drivers/staging/hv/version_info.h
deleted file mode 100644
index 35178f2..0000000
--- a/drivers/staging/hv/version_info.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- *
- * Copyright (c) 2009, Microsoft Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
- * Place - Suite 330, Boston, MA 02111-1307 USA.
- *
- * Authors:
- *   Haiyang Zhang <haiyangz@microsoft.com>
- *   Hank Janssen  <hjanssen@microsoft.com>
- *
- */
-
-#ifndef __HV_VERSION_INFO
-#define __HV_VERSION_INFO
-
-/*
- * We use the same version numbering for all Hyper-V modules.
- *
- * Definition of versioning is as follows;
- *
- *	Major Number	Changes for these scenarios;
- *			1.	When a new version of Windows Hyper-V
- *				is released.
- *			2.	A Major change has occurred in the
- *				Linux IC's.
- *			(For example the merge for the first time
- *			into the kernel) Every time the Major Number
- *			changes, the Revision number is reset to 0.
- *	Minor Number	Changes when new functionality is added
- *			to the Linux IC's that is not a bug fix.
- *
- * 3.1 - Added completed hv_utils driver. Shutdown/Heartbeat/Timesync
- */
-#define HV_DRV_VERSION           "3.1"
-
-
-#endif
-- 
1.7.4.1
