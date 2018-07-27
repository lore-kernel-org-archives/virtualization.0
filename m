From: Anton Vasilyev <vasilyev@ispras.ru>
Subject: [PATCH] drm: qxl: Fix NULL pointer dereference at
	qxl_alloc_client_monitors_config
Date: Fri, 27 Jul 2018 18:30:58 +0300
Message-ID: <20180727153058.23620-1-vasilyev__22841.0428193913$1532705343$gmane$org@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@redhat.com>
Cc: ldv-project@linuxtesting.org, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Anton Vasilyev <vasilyev@ispras.ru>
List-Id: virtualization@lists.linuxfoundation.org

If qxl_alloc_client_monitors_config() fails to allocate
client_monitors_config then NULL pointer dereference occurs
in function qxl_display_copy_rom_client_monitors_config() after
qxl_alloc_client_monitors_config() call.

The patch adds return error from qxl_alloc_client_monitors_config()
and additional status for qxl_display_copy_rom_client_monitors_config
return value.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
Note: Is it correct that qxl_display_read_client_monitors_config() does not
return error in case of fail?
---
 drivers/gpu/drm/qxl/qxl_display.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 768207fbbae3..a59b2eca5f5b 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -37,7 +37,8 @@ static bool qxl_head_enabled(struct qxl_head *head)
 	return head->width && head->height;
 }
 
-static void qxl_alloc_client_monitors_config(struct qxl_device *qdev, unsigned count)
+static int qxl_alloc_client_monitors_config(struct qxl_device *qdev,
+		unsigned int count)
 {
 	if (qdev->client_monitors_config &&
 	    count > qdev->client_monitors_config->count) {
@@ -49,15 +50,17 @@ static void qxl_alloc_client_monitors_config(struct qxl_device *qdev, unsigned c
 				sizeof(struct qxl_monitors_config) +
 				sizeof(struct qxl_head) * count, GFP_KERNEL);
 		if (!qdev->client_monitors_config)
-			return;
+			return -ENOMEM;
 	}
 	qdev->client_monitors_config->count = count;
+	return 0;
 }
 
 enum {
 	MONITORS_CONFIG_MODIFIED,
 	MONITORS_CONFIG_UNCHANGED,
 	MONITORS_CONFIG_BAD_CRC,
+	MONITORS_CONFIG_ERROR,
 };
 
 static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
@@ -87,7 +90,10 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
 	      && (num_monitors != qdev->client_monitors_config->count)) {
 		status = MONITORS_CONFIG_MODIFIED;
 	}
-	qxl_alloc_client_monitors_config(qdev, num_monitors);
+	if (qxl_alloc_client_monitors_config(qdev, num_monitors)) {
+		status = MONITORS_CONFIG_ERROR;
+		return status;
+	}
 	/* we copy max from the client but it isn't used */
 	qdev->client_monitors_config->max_allowed =
 				qdev->monitors_config->max_allowed;
@@ -161,6 +167,10 @@ void qxl_display_read_client_monitors_config(struct qxl_device *qdev)
 			break;
 		udelay(5);
 	}
+	if (status == MONITORS_CONFIG_ERROR) {
+		DRM_DEBUG_KMS("ignoring client monitors config: error");
+		return;
+	}
 	if (status == MONITORS_CONFIG_BAD_CRC) {
 		DRM_DEBUG_KMS("ignoring client monitors config: bad crc");
 		return;
-- 
2.18.0
