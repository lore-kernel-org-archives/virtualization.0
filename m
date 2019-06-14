From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 37/59] drm/virtio: Drop drm_gem_prime_export/import
Date: Fri, 14 Jun 2019 22:35:53 +0200
Message-ID: <20190614203615.12639-38-daniel.vetter@ffwll.ch>
References: <20190614203615.12639-1-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190614203615.12639-1-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

They're the default.

Aside: Would be really nice to switch the others over to
drm_gem_object_funcs.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 0afdf51fdcfd..99bcd290f1fb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -207,8 +207,6 @@ static struct drm_driver driver = {
 #endif
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
-	.gem_prime_export = drm_gem_prime_export,
-	.gem_prime_import = drm_gem_prime_import,
 	.gem_prime_get_sg_table = virtgpu_gem_prime_get_sg_table,
 	.gem_prime_import_sg_table = virtgpu_gem_prime_import_sg_table,
 	.gem_prime_vmap = virtgpu_gem_prime_vmap,
-- 
2.20.1
