From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2] drm/bochs: add edid support.
Date: Fri,  5 Oct 2018 14:09:34 +0200
Message-ID: <20181005120934.21959-1-kraxel__2444.28550727225$1538741264$gmane$org@redhat.com>
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
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Recent qemu (latest master branch, upcoming 3.1 release) got support
for EDID data.  This patch adds guest driver support.

EDID support in qemu is not (yet) enabled by default, so please use
'qemu -device VGA,edid=on' for testing.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     |  1 +
 drivers/gpu/drm/bochs/bochs_hw.c  | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/bochs/bochs_kms.c | 18 +++++++++++++++---
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index e7a69077e4..06b8166efa 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -66,6 +66,7 @@ struct bochs_device {
 	u16 yres_virtual;
 	u32 stride;
 	u32 bpp;
+	struct edid *edid;
 
 	/* drm */
 	struct drm_device  *dev;
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index cacff73a64..6ce4cdac38 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -69,6 +69,41 @@ static void bochs_hw_set_little_endian(struct bochs_device *bochs)
 #define bochs_hw_set_native_endian(_b) bochs_hw_set_little_endian(_b)
 #endif
 
+static int bochs_load_edid(struct bochs_device *bochs)
+{
+	uint8_t *blob;
+	size_t i, len;
+	uint8_t num_exts;
+
+	if (!bochs->mmio)
+		return -1;
+
+	if ((readb(bochs->mmio+0) != 0x00 ||
+	     readb(bochs->mmio+1) != 0xff))
+		return -1;
+
+	num_exts = readb(bochs->mmio + 126);
+	len = EDID_LENGTH * (1 + num_exts);
+	if (len > 0x400 /* vga register offset */)
+		return -1;
+
+	kfree(bochs->edid);
+	bochs->edid = kmalloc(len, GFP_KERNEL);
+	blob = (void *)bochs->edid;
+	for (i = 0; i < len; i++) {
+		blob[i] = readb(bochs->mmio+i);
+	}
+
+	if (!drm_edid_is_valid(bochs->edid)) {
+		DRM_ERROR("EDID is not valid, ignoring.\n");
+		kfree(bochs->edid);
+		bochs->edid = NULL;
+		return -1;
+	}
+
+	return 0;
+}
+
 int bochs_hw_init(struct drm_device *dev)
 {
 	struct bochs_device *bochs = dev->dev_private;
@@ -150,6 +185,9 @@ int bochs_hw_init(struct drm_device *dev)
 	}
 
 noext:
+	if (bochs_load_edid(bochs) == 0)
+		DRM_INFO("Found EDID data blob.\n");
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 9bc5b438ae..b9931443a7 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -213,10 +213,17 @@ static void bochs_encoder_init(struct drm_device *dev)
 
 static int bochs_connector_get_modes(struct drm_connector *connector)
 {
-	int count;
+	struct bochs_device *bochs =
+		container_of(connector, struct bochs_device, connector);
+	int count = 0;
 
-	count = drm_add_modes_noedid(connector, 8192, 8192);
-	drm_set_preferred_mode(connector, defx, defy);
+	if (bochs->edid)
+		count = drm_add_edid_modes(connector, bochs->edid);
+
+	if (!count) {
+		count = drm_add_modes_noedid(connector, 8192, 8192);
+		drm_set_preferred_mode(connector, defx, defy);
+	}
 	return count;
 }
 
@@ -271,6 +278,11 @@ static void bochs_connector_init(struct drm_device *dev)
 	drm_connector_helper_add(connector,
 				 &bochs_connector_connector_helper_funcs);
 	drm_connector_register(connector);
+
+	if (bochs->edid) {
+		drm_connector_attach_edid_property(connector);
+		drm_connector_update_edid_property(connector, bochs->edid);
+	}
 }
 
 
-- 
2.9.3
