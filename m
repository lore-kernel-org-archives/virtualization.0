From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 14/25] Staging: hv: vmbus: Introduce functions for setting and
	getting driver data
Date: Thu,  8 Sep 2011 07:24:25 -0700
Message-ID: <1315491876-9554-14-git-send-email-kys@microsoft.com>
References: <1315491843-9513-1-git-send-email-kys@microsoft.com>
	<1315491876-9554-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1315491876-9554-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation for getting rid of the ext field in the struct hv_device,
introduce vmbus specific wrapper functions to set/get driver specific data.


Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hyperv.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hyperv.h b/drivers/staging/hv/hyperv.h
index 685a132..2879750 100644
--- a/drivers/staging/hv/hyperv.h
+++ b/drivers/staging/hv/hyperv.h
@@ -843,6 +843,15 @@ static inline struct hv_driver *drv_to_hv_drv(struct device_driver *d)
 	return container_of(d, struct hv_driver, driver);
 }
 
+static inline void hv_set_drvdata(struct hv_device *dev, void *data)
+{
+	dev_set_drvdata(&dev->device, data);
+}
+
+static inline void *hv_get_drvdata(struct hv_device *dev)
+{
+	return dev_get_drvdata(&dev->device);
+}
 
 /* Vmbus interface */
 #define vmbus_driver_register(driver)	\
-- 
1.7.4.1
