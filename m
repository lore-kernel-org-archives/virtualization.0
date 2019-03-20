From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/virtio: add virtio-gpu-features debugfs file.
Date: Wed, 20 Mar 2019 09:36:12 +0100
Message-ID: <20190320083612.32067-1-kraxel__1784.45994840644$1553071094$gmane$org@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This file prints which features the virtio-gpu device has.

Also add "virtio-gpu-" prefix to the existing fence file,
to make clear this is a driver-specific debugfs file.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_debugfs.c | 27 +++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
index 73dc99046c43..ed0fcda713c3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
+++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
@@ -28,6 +28,30 @@
 
 #include "virtgpu_drv.h"
 
+static void virtio_add_bool(struct seq_file *m, const char *name,
+				    bool value)
+{
+	seq_printf(m, "%-16s : %s\n", name, value ? "yes" : "no");
+}
+
+static void virtio_add_int(struct seq_file *m, const char *name,
+				   int value)
+{
+	seq_printf(m, "%-16s : %d\n", name, value);
+}
+
+static int virtio_gpu_features(struct seq_file *m, void *data)
+{
+	struct drm_info_node *node = (struct drm_info_node *) m->private;
+	struct virtio_gpu_device *vgdev = node->minor->dev->dev_private;
+
+	virtio_add_bool(m, "virgl", vgdev->has_virgl_3d);
+	virtio_add_bool(m, "edid", vgdev->has_edid);
+	virtio_add_int(m, "cap sets", vgdev->num_capsets);
+	virtio_add_int(m, "scanouts", vgdev->num_scanouts);
+	return 0;
+}
+
 static int
 virtio_gpu_debugfs_irq_info(struct seq_file *m, void *data)
 {
@@ -41,7 +65,8 @@ virtio_gpu_debugfs_irq_info(struct seq_file *m, void *data)
 }
 
 static struct drm_info_list virtio_gpu_debugfs_list[] = {
-	{ "irq_fence", virtio_gpu_debugfs_irq_info, 0, NULL },
+	{ "virtio-gpu-features", virtio_gpu_features },
+	{ "virtio-gpu-irq-fence", virtio_gpu_debugfs_irq_info, 0, NULL },
 };
 
 #define VIRTIO_GPU_DEBUGFS_ENTRIES ARRAY_SIZE(virtio_gpu_debugfs_list)
-- 
2.18.1
