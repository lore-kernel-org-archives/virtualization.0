From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 11/15] drm/qxl: Remove unecessary dma_fence_ops
Date: Thu,  3 May 2018 16:25:59 +0200
Message-ID: <20180503142603.28513-12-daniel.vetter@ffwll.ch>
References: <20180503142603.28513-1-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180503142603.28513-1-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Eric Anholt <eric@anholt.net>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The trivial enable_signaling implementation matches the default code.

v2: Fix up commit message to match patch better (Eric).

Cc: Eric Anholt <eric@anholt.net>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org
---
 drivers/gpu/drm/qxl/qxl_release.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 7cb214577275..e37f0097f744 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -50,12 +50,6 @@ static const char *qxl_get_timeline_name(struct dma_fence *fence)
 	return "release";
 }
 
-static bool qxl_nop_signaling(struct dma_fence *fence)
-{
-	/* fences are always automatically signaled, so just pretend we did this.. */
-	return true;
-}
-
 static long qxl_fence_wait(struct dma_fence *fence, bool intr,
 			   signed long timeout)
 {
@@ -119,7 +113,6 @@ static long qxl_fence_wait(struct dma_fence *fence, bool intr,
 static const struct dma_fence_ops qxl_fence_ops = {
 	.get_driver_name = qxl_get_driver_name,
 	.get_timeline_name = qxl_get_timeline_name,
-	.enable_signaling = qxl_nop_signaling,
 	.wait = qxl_fence_wait,
 };
 
-- 
2.17.0
