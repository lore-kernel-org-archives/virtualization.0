From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/3] drm/bochs: add missing drm_atomic_helper_shutdown() call.
Date: Mon,  1 Apr 2019 16:03:05 +0200
Message-ID: <20190401140306.28063-3-kraxel__2499.80206587992$1554127464$gmane$org@redhat.com>
References: <20190401140306.28063-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190401140306.28063-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 9e7cd6b34106..93cb27f93d39 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -293,6 +293,7 @@ int bochs_kms_init(struct bochs_device *bochs)
 void bochs_kms_fini(struct bochs_device *bochs)
 {
 	if (bochs->mode_config_initialized) {
+		drm_atomic_helper_shutdown(bochs->dev);
 		drm_mode_config_cleanup(bochs->dev);
 		bochs->mode_config_initialized = false;
 	}
-- 
2.18.1
