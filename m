From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2] drm/cirrus: add drm_driver.release callback.
Date: Mon, 10 Feb 2020 10:53:10 +0100
Message-ID: <20200210095310.22082-1-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR
        QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Move final cleanups from cirrus_pci_remove() to the new callback.
Add drm_atomic_helper_shutdown() call to cirrus_pci_remove().

Set pointers to NULL after iounmap() and check them before using
them to make sure we don't touch released hardware.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/cirrus/cirrus.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
index a91fb0d7282c..128db11ed4d3 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -154,6 +154,9 @@ static void cirrus_set_start_address(struct cirrus_device *cirrus, u32 offset)
 	u32 addr;
 	u8 tmp;
 
+	if (!cirrus->mmio)
+		return;
+
 	addr = offset >> 2;
 	wreg_crt(cirrus, 0x0c, (u8)((addr >> 8) & 0xff));
 	wreg_crt(cirrus, 0x0d, (u8)(addr & 0xff));
@@ -179,6 +182,9 @@ static int cirrus_mode_set(struct cirrus_device *cirrus,
 	int tmp;
 	int sr07 = 0, hdr = 0;
 
+	if (!cirrus->mmio)
+		return -1;
+
 	htotal = mode->htotal / 8;
 	hsyncend = mode->hsync_end / 8;
 	hsyncstart = mode->hsync_start / 8;
@@ -301,6 +307,9 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
 	struct cirrus_device *cirrus = fb->dev->dev_private;
 	void *vmap;
 
+	if (!cirrus->vram)
+		return -ENODEV;
+
 	vmap = drm_gem_shmem_vmap(fb->obj[0]);
 	if (!vmap)
 		return -ENOMEM;
@@ -502,6 +511,14 @@ static void cirrus_mode_config_init(struct cirrus_device *cirrus)
 
 /* ------------------------------------------------------------------ */
 
+static void cirrus_release(struct drm_device *dev)
+{
+	struct cirrus_device *cirrus = dev->dev_private;
+
+	drm_mode_config_cleanup(dev);
+	kfree(cirrus);
+}
+
 DEFINE_DRM_GEM_FOPS(cirrus_fops);
 
 static struct drm_driver cirrus_driver = {
@@ -515,6 +532,7 @@ static struct drm_driver cirrus_driver = {
 
 	.fops		 = &cirrus_fops,
 	DRM_GEM_SHMEM_DRIVER_OPS,
+	.release         = cirrus_release,
 };
 
 static int cirrus_pci_probe(struct pci_dev *pdev,
@@ -599,11 +617,12 @@ static void cirrus_pci_remove(struct pci_dev *pdev)
 	struct cirrus_device *cirrus = dev->dev_private;
 
 	drm_dev_unregister(dev);
-	drm_mode_config_cleanup(dev);
+	drm_atomic_helper_shutdown(dev);
 	iounmap(cirrus->mmio);
+	cirrus->mmio = NULL;
 	iounmap(cirrus->vram);
+	cirrus->vram = NULL;
 	drm_dev_put(dev);
-	kfree(cirrus);
 	pci_release_regions(pdev);
 }
 
-- 
2.18.1
