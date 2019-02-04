From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/bochs: fix bochs_gem_prime_mmap
Date: Mon,  4 Feb 2019 19:38:58 +0100
Message-ID: <20190204183858.8976-1-kraxel__580.880131904848$1549340805$gmane$org@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

ttm_fbdev_mmap() just doesn't work.  It appears to work fine, mmap()
returns success, but any attempt to actually access the mapping causes a
SIGBUS.

We can just use drm_gem_prime_mmap() instead.  Almost.  We have to copy
over the start offset from the ttm_buffer_object vm_node to the
drm_gem_object vm_node so the offset math in drm_gem_prime_mmap() works
correctly for us even though we use ttm to manage our objects.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_mm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index 641a33f134..49463348a0 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -442,5 +442,6 @@ int bochs_gem_prime_mmap(struct drm_gem_object *obj,
 {
 	struct bochs_bo *bo = gem_to_bochs_bo(obj);
 
-	return ttm_fbdev_mmap(vma, &bo->bo);
+	bo->gem.vma_node.vm_node.start = bo->bo.vma_node.vm_node.start;
+	return drm_gem_prime_mmap(obj, vma);
 }
-- 
2.9.3
