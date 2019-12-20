From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/4] drm/cirrus: add drm_driver.release callback.
Date: Fri, 20 Dec 2019 12:59:33 +0100
Message-ID: <20191220115935.15152-3-kraxel__38596.6789604694$1576843195$gmane$org@redhat.com>
References: <20191220115935.15152-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191220115935.15152-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Move final cleanups from cirrus_pci_remove() to the new callback.
Add drm_atomic_helper_shutdown() call to cirrus_pci_remove().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/cirrus/cirrus.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
index 248c9f765c45..a4ca66f9a423 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -510,6 +510,16 @@ static void cirrus_mode_config_init(struct cirrus_device *cirrus)
 
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
@@ -523,6 +533,7 @@ static struct drm_driver cirrus_driver = {
 
 	.fops		 = &cirrus_fops,
 	DRM_GEM_SHMEM_DRIVER_OPS,
+	.release         = cirrus_release,
 };
 
 static int cirrus_pci_probe(struct pci_dev *pdev,
@@ -604,14 +615,10 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
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
