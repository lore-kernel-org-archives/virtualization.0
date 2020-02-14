From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/qxl: don't take vga ports on rev5+
Date: Fri, 14 Feb 2020 14:36:45 +0100
Message-ID: <20200214133645.30977-1-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR QXL
        VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, "open list:DRM DRIVER FOR QXL VIRTUAL
        GPU" <spice-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

qemu 5.0 introduces a new qxl hardware revision 5.  Unlike revision 4
(and below) the device doesn't switch back into vga compatibility mode
when someone touches the vga ports.  So we don't have to reserve the
vga ports any more to avoid that happening.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 4fda3f9b29f4..afea743989dd 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -93,7 +93,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto disable_pci;
 
-	if (is_vga(pdev)) {
+	if (is_vga(pdev) && pdev->revision < 5) {
 		ret = vga_get_interruptible(pdev, VGA_RSRC_LEGACY_IO);
 		if (ret) {
 			DRM_ERROR("can't get legacy vga ioports\n");
@@ -124,7 +124,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 unload:
 	qxl_device_fini(qdev);
 put_vga:
-	if (is_vga(pdev))
+	if (is_vga(pdev) && pdev->revision < 5)
 		vga_put(pdev, VGA_RSRC_LEGACY_IO);
 disable_pci:
 	pci_disable_device(pdev);
@@ -155,7 +155,7 @@ qxl_pci_remove(struct pci_dev *pdev)
 
 	drm_dev_unregister(dev);
 	drm_atomic_helper_shutdown(dev);
-	if (is_vga(pdev))
+	if (is_vga(pdev) && pdev->revision < 5)
 		vga_put(pdev, VGA_RSRC_LEGACY_IO);
 	drm_dev_put(dev);
 }
-- 
2.18.2
