From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 17/23] drm/qxl: use generic fbdev emulation
Date: Fri, 18 Jan 2019 13:20:14 +0100
Message-ID: <20190118122020.27596-18-kraxel__11625.1254258261$1547814273$gmane$org@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190118122020.27596-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Switch qxl over to the new generic fbdev emulation.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 7 -------
 drivers/gpu/drm/qxl/qxl_drv.c     | 2 ++
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index ef832f98ab..9c751f01e3 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1221,18 +1221,11 @@ int qxl_modeset_init(struct qxl_device *qdev)
 	qxl_display_read_client_monitors_config(qdev);
 
 	drm_mode_config_reset(&qdev->ddev);
-
-	/* primary surface must be created by this point, to allow
-	 * issuing command queue commands and having them read by
-	 * spice server. */
-	qxl_fbdev_init(qdev);
 	return 0;
 }
 
 void qxl_modeset_fini(struct qxl_device *qdev)
 {
-	qxl_fbdev_fini(qdev);
-
 	qxl_destroy_monitors_object(qdev);
 	drm_mode_config_cleanup(&qdev->ddev);
 }
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 13c8a662f9..3fce7d16df 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -93,6 +93,8 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto modeset_cleanup;
 
+	drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "qxl");
+	drm_fbdev_generic_setup(&qdev->ddev, 32);
 	return 0;
 
 modeset_cleanup:
-- 
2.9.3
