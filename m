From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/3] Add virtio-vga bits.
Date: Tue, 16 Jun 2015 11:34:29 +0200
Message-ID: <1434447271-16461-2-git-send-email-kraxel@redhat.com>
References: <1434447271-16461-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1434447271-16461-1-git-send-email-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

---
 drivers/gpu/drm/virtio/virtgpu_drm_bus.c | 44 +++++++++++++++++---------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drm_bus.c b/drivers/gpu/drm/virtio/virtgpu_drm_bus.c
index f4ec816..88a3916 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drm_bus.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drm_bus.c
@@ -37,6 +37,26 @@ int drm_virtio_set_busid(struct drm_device *dev, struct drm_master *master)
 	return 0;
 }
 
+static void virtio_pci_kick_out_firmware_fb(struct pci_dev *pci_dev)
+{
+	struct apertures_struct *ap;
+	bool primary;
+
+	ap = alloc_apertures(1);
+	if (!ap)
+		return;
+
+	ap->ranges[0].base = pci_resource_start(pci_dev, 0);
+	ap->ranges[0].size = pci_resource_len(pci_dev, 0);
+
+	primary = pci_dev->resource[PCI_ROM_RESOURCE].flags
+		& IORESOURCE_ROM_SHADOW;
+
+	remove_conflicting_framebuffers(ap, "virtiodrmfb", primary);
+
+	kfree(ap);
+}
+
 int drm_virtio_init(struct drm_driver *driver, struct virtio_device *vdev)
 {
 	struct drm_device *dev;
@@ -52,27 +72,11 @@ int drm_virtio_init(struct drm_driver *driver, struct virtio_device *vdev)
 		struct pci_dev *pdev = to_pci_dev(vdev->dev.parent);
 		bool vga = (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
 
-		if (vga) {
-			/*
-			 * Need to make sure we don't have two drivers
-			 * for the same hardware here.  Some day we
-			 * will simply kick out the firmware
-			 * (vesa/efi) framebuffer.
-			 *
-			 * Virtual hardware specs for virtio-vga are
-			 * not finalized yet, therefore we can't add
-			 * code for that yet.
-			 *
-			 * So ignore the device for the time being,
-			 * and suggest to the user use the device
-			 * variant without vga compatibility mode.
-			 */
-			DRM_ERROR("virtio-vga not (yet) supported\n");
-			DRM_ERROR("please use virtio-gpu-pci instead\n");
-			ret = -ENODEV;
-			goto err_free;
-		}
+		DRM_INFO("pci: %s detected\n",
+			 vga ? "virtio-vga" : "virtio-gpu-pci");
 		dev->pdev = pdev;
+		if (vga)
+			virtio_pci_kick_out_firmware_fb(pdev);
 	}
 
 	ret = drm_dev_register(dev, 0);
-- 
1.8.3.1
