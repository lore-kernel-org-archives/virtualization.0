From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 13/15] drm/bochs: switch to generic drm fbdev emulation
Date: Thu, 10 Jan 2019 09:28:43 +0100
Message-ID: <20190110082845.3453-14-kraxel__36615.6850978315$1547108894$gmane$org@redhat.com>
References: <20190110082845.3453-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190110082845.3453-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc: andr2000@gmail.com, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index 379111f5a0..1d86c0fb5f 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -16,10 +16,6 @@ static int bochs_modeset = -1;
 module_param_named(modeset, bochs_modeset, int, 0444);
 MODULE_PARM_DESC(modeset, "enable/disable kernel modesetting");
 
-static bool enable_fbdev = true;
-module_param_named(fbdev, enable_fbdev, bool, 0444);
-MODULE_PARM_DESC(fbdev, "register fbdev device");
-
 /* ---------------------------------------------------------------------- */
 /* drm interface                                                          */
 
@@ -27,7 +23,6 @@ static void bochs_unload(struct drm_device *dev)
 {
 	struct bochs_device *bochs = dev->dev_private;
 
-	bochs_fbdev_fini(bochs);
 	bochs_kms_fini(bochs);
 	bochs_mm_fini(bochs);
 	bochs_hw_fini(dev);
@@ -58,9 +53,6 @@ static int bochs_load(struct drm_device *dev)
 	if (ret)
 		goto err;
 
-	if (enable_fbdev)
-		bochs_fbdev_init(bochs);
-
 	return 0;
 
 err:
@@ -174,6 +166,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_unload;
 
+	drm_fbdev_generic_setup(dev, 32);
 	return ret;
 
 err_unload:
-- 
2.9.3
