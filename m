From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drm/virtio: use %llu format string form atomic64_t
Date: Wed, 07 Oct 2015 12:41:21 +0200
Message-ID: <5082760.FgB9zHNfte__1303.79250408641$1444214514$gmane$org@wuerfel>
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
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The virtgpu driver prints the last_seq variable using the %ld or
%lu format string, which does not work correctly on all architectures
and causes this compiler warning on ARM:

drivers/gpu/drm/virtio/virtgpu_fence.c: In function 'virtio_timeline_value_str':
drivers/gpu/drm/virtio/virtgpu_fence.c:64:22: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'long long int' [-Wformat=]
  snprintf(str, size, "%lu", atomic64_read(&fence->drv->last_seq));
                      ^
drivers/gpu/drm/virtio/virtgpu_debugfs.c: In function 'virtio_gpu_debugfs_irq_info':
drivers/gpu/drm/virtio/virtgpu_debugfs.c:37:16: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'long long int' [-Wformat=]
  seq_printf(m, "fence %ld %lld\n",
                ^

In order to avoid the warnings, this changes the format strings to %llu
and adds a cast to u64, which makes it work the same way everywhere.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
index db8b49101a8b..512263919282 100644
--- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
+++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
@@ -34,8 +34,8 @@ virtio_gpu_debugfs_irq_info(struct seq_file *m, void *data)
 	struct drm_info_node *node = (struct drm_info_node *) m->private;
 	struct virtio_gpu_device *vgdev = node->minor->dev->dev_private;
 
-	seq_printf(m, "fence %ld %lld\n",
-		   atomic64_read(&vgdev->fence_drv.last_seq),
+	seq_printf(m, "fence %llu %lld\n",
+		   (u64)atomic64_read(&vgdev->fence_drv.last_seq),
 		   vgdev->fence_drv.sync_seq);
 	return 0;
 }
diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
index 1da632631dac..67097c9ce9c1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fence.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
@@ -61,7 +61,7 @@ static void virtio_timeline_value_str(struct fence *f, char *str, int size)
 {
 	struct virtio_gpu_fence *fence = to_virtio_fence(f);
 
-	snprintf(str, size, "%lu", atomic64_read(&fence->drv->last_seq));
+	snprintf(str, size, "%llu", (u64)atomic64_read(&fence->drv->last_seq));
 }
 
 static const struct fence_ops virtio_fence_ops = {
