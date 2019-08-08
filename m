From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 13/17] drm/qxl: use drm_gem_object_funcs
Date: Thu,  8 Aug 2019 15:44:13 +0200
Message-ID: <20190808134417.10610-14-kraxel__676.181905303963$1565271924$gmane$org@redhat.com>
References: <20190808134417.10610-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190808134417.10610-1-kraxel@redhat.com>
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
Cc: tzimmermann@suse.de, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c    |  8 --------
 drivers/gpu/drm/qxl/qxl_object.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 12cf85a06bed..38467478c7b2 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -257,16 +257,8 @@ static struct drm_driver qxl_driver = {
 #endif
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
-	.gem_prime_pin = qxl_gem_prime_pin,
-	.gem_prime_unpin = qxl_gem_prime_unpin,
-	.gem_prime_get_sg_table = qxl_gem_prime_get_sg_table,
 	.gem_prime_import_sg_table = qxl_gem_prime_import_sg_table,
-	.gem_prime_vmap = qxl_gem_prime_vmap,
-	.gem_prime_vunmap = qxl_gem_prime_vunmap,
 	.gem_prime_mmap = qxl_gem_prime_mmap,
-	.gem_free_object_unlocked = qxl_gem_object_free,
-	.gem_open_object = qxl_gem_object_open,
-	.gem_close_object = qxl_gem_object_close,
 	.fops = &qxl_fops,
 	.ioctls = qxl_ioctls,
 	.irq_handler = qxl_irq_handler,
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 548dfe6f3b26..29aab7b14513 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -77,6 +77,17 @@ void qxl_ttm_placement_from_domain(struct qxl_bo *qbo, u32 domain, bool pinned)
 	}
 }
 
+static const struct drm_gem_object_funcs qxl_object_funcs = {
+	.free = qxl_gem_object_free,
+	.open = qxl_gem_object_open,
+	.close = qxl_gem_object_close,
+	.pin = qxl_gem_prime_pin,
+	.unpin = qxl_gem_prime_unpin,
+	.get_sg_table = qxl_gem_prime_get_sg_table,
+	.vmap = qxl_gem_prime_vmap,
+	.vunmap = qxl_gem_prime_vunmap,
+};
+
 int qxl_bo_create(struct qxl_device *qdev,
 		  unsigned long size, bool kernel, bool pinned, u32 domain,
 		  struct qxl_surface *surf,
@@ -100,6 +111,7 @@ int qxl_bo_create(struct qxl_device *qdev,
 		kfree(bo);
 		return r;
 	}
+	bo->tbo.base.funcs = &qxl_object_funcs;
 	bo->type = domain;
 	bo->pin_count = pinned ? 1 : 0;
 	bo->surface_id = 0;
-- 
2.18.1
