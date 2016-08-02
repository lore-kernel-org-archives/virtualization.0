From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] drm/virtio: fix building without CONFIG_FBDEV
Date: Tue,  2 Aug 2016 12:09:15 +0200
Message-ID: <20160802100922.3914038-1-arnd__18274.9667474583$1470132664$gmane$org@arndb.de>
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
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Archit Taneja <architt@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, Emil Velikov <emil.l.velikov@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
List-Id: virtualization@lists.linuxfoundation.org

Removing the build-time dependency on DRM_KMS_FB_HELPER means
we can now build with CONFIG_FB disabled or as a loadable module,
leading to a link error:

ERROR: "remove_conflicting_framebuffers" [drivers/gpu/drm/virtio/virtio-gpu.ko] undefined!

There is no need to call remove_conflicting_framebuffers() if
CONFIG_FB is disabled, or if the virtio-gpu driver is built-in
and CONFIG_FB=m, as there won't be any prior consoles that
are registered at that point.

This adds a compile-time check in the driver to ensure we only
attempt to call that function if either CONFIG_FB=y or
both subsystems are configured as loadable modules.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 0b6320dfdfea ("drm/virtio: make fbdev support really optional")
---
 drivers/gpu/drm/virtio/virtgpu_drm_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drm_bus.c b/drivers/gpu/drm/virtio/virtgpu_drm_bus.c
index 7f0e93f87a55..2087569ae8d7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drm_bus.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drm_bus.c
@@ -65,7 +65,7 @@ int drm_virtio_init(struct drm_driver *driver, struct virtio_device *vdev)
 		DRM_INFO("pci: %s detected\n",
 			 vga ? "virtio-vga" : "virtio-gpu-pci");
 		dev->pdev = pdev;
-		if (vga)
+		if (IS_REACHABLE(CONFIG_FB) && vga)
 			virtio_pci_kick_out_firmware_fb(pdev);
 	}
 
-- 
2.9.0
