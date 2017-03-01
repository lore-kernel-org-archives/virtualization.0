From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/4] qxl: limit monitor config read retries
Date: Wed,  1 Mar 2017 11:12:32 +0100
Message-ID: <1488363154-6889-3-git-send-email-kraxel__29924.8627307408$1488363181$gmane$org@redhat.com>
References: <1488363154-6889-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1488363154-6889-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

When reading the monitor config fails, don't retry forever.  If it fails
ten times in a row just give up to avoid the driver hangs.  Also add a
small delay after each attempt, so the host has a chance to complete a
partial update.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 2cd14be..2b99496 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -157,19 +157,23 @@ static void qxl_update_offset_props(struct qxl_device *qdev)
 
 void qxl_display_read_client_monitors_config(struct qxl_device *qdev)
 {
-
 	struct drm_device *dev = &qdev->ddev;
-	int status;
+	int status, retries;
 
-	status = qxl_display_copy_rom_client_monitors_config(qdev);
-	while (status == MONITORS_CONFIG_BAD_CRC) {
-		qxl_io_log(qdev, "failed crc check for client_monitors_config,"
-				 " retrying\n");
+	for (retries = 0; retries < 10; retries++) {
 		status = qxl_display_copy_rom_client_monitors_config(qdev);
+		if (status != MONITORS_CONFIG_BAD_CRC)
+			break;
+		udelay(5);
+	}
+	if (status == MONITORS_CONFIG_BAD_CRC) {
+		qxl_io_log(qdev, "config: bad crc\n");
+		DRM_DEBUG_KMS("ignoring client monitors config: bad crc");
+		return;
 	}
 	if (status == MONITORS_CONFIG_UNCHANGED) {
-		qxl_io_log(qdev, "config unchanged\n");
-		DRM_DEBUG("ignoring unchanged client monitors config");
+		qxl_io_log(qdev, "config: unchanged\n");
+		DRM_DEBUG_KMS("ignoring client monitors config: unchanged");
 		return;
 	}
 
-- 
1.8.3.1
