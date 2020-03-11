From: David Stevens <stevensd@chromium.org>
Subject: [PATCH v3 2/4] drm/prime: add support for virtio exported objects
Date: Wed, 11 Mar 2020 20:20:02 +0900
Message-ID: <20200311112004.47138-3-stevensd@chromium.org>
References: <20200311112004.47138-1-stevensd@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <virtio-dev-return-6917-gcvd-virtio-dev=m.gmane-mx.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <20200311112004.47138-1-stevensd@chromium.org>
To: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Stevens <stevensd@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

This change exposes dma-buf's get_uuid callback to PRIME drivers.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/gpu/drm/drm_prime.c | 23 +++++++++++++++++++++++
 include/drm/drm_drv.h       | 10 ++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 86d9b0e45c8c..50fed8497d3c 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -779,6 +779,28 @@ int drm_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struct *vma)
 }
 EXPORT_SYMBOL(drm_gem_dmabuf_mmap);
 
+/**
+ * drm_gem_dmabuf_get_uuid - dma_buf get_uuid implementation for GEM
+ * @dma_buf: buffer to query
+ * @uuid: uuid outparam
+ *
+ * Queries the buffer's virtio UUID. This can be used as the
+ * &dma_buf_ops.get_uuid callback. Calls into &drm_driver.gem_prime_get_uuid.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int drm_gem_dmabuf_get_uuid(struct dma_buf *dma_buf, uuid_t *uuid)
+{
+	struct drm_gem_object *obj = dma_buf->priv;
+	struct drm_device *dev = obj->dev;
+
+	if (!dev->driver->gem_prime_get_uuid)
+		return -ENODEV;
+
+	return dev->driver->gem_prime_get_uuid(obj, uuid);
+}
+EXPORT_SYMBOL(drm_gem_dmabuf_get_uuid);
+
 static const struct dma_buf_ops drm_gem_prime_dmabuf_ops =  {
 	.cache_sgt_mapping = true,
 	.attach = drm_gem_map_attach,
@@ -789,6 +811,7 @@ static const struct dma_buf_ops drm_gem_prime_dmabuf_ops =  {
 	.mmap = drm_gem_dmabuf_mmap,
 	.vmap = drm_gem_dmabuf_vmap,
 	.vunmap = drm_gem_dmabuf_vunmap,
+	.get_uuid = drm_gem_dmabuf_get_uuid,
 };
 
 /**
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 77685ed7aa65..61e3ff341844 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -29,6 +29,7 @@
 
 #include <linux/list.h>
 #include <linux/irqreturn.h>
+#include <linux/uuid.h>
 
 #include <drm/drm_device.h>
 
@@ -639,6 +640,15 @@ struct drm_driver {
 	int (*gem_prime_mmap)(struct drm_gem_object *obj,
 				struct vm_area_struct *vma);
 
+	/**
+	 * @gem_prime_get_uuid
+	 *
+	 * get_uuid hook for GEM drivers. Retrieves the virtio uuid of the
+	 * given GEM buffer.
+	 */
+	int (*gem_prime_get_uuid)(struct drm_gem_object *obj,
+				  uuid_t *uuid);
+
 	/**
 	 * @dumb_create:
 	 *
-- 
2.25.1.481.gfbce0eb801-goog
