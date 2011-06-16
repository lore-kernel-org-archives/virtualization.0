From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 07/77] Staging: hv: vmbus: Introduce a function to map the dev_type guid to a name
Date: Thu, 16 Jun 2011 13:16:40 -0700
Message-ID: <1308255470-3826-7-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation for introducing machinery to support autoloading vmbus 
drivers, introduce a function to map the dev_type guid to a human readable name.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/channel_mgmt.c |   36 ++++++++++++++++++++++++++++++++++++
 drivers/staging/hv/hyperv.h       |    2 +-
 2 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/channel_mgmt.c b/drivers/staging/hv/channel_mgmt.c
index bf011f3..022f32a 100644
--- a/drivers/staging/hv/channel_mgmt.c
+++ b/drivers/staging/hv/channel_mgmt.c
@@ -112,6 +112,42 @@ static const struct hv_guid
 
 };
 
+static const char *blk_dev_type = "hv_block";
+static const char *net_dev_type = "hv_net";
+static const char *scsi_dev_type = "hv_scsi";
+static const char *mouse_dev_type = "hv_mouse";
+static const char *util_dev_type = "hv_util";
+
+/*
+ * Map the dev_type guid to a human readable string for setting
+ * up module aliases. The indices used in this function are based on
+ * the table defined earlier - supported_device_classes[]
+ */
+const char *hv_get_devtype_name(const struct hv_guid *type)
+{
+	int i;
+
+	for (i = 0; i < MAX_NUM_DEVICE_CLASSES_SUPPORTED; i++) {
+		if (!memcmp(type, supported_device_classes[i].data,
+				sizeof(struct hv_guid))) {
+			switch (i) {
+			case 0:
+				return scsi_dev_type;
+			case 1:
+				return net_dev_type;
+			case 2:
+				return mouse_dev_type;
+			case 3:
+				return blk_dev_type;
+			}
+		}
+	}
+	/*
+	 * Currently the util driver is used
+	 * to handle all these devices.
+	 */
+	return util_dev_type;
+}
 
 /**
  * prep_negotiate_resp() - Create default response for Hyper-V Negotiate message
diff --git a/drivers/staging/hv/hyperv.h b/drivers/staging/hv/hyperv.h
index 1747a24..21d9c73 100644
--- a/drivers/staging/hv/hyperv.h
+++ b/drivers/staging/hv/hyperv.h
@@ -944,5 +944,5 @@ extern void prep_negotiate_resp(struct icmsg_hdr *,
 				struct icmsg_negotiate *, u8 *);
 extern void chn_cb_negotiate(void *);
 extern struct hyperv_service_callback hv_cb_utils[];
-
+const char *hv_get_devtype_name(const struct hv_guid *type);
 #endif /* _HYPERV_H */
-- 
1.7.4.1
