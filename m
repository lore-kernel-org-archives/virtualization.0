From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 3/3] drm/virtio: implement prime export
Date: Wed, 27 Feb 2019 15:44:41 +0100
Message-ID: <20190227144441.6755-4-kraxel__48674.6835684002$1551279266$gmane$org@redhat.com>
References: <20190227144441.6755-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190227144441.6755-1-kraxel@redhat.com>
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

Just run drm_prime_pages_to_sg() on the ttm pages list to get an
sg_table for export.  The pages list is created at object initialization
time, so there should be no need to handle an unpopulated page list.
Add a sanity check nevertheless.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  1 +
 drivers/gpu/drm/virtio/virtgpu_drv.c   |  2 ++
 drivers/gpu/drm/virtio/virtgpu_prime.c | 12 ++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 3238fdf58eb4..fb1095fa873f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -354,6 +354,7 @@ int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait);
 /* virtgpu_prime.c */
 int virtgpu_gem_prime_pin(struct drm_gem_object *obj);
 void virtgpu_gem_prime_unpin(struct drm_gem_object *obj);
+struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj);
 void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj);
 void virtgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
 int virtgpu_gem_prime_mmap(struct drm_gem_object *obj,
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index b996ac1d4fcc..4f4f578752fa 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -205,10 +205,12 @@ static struct drm_driver driver = {
 #if defined(CONFIG_DEBUG_FS)
 	.debugfs_init = virtio_gpu_debugfs_init,
 #endif
+	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.gem_prime_export = drm_gem_prime_export,
 	.gem_prime_import = drm_gem_prime_import,
 	.gem_prime_pin = virtgpu_gem_prime_pin,
 	.gem_prime_unpin = virtgpu_gem_prime_unpin,
+	.gem_prime_get_sg_table = virtgpu_gem_prime_get_sg_table,
 	.gem_prime_vmap = virtgpu_gem_prime_vmap,
 	.gem_prime_vunmap = virtgpu_gem_prime_vunmap,
 	.gem_prime_mmap = virtgpu_gem_prime_mmap,
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index 0fcae0e46abd..1fe593e391b5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -39,6 +39,18 @@ void virtgpu_gem_prime_unpin(struct drm_gem_object *obj)
 	/* nothing */
 }
 
+struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
+{
+	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
+
+	if (!bo->tbo.ttm->pages || !bo->tbo.ttm->num_pages)
+		/* should not happen */
+		return ERR_PTR(-EINVAL);
+
+	return drm_prime_pages_to_sg(bo->tbo.ttm->pages,
+				     bo->tbo.ttm->num_pages);
+}
+
 void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj)
 {
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
-- 
2.9.3
