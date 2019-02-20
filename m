From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/qxl: unbind vgacon
Date: Wed, 20 Feb 2019 15:36:40 +0100
Message-ID: <20190220143640.9970-1-kraxel__40207.9721026652$1550673543$gmane$org@redhat.com>
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
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Problem:  qxl switches from native mode back into vga compatibility mode
when it notices someone is accessing vga registers.  And vgacon does
exactly that before fbcon takes over.

Before qxl switched to the generic fbdev emulation that didn't cause any
problems.  With the generic fbdev emulation the switch to vga mode
happens now and then, probably caused by a initialization order change
and triggered by a printk in a bad moment.

So make sure we take vgacon out of the picture by making dummycon
taking over the console early enough.

Not entriely happy with the approach, I'm open to better ideas.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index bb81e310eb..88349dc13e 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -30,6 +30,7 @@
 
 #include <linux/module.h>
 #include <linux/console.h>
+#include <linux/vt_kern.h>
 
 #include <drm/drmP.h>
 #include <drm/drm.h>
@@ -89,6 +90,11 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	drm_kms_helper_poll_init(&qdev->ddev);
 
+	/* unbind vgacon to make sure it doesn't touch our vga registers */
+	console_lock();
+	ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, true);
+	console_unlock();
+
 	/* Complete initialization. */
 	ret = drm_dev_register(&qdev->ddev, ent->driver_data);
 	if (ret)
-- 
2.9.3
