From: Sam Bobroff <sbobroff@linux.ibm.com>
Subject: [PATCH 1/1] drm/bochs: Fix connector leak during driver unload
Date: Tue, 21 May 2019 15:28:39 +1000
Message-ID: <93b363ad62f4938d9ddf3e05b2a61e3f66b2dcd3.1558416473.git.sbobroff__20494.8428481416$1558426869$gmane$org@linux.ibm.com>
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
To: kraxel@redhat.com, airlied@linux.ie, daniel@ffwll.ch, virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

When unloading the bochs-drm driver, a warning message is printed by
drm_mode_config_cleanup() because a reference is still held to one of
the drm_connector structs.

Correct this by calling drm_atomic_helper_shutdown() in
bochs_pci_remove().

The issue is caused by the interaction of two previous commits. Both
together are required to cause it:
Fixes: 846c7dfc1193 ("drm/atomic: Try to preserve the crtc enabled state in drm_atomic_remove_fb, v2.")
Fixes: 6579c39594ae ("drm/bochs: atomic: switch planes to atomic, wire up helpers.")

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
Hello,

This seems to be similar to an issue I recently fixed for the AST driver:
1e613f3c630c ("drm/ast: Fix connector leak during driver unload")
Which is similar to at least one other recent fix:
192b4af6cd28 ("drm/tegra: Shutdown on driver unbind")

The fix seems to be the same, but this time I've tried to dig a little deeper
and use an appropriate Fixes tag to assist backporting.

Bisecting the issue for commits to drivers/gpu/drm/bochs/ points to:
6579c39594ae ("drm/bochs: atomic: switch planes to atomic, wire up helpers.")
... but the issue also seems to be due to a change in the generic drm code
(reverting it separately fixes the issue):
846c7dfc1193 ("drm/atomic: Try to preserve the crtc enabled state in drm_atomic_remove_fb, v2.")
... so I've included both in the commit.  Is that the right thing to do?

I couldn't help wondering if we should also update the comment for
drm_fbdev_generic_setup(), because it says:
"The fbdev is destroyed by drm_dev_unregister()"
... which implies to me that cleanup only requires that call, but actually
since 846c7dfc1193 you will always(?) need to use drm_atomic_helper_shutdown()
as well. (Is it actually always the case?)

Cheers,
Sam.

 drivers/gpu/drm/bochs/bochs_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index 6b6e037258c3..7031f0168795 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_atomic_helper.h>
 
 #include "bochs.h"
 
@@ -174,6 +175,7 @@ static void bochs_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
+	drm_atomic_helper_shutdown(dev);
 	drm_dev_unregister(dev);
 	bochs_unload(dev);
 	drm_dev_put(dev);
-- 
2.19.0.2.gcad72f5712
