From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] drm: qxl: constify ttm_place structures.
Date: Sun,  2 Jul 2017 23:03:35 +0530
Message-ID: <a4f21d3bd2497129f084b8055ecf27f0d3ff1bba.1499013516.git.arvind.yadav.cs__9342.98615106872$1509078662$gmane$org@gmail.com>
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
To: airlied@redhat.com, kraxel@redhat.com, airlied@linux.ie
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

ttm_place are not supposed to change at runtime. All functions
working with ttm_place provided by <drm/ttm/ttm_placement.h> work
with const ttm_place. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   3485	    184	    264	   3933	    f5d	drivers/gpu/drm/qxl/qxl_ttm.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   3501	    152	    264	   3917	    f4d	drivers/gpu/drm/qxl/qxl_ttm.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 0fdedee..900fb8a 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -187,7 +187,7 @@ static void qxl_evict_flags(struct ttm_buffer_object *bo,
 				struct ttm_placement *placement)
 {
 	struct qxl_bo *qbo;
-	static struct ttm_place placements = {
+	static const struct ttm_place placements = {
 		.fpfn = 0,
 		.lpfn = 0,
 		.flags = TTM_PL_MASK_CACHING | TTM_PL_FLAG_SYSTEM
-- 
2.7.4
