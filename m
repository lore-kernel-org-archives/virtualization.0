From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] drm: ttm: virtio-gpu: dma-buf: Constify ttm_place structures.
Date: Sun,  2 Jul 2017 13:11:02 +0530
Message-ID: <25a189402a516a0142d9a4412da0a597c660a96a.1498981093.git.arvind.yadav.cs__44218.8800000169$1509078654$gmane$org@gmail.com>
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
To: airlied@linux.ie, kraxel@redhat.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

ttm_place are not supposed to change at runtime. All functions
working with ttm_place provided by <drm/ttm/ttm_placement.h> work
with const ttm_place. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   2315	    184	      0	   2499	    9c3 drivers/gpu/drm/virtio/virtgpu_ttm.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   2347	    152	      0	   2499	    9c3 drivers/gpu/drm/virtio/virtgpu_ttm.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
index 4e8e27d..012d5bc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
@@ -234,7 +234,7 @@ static int virtio_gpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 static void virtio_gpu_evict_flags(struct ttm_buffer_object *bo,
 				struct ttm_placement *placement)
 {
-	static struct ttm_place placements = {
+	static const struct ttm_place placements = {
 		.fpfn  = 0,
 		.lpfn  = 0,
 		.flags = TTM_PL_MASK_CACHING | TTM_PL_FLAG_SYSTEM,
-- 
2.7.4
