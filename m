From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 2/4] qxl: move qxl_send_monitors_config()
Date: Fri, 20 Apr 2018 09:19:02 +0200
Message-ID: <20180420071904.24276-3-kraxel__34419.8128128939$1524208636$gmane$org@redhat.com>
References: <20180420071904.24276-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180420071904.24276-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, David Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Needed to avoid a forward declaration in a followup patch.
Pure code move, no functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 47 +++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index dea757ef62..68db4d1965 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -258,6 +258,29 @@ static int qxl_add_common_modes(struct drm_connector *connector,
 	return i - 1;
 }
 
+static void qxl_send_monitors_config(struct qxl_device *qdev)
+{
+	int i;
+
+	BUG_ON(!qdev->ram_header->monitors_config);
+
+	if (qdev->monitors_config->count == 0)
+		return;
+
+	for (i = 0 ; i < qdev->monitors_config->count ; ++i) {
+		struct qxl_head *head = &qdev->monitors_config->heads[i];
+
+		if (head->y > 8192 || head->x > 8192 ||
+		    head->width > 8192 || head->height > 8192) {
+			DRM_ERROR("head %d wrong: %dx%d+%d+%d\n",
+				  i, head->width, head->height,
+				  head->x, head->y);
+			return;
+		}
+	}
+	qxl_io_monitors_config(qdev);
+}
+
 static void qxl_crtc_atomic_flush(struct drm_crtc *crtc,
 				  struct drm_crtc_state *old_crtc_state)
 {
@@ -378,30 +401,6 @@ static bool qxl_crtc_mode_fixup(struct drm_crtc *crtc,
 	return true;
 }
 
-static void
-qxl_send_monitors_config(struct qxl_device *qdev)
-{
-	int i;
-
-	BUG_ON(!qdev->ram_header->monitors_config);
-
-	if (qdev->monitors_config->count == 0)
-		return;
-
-	for (i = 0 ; i < qdev->monitors_config->count ; ++i) {
-		struct qxl_head *head = &qdev->monitors_config->heads[i];
-
-		if (head->y > 8192 || head->x > 8192 ||
-		    head->width > 8192 || head->height > 8192) {
-			DRM_ERROR("head %d wrong: %dx%d+%d+%d\n",
-				  i, head->width, head->height,
-				  head->x, head->y);
-			return;
-		}
-	}
-	qxl_io_monitors_config(qdev);
-}
-
 static void qxl_monitors_config_set(struct qxl_device *qdev,
 				    int index,
 				    unsigned x, unsigned y,
-- 
2.9.3
