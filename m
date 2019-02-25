From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v6 3/3] drm/qxl: remove conflicting framebuffers earlier
Date: Mon, 25 Feb 2019 09:30:09 +0100
Message-ID: <20190225083009.16082-4-kraxel__41887.6607714751$1551083676$gmane$org@redhat.com>
References: <20190225083009.16082-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190225083009.16082-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, daniel@ffwll.ch, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Add error checking while being at it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index bb81e310eb6d..578d867a81d5 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -79,6 +79,10 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto free_dev;
 
+	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "qxl");
+	if (ret)
+		goto disable_pci;
+
 	ret = qxl_device_init(qdev, &qxl_driver, pdev);
 	if (ret)
 		goto disable_pci;
@@ -94,7 +98,6 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto modeset_cleanup;
 
-	drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 0, "qxl");
 	drm_fbdev_generic_setup(&qdev->ddev, 32);
 	return 0;
 
-- 
2.9.3
