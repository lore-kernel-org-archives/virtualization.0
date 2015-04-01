From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 4/4] Add virtio-vga bits.
Date: Wed,  1 Apr 2015 15:15:30 +0200
Message-ID: <1427894130-14228-5-git-send-email-kraxel__29923.2292840772$1427894187$gmane$org@redhat.com>
References: <1427894130-14228-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1427894130-14228-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, airlied@redhat.com, airlied@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

---
 drivers/gpu/drm/virtio/virtgpu_drm_bus.c | 32 ++++++++++++++++++++++++++++++--
 drivers/virtio/virtio_pci_common.c       |  7 ++++++-
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drm_bus.c b/drivers/gpu/drm/virtio/virtgpu_drm_bus.c
index 56bd4ed..33d12d5 100644
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
+	ap->ranges[0].base = pci_resource_start(pci_dev, 2);
+	ap->ranges[0].size = pci_resource_len(pci_dev, 2);
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
@@ -48,8 +68,16 @@ int drm_virtio_init(struct drm_driver *driver, struct virtio_device *vdev)
 	dev->virtdev = vdev;
 	vdev->priv = dev;
 
-	if (strcmp(vdev->dev.parent->bus->name, "pci") == 0)
-		dev->pdev = to_pci_dev(vdev->dev.parent);
+	if (strcmp(vdev->dev.parent->bus->name, "pci") == 0) {
+		struct pci_dev *pdev = to_pci_dev(vdev->dev.parent);
+		bool vga = (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;
+
+		DRM_INFO("pci: %s detected\n",
+			 vga ? "virtio-vga" : "virtio-gpu-pci");
+		dev->pdev = pdev;
+		if (vga)
+			virtio_pci_kick_out_firmware_fb(pdev);
+	}
 
 	ret = drm_dev_register(dev, 0);
 	if (ret)
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index e894eb2..36d82e8 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -510,7 +510,12 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 		goto err_enable_device;
 
 	rc = pci_request_regions(pci_dev, "virtio-pci");
-	if (rc)
+	/*
+	 * virtio-vga: vesafb/efifb might hold vga framebuffer
+	 * resource, but don't fail on that, we'll kick out vesafb
+	 * later on.
+	 */
+	if (rc && ((pci_dev->class >> 8) != PCI_CLASS_DISPLAY_VGA))
 		goto err_request_regions;
 
 	if (force_legacy) {
-- 
1.8.3.1
