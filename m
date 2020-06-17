From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] drm/virtio: Use struct_size() helper in kmalloc()
Date: Wed, 17 Jun 2020 16:57:07 -0500
Message-ID: <20200617215707.GA16785@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: virtualization@lists.linuxfoundation.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_gem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 24ffacac99e4..c30c75ee83fc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -154,9 +154,8 @@ void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
 struct virtio_gpu_object_array *virtio_gpu_array_alloc(u32 nents)
 {
 	struct virtio_gpu_object_array *objs;
-	size_t size = sizeof(*objs) + sizeof(objs->objs[0]) * nents;
 
-	objs = kmalloc(size, GFP_KERNEL);
+	objs = kmalloc(struct_size(objs, objs, nents), GFP_KERNEL);
 	if (!objs)
 		return NULL;
 
-- 
2.27.0
