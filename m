From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 184/206] Staging: hv: Include the new header files in vmbus driver
Date: Mon,  9 May 2011 14:57:46 -0700
Message-ID: <1304978288-22999-184-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Include the new header files in vmbus driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/channel.c      |    6 +++---
 drivers/staging/hv/channel_mgmt.c |    7 +++----
 drivers/staging/hv/connection.c   |    5 ++---
 drivers/staging/hv/hv.c           |    6 +++---
 drivers/staging/hv/ring_buffer.c  |    4 ++--
 drivers/staging/hv/vmbus_drv.c    |    8 ++------
 6 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index a2a190e..b9b082c 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -26,9 +26,9 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include "hv_api.h"
-#include "logging.h"
-#include "vmbus_private.h"
+
+#include <linux/hyperv.h>
+#include "hyperv_vmbus.h"
 
 #define NUM_PAGES_SPANNED(addr, len) \
 ((PAGE_ALIGN(addr + len) >> PAGE_SHIFT) - (addr >> PAGE_SHIFT))
diff --git a/drivers/staging/hv/channel_mgmt.c b/drivers/staging/hv/channel_mgmt.c
index 33cb5d5..0e4e05a 100644
--- a/drivers/staging/hv/channel_mgmt.c
+++ b/drivers/staging/hv/channel_mgmt.c
@@ -28,10 +28,9 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/completion.h>
-#include "hv_api.h"
-#include "logging.h"
-#include "vmbus_private.h"
-#include "utils.h"
+
+#include <linux/hyperv.h>
+#include "hyperv_vmbus.h"
 
 struct vmbus_channel_message_table_entry {
 	enum vmbus_channel_message_type message_type;
diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
index dd62585..445db48 100644
--- a/drivers/staging/hv/connection.c
+++ b/drivers/staging/hv/connection.c
@@ -28,10 +28,9 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include "hv_api.h"
-#include "logging.h"
-#include "vmbus_private.h"
 
+#include <linux/hyperv.h>
+#include "hyperv_vmbus.h"
 
 struct vmbus_connection vmbus_connection = {
 	.conn_state		= DISCONNECTED,
diff --git a/drivers/staging/hv/hv.c b/drivers/staging/hv/hv.c
index 2efac38..037424b6 100644
--- a/drivers/staging/hv/hv.c
+++ b/drivers/staging/hv/hv.c
@@ -25,9 +25,9 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include "hv_api.h"
-#include "logging.h"
-#include "vmbus_private.h"
+
+#include <linux/hyperv.h>
+#include "hyperv_vmbus.h"
 
 /* The one and only */
 struct hv_context hv_context = {
diff --git a/drivers/staging/hv/ring_buffer.c b/drivers/staging/hv/ring_buffer.c
index badf52a..ec262c1 100644
--- a/drivers/staging/hv/ring_buffer.c
+++ b/drivers/staging/hv/ring_buffer.c
@@ -25,9 +25,9 @@
 
 #include <linux/kernel.h>
 #include <linux/mm.h>
-#include "logging.h"
-#include "ring_buffer.h"
 
+#include <linux/hyperv.h>
+#include "hyperv_vmbus.h"
 
 /* #defines */
 
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 5dcd87a..5a049ab 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -34,13 +34,9 @@
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
 #include <linux/completion.h>
-#include "version_info.h"
-#include "hv_api.h"
-#include "logging.h"
-#include "vmbus.h"
-#include "channel.h"
-#include "vmbus_private.h"
 
+#include <linux/hyperv.h>
+#include "hyperv_vmbus.h"
 
 static struct pci_dev *hv_pci_dev;
 
-- 
1.7.4.1
