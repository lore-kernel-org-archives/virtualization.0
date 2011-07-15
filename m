From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 081/117] Staging: hv: vmbus: Introduce a lock to protect the
	ext field in hv_device
Date: Fri, 15 Jul 2011 10:47:09 -0700
Message-ID: <1310752065-27895-81-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The current mechanism for handling references in broken.
Introduce a lock to protect the ext field in hv_device.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hyperv.h    |    3 +++
 drivers/staging/hv/vmbus_drv.c |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hyperv.h b/drivers/staging/hv/hyperv.h
index c4a9f38..82ba110 100644
--- a/drivers/staging/hv/hyperv.h
+++ b/drivers/staging/hv/hyperv.h
@@ -826,6 +826,9 @@ struct hv_device {
 
 	struct vmbus_channel *channel;
 
+	/* This lock protects the device extension field */
+	spinlock_t ext_lock;
+
 	/* Device extension; */
 	void *ext;
 };
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index ffd6066..29c1712 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -578,6 +578,7 @@ struct hv_device *vmbus_child_device_create(uuid_le *type,
 		return NULL;
 	}
 
+	spin_lock_init(&child_device_obj->ext_lock);
 	child_device_obj->channel = channel;
 	memcpy(&child_device_obj->dev_type, type, sizeof(uuid_le));
 	memcpy(&child_device_obj->dev_instance, instance,
-- 
1.7.4.1
