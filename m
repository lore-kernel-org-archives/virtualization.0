From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 4/4] drm/vram: Unconditonally set BO call-back functions
Date: Wed, 11 Sep 2019 13:09:10 +0200
Message-ID: <20190911110910.30698-5-tzimmermann@suse.de>
References: <20190911110910.30698-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190911110910.30698-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: daniel@ffwll.ch, kraxel@redhat.com, airlied@linux.ie, corbet@lwn.net, z.liuxinliang@hisilicon.com, zourongrong@gmail.com, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com, hdegoede@redhat.com, sam@ravnborg.org, yc_chen@aspeedtech.com
Cc: virtualization@lists.linux-foundation.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The statement's condition is always true.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 1a05e2a97b93..ab9f8523d887 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -93,8 +93,7 @@ static int drm_gem_vram_init(struct drm_device *dev,
 	int ret;
 	size_t acc_size;
 
-	if (!gbo->bo.base.funcs)
-		gbo->bo.base.funcs = &drm_gem_vram_object_funcs;
+	gbo->bo.base.funcs = &drm_gem_vram_object_funcs;
 
 	ret = drm_gem_object_init(dev, &gbo->bo.base, size);
 	if (ret)
-- 
2.23.0
