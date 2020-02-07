From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/cirrus: add drm_driver.release callback.
Date: Fri,  7 Feb 2020 13:13:45 +0100
Message-ID: <20200207121345.25639-1-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR
        QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Move final cleanups from cirrus_pci_remove() to the new callback.
Add drm_atomic_helper_shutdown() call to cirrus_pci_remove().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/cirrus/cirrus.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
index a91fb0d7282c..39a9e964aac9 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -502,6 +502,16 @@ static void cirrus_mode_config_init(struct cirrus_device *cirrus)
 
 /* ------------------------------------------------------------------ */
 
+static void cirrus_release(struct drm_device *dev)
+{
+	struct cirrus_device *cirrus = dev->dev_private;
+
+	drm_mode_config_cleanup(dev);
+	iounmap(cirrus->mmio);
+	iounmap(cirrus->vram);
+	kfree(cirrus);
+}
+
 DEFINE_DRM_GEM_FOPS(cirrus_fops);
 
 static struct drm_driver cirrus_driver = {
@@ -515,6 +525,7 @@ static struct drm_driver cirrus_driver = {
 
 	.fops		 = &cirrus_fops,
 	DRM_GEM_SHMEM_DRIVER_OPS,
+	.release         = cirrus_release,
 };
 
 static int cirrus_pci_probe(struct pci_dev *pdev,
@@ -596,14 +607,10 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
 static void cirrus_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
-	struct cirrus_device *cirrus = dev->dev_private;
 
 	drm_dev_unregister(dev);
-	drm_mode_config_cleanup(dev);
-	iounmap(cirrus->mmio);
-	iounmap(cirrus->vram);
+	drm_atomic_helper_shutdown(dev);
 	drm_dev_put(dev);
-	kfree(cirrus);
 	pci_release_regions(pdev);
 }
 
-- 
2.18.1
