From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 06/40] Staging: hv: vmbus: Introduce a lock to protect the ext
	field in hv_device
Date: Wed, 29 Jun 2011 07:39:03 -0700
Message-ID: <1309358377-8537-6-git-send-email-kys@microsoft.com>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
	<1309358377-8537-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1309358377-8537-1-git-send-email-kys@microsoft.com>
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

The current mechanism for handling references in broken. 
Introduce a lock to protect the ext field in hv_device.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hyperv.h    |    3 +++
 drivers/staging/hv/vmbus_drv.c |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hyperv.h b/drivers/staging/hv/hyperv.h
index 370b096..ff3c69d 100644
--- a/drivers/staging/hv/hyperv.h
+++ b/drivers/staging/hv/hyperv.h
@@ -830,6 +830,9 @@ struct hv_device {
 
 	struct vmbus_channel *channel;
 
+	/* This lock protects the device extension field */
+	spinlock_t ext_lock;
+
 	/* Device extension; */
 	void *ext;
 };
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 2e6bfc1..903362e 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -557,6 +557,7 @@ struct hv_device *vmbus_child_device_create(struct hv_guid *type,
 		return NULL;
 	}
 
+	spin_lock_init(&child_device_obj->ext_lock);
 	child_device_obj->channel = channel;
 	/*
 	 * Get the human readable device type name and stash it away.
-- 
1.7.4.1
