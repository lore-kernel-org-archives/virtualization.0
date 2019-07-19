From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 009/171] drm/bochs: Fix connector leak during
	driver unload
Date: Thu, 18 Jul 2019 23:54:00 -0400
Message-ID: <20190719035643.14300-9-sashal__38822.7686098375$1563508660$gmane$org@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sam Bobroff <sbobroff@linux.ibm.com>, Sasha Levin <sashal@kernel.org>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Sam Bobroff <sbobroff@linux.ibm.com>

[ Upstream commit 3c6b8625dde82600fd03ad1fcba223f1303ee535 ]

When unloading the bochs-drm driver, a warning message is printed by
drm_mode_config_cleanup() because a reference is still held to one of
the drm_connector structs.

Correct this by calling drm_atomic_helper_shutdown() in
bochs_pci_remove().

Fixes: 6579c39594ae ("drm/bochs: atomic: switch planes to atomic, wire up helpers.")
Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Link: http://patchwork.freedesktop.org/patch/msgid/93b363ad62f4938d9ddf3e05b2a61e3f66b2dcd3.1558416473.git.sbobroff@linux.ibm.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index b86cc705138c..d8b945596b09 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_atomic_helper.h>
 
 #include "bochs.h"
 
@@ -171,6 +172,7 @@ static void bochs_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
+	drm_atomic_helper_shutdown(dev);
 	drm_dev_unregister(dev);
 	bochs_unload(dev);
 	drm_dev_put(dev);
-- 
2.20.1
