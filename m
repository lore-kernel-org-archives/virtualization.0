From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 08/16] drm/bochs: atomic: use suspend/resume helpers
Date: Fri, 11 Jan 2019 06:37:44 +0100
Message-ID: <20190111053752.4004-9-kraxel__14417.6534413875$1547692869$gmane$org@redhat.com>
References: <20190111053752.4004-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190111053752.4004-1-kraxel@redhat.com>
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
Cc: andr2000@gmail.com, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, David Airlie <airlied@linux.ie>, noralf@tronnes.org
List-Id: virtualization@lists.linuxfoundation.org

Switch to atomic helpers: drm_mode_config_helper_suspend/resume().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index f3dd66ae99..08ba6029d2 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -103,11 +103,8 @@ static int bochs_pm_suspend(struct device *dev)
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
 	struct bochs_device *bochs = drm_dev->dev_private;
 
-	drm_kms_helper_poll_disable(drm_dev);
-
 	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 1);
-
-	return 0;
+	return drm_mode_config_helper_suspend(drm_dev);
 }
 
 static int bochs_pm_resume(struct device *dev)
@@ -116,12 +113,8 @@ static int bochs_pm_resume(struct device *dev)
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
 	struct bochs_device *bochs = drm_dev->dev_private;
 
-	drm_helper_resume_force_mode(drm_dev);
-
 	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 0);
-
-	drm_kms_helper_poll_enable(drm_dev);
-	return 0;
+	return drm_mode_config_helper_resume(drm_dev);
 }
 #endif
 
-- 
2.9.3
