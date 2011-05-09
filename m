From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 202/206] Staging: hv: Get rid of vmbus.h
Date: Mon,  9 May 2011 14:58:04 -0700
Message-ID: <1304978288-22999-202-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now, get rid of vmbus.h.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus.h |   51 --------------------------------------------
 1 files changed, 0 insertions(+), 51 deletions(-)
 delete mode 100644 drivers/staging/hv/vmbus.h

diff --git a/drivers/staging/hv/vmbus.h b/drivers/staging/hv/vmbus.h
deleted file mode 100644
index 73087f2..0000000
--- a/drivers/staging/hv/vmbus.h
+++ /dev/null
@@ -1,51 +0,0 @@
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
-
-#ifndef _VMBUS_H_
-#define _VMBUS_H_
-
-#include <linux/device.h>
-#include "vmbus_api.h"
-
-
-
-
-static inline struct hv_device *device_to_hv_device(struct device *d)
-{
-	return container_of(d, struct hv_device, device);
-}
-
-static inline struct hv_driver *drv_to_hv_drv(struct device_driver *d)
-{
-	return container_of(d, struct hv_driver, driver);
-}
-
-
-/* Vmbus interface */
-int vmbus_child_driver_register(struct device_driver *drv);
-void vmbus_child_driver_unregister(struct device_driver *drv);
-
-extern struct completion hv_channel_ready;
-
-#endif /* _VMBUS_H_ */
-- 
1.7.4.1
