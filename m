From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] drm/ttm: use designated initializers
Date: Fri, 16 Dec 2016 16:59:29 -0800
Message-ID: <20161217005929.GA140260@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Prepare to mark sensitive kernel structures for randomization by making
sure they're using designated initializers. These were identified during
allyesconfig builds of x86, arm, and arm64, with most initializer fixes
extracted from grsecurity.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_ttm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
index 4a1de9f81193..63b3d5d35cf6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
@@ -198,11 +198,11 @@ static void ttm_bo_man_debug(struct ttm_mem_type_manager *man,
 }
 
 static const struct ttm_mem_type_manager_func virtio_gpu_bo_manager_func = {
-	ttm_bo_man_init,
-	ttm_bo_man_takedown,
-	ttm_bo_man_get_node,
-	ttm_bo_man_put_node,
-	ttm_bo_man_debug
+	.init = ttm_bo_man_init,
+	.takedown = ttm_bo_man_takedown,
+	.get_node = ttm_bo_man_get_node,
+	.put_node = ttm_bo_man_put_node,
+	.debug = ttm_bo_man_debug
 };
 
 static int virtio_gpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
-- 
2.7.4


-- 
Kees Cook
Nexus Security
