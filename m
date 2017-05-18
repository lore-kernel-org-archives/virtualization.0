From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 02/16] drm/virtio: fix include notation and remove
	-Iinclude/drm flag
Date: Thu, 18 May 2017 13:29:39 +0900
Message-ID: <1495081793-9707-3-git-send-email-yamada.masahiro__25033.6854871877$1495082360$gmane$org@socionext.com>
References: <1495081793-9707-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1495081793-9707-1-git-send-email-yamada.masahiro@socionext.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, virtualization@lists.linux-foundation.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sean Paul <seanpaul@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

Include <drm/*.h> instead of relative path from include/drm, then
remove the -Iinclude/drm compiler flag.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None

 drivers/gpu/drm/virtio/Makefile          |  2 --
 drivers/gpu/drm/virtio/virtgpu_debugfs.c |  2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  8 ++++----
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   |  5 +++--
 drivers/gpu/drm/virtio/virtgpu_ttm.c     | 10 +++++-----
 6 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/virtio/Makefile b/drivers/gpu/drm/virtio/Makefile
index 3fb8eac..7684f61 100644
--- a/drivers/gpu/drm/virtio/Makefile
+++ b/drivers/gpu/drm/virtio/Makefile
@@ -2,8 +2,6 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-ccflags-y := -Iinclude/drm
-
 virtio-gpu-y := virtgpu_drv.o virtgpu_kms.o virtgpu_drm_bus.o virtgpu_gem.o \
 	virtgpu_fb.o virtgpu_display.o virtgpu_vq.o virtgpu_ttm.o \
 	virtgpu_fence.o virtgpu_object.o virtgpu_debugfs.o virtgpu_plane.o \
diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
index f51240a..73dc990 100644
--- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
+++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
@@ -24,8 +24,8 @@
  */
 
 #include <linux/debugfs.h>
+#include <drm/drmP.h>
 
-#include "drmP.h"
 #include "virtgpu_drv.h"
 
 static int
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 2d29b01..63d35c7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -29,8 +29,8 @@
 #include <linux/module.h>
 #include <linux/console.h>
 #include <linux/pci.h>
-#include "drmP.h"
-#include "drm/drm.h"
+#include <drm/drmP.h>
+#include <drm/drm.h>
 
 #include "virtgpu_drv.h"
 static struct drm_driver driver;
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 1328185..3a66abb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -36,10 +36,10 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_encoder.h>
-#include <ttm/ttm_bo_api.h>
-#include <ttm/ttm_bo_driver.h>
-#include <ttm/ttm_placement.h>
-#include <ttm/ttm_module.h>
+#include <drm/ttm/ttm_bo_api.h>
+#include <drm/ttm/ttm_bo_driver.h>
+#include <drm/ttm/ttm_placement.h>
+#include <drm/ttm/ttm_module.h>
 
 #define DRIVER_NAME "virtio_gpu"
 #define DRIVER_DESC "virtio GPU"
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 61f3a96..06cb16d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -26,9 +26,10 @@
  */
 
 #include <drm/drmP.h>
-#include "virtgpu_drv.h"
 #include <drm/virtgpu_drm.h>
-#include "ttm/ttm_execbuf_util.h"
+#include <drm/ttm/ttm_execbuf_util.h>
+
+#include "virtgpu_drv.h"
 
 static void convert_to_hw_box(struct virtio_gpu_box *dst,
 			      const struct drm_virtgpu_3d_box *src)
diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
index 4e8e27d..c1f2af4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
@@ -25,11 +25,11 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <ttm/ttm_bo_api.h>
-#include <ttm/ttm_bo_driver.h>
-#include <ttm/ttm_placement.h>
-#include <ttm/ttm_page_alloc.h>
-#include <ttm/ttm_module.h>
+#include <drm/ttm/ttm_bo_api.h>
+#include <drm/ttm/ttm_bo_driver.h>
+#include <drm/ttm/ttm_placement.h>
+#include <drm/ttm/ttm_page_alloc.h>
+#include <drm/ttm/ttm_module.h>
 #include <drm/drmP.h>
 #include <drm/drm.h>
 #include <drm/virtgpu_drm.h>
-- 
2.7.4
