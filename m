From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 01/25] Staging: hv: Introduce a function to map a generic
	driver pointer to a pointer to storvsc_driver_object
Date: Tue, 26 Apr 2011 09:20:18 -0700
Message-ID: <1303834842-5022-1-git-send-email-kys@microsoft.com>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1303834785-4981-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation for getting rid of the priv element from struct hv_driver,
introduce a function that maps a generic struct driver pointer to struct
storvsc_driver_object.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_api.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index c98139c..b60a058 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -28,6 +28,7 @@
 #include <linux/kernel.h>
 #include "vstorage.h"
 #include "vmbus_api.h"
+#include "vmbus.h"
 
 /* Defines */
 #define STORVSC_RING_BUFFER_SIZE			(20*PAGE_SIZE)
@@ -153,6 +154,13 @@ static inline struct storvsc_driver_object *hvdr_to_stordr(struct hv_driver *d)
 	return container_of(d, struct storvsc_driver_object, base);
 }
 
+static inline
+struct storvsc_driver_object *drv_to_stordrv(struct device_driver *d)
+{
+	struct hv_driver *hvdrv = drv_to_hv_drv(d);
+	return hvdr_to_stordr(hvdrv);
+}
+
 /* Interface */
 
 int stor_vsc_on_device_add(struct hv_device *device,
-- 
1.7.4.1
