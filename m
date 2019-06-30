From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 09/33] drm/qxl: drop use of drmP.h
Date: Sun, 30 Jun 2019 08:18:58 +0200
Message-ID: <20190630061922.7254-10-sam@ravnborg.org>
References: <20190630061922.7254-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190630061922.7254-1-sam@ravnborg.org>
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
Cc: spice-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Sam Ravnborg <sam@ravnborg.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Drop use of the deprecated drmP.h header file.
While touching the files divided includes in blocks,
and when needed sort the blocks.
Fix fallout.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: spice-devel@lists.freedesktop.org
---
The list of cc: was too large to add all recipients to the cover letter.
Please find cover letter here:
https://lists.freedesktop.org/archives/dri-devel/2019-June/thread.html
Search for "drm: drop use of drmp.h in drm-misc"

        Sam

 drivers/gpu/drm/qxl/qxl_cmd.c     |  2 ++
 drivers/gpu/drm/qxl/qxl_debugfs.c |  4 ++--
 drivers/gpu/drm/qxl/qxl_display.c |  3 +++
 drivers/gpu/drm/qxl/qxl_draw.c    |  2 ++
 drivers/gpu/drm/qxl/qxl_drv.c     | 10 +++++++---
 drivers/gpu/drm/qxl/qxl_drv.h     |  7 +++----
 drivers/gpu/drm/qxl/qxl_gem.c     |  1 -
 drivers/gpu/drm/qxl/qxl_ioctl.c   |  3 +++
 drivers/gpu/drm/qxl/qxl_irq.c     |  4 ++++
 drivers/gpu/drm/qxl/qxl_kms.c     |  9 ++++++---
 drivers/gpu/drm/qxl/qxl_release.c |  6 +++++-
 drivers/gpu/drm/qxl/qxl_ttm.c     | 16 +++++++++-------
 12 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 0a2e51af1230..ac1081f55b51 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -25,6 +25,8 @@
 
 /* QXL cmd/ring handling */
 
+#include <linux/delay.h>
+
 #include <drm/drm_util.h>
 
 #include "qxl_drv.h"
diff --git a/drivers/gpu/drm/qxl/qxl_debugfs.c b/drivers/gpu/drm/qxl/qxl_debugfs.c
index 118422549828..a85ec100b0cc 100644
--- a/drivers/gpu/drm/qxl/qxl_debugfs.c
+++ b/drivers/gpu/drm/qxl/qxl_debugfs.c
@@ -28,9 +28,9 @@
  *  Alon Levy <alevy@redhat.com>
  */
 
-#include <linux/debugfs.h>
+#include <drm/drm_debugfs.h>
+#include <drm/drm_file.h>
 
-#include <drm/drmP.h>
 #include "qxl_drv.h"
 #include "qxl_object.h"
 
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 8b319ebbb0fb..023fb5a69af1 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -24,11 +24,14 @@
  */
 
 #include <linux/crc32.h>
+#include <linux/delay.h>
+
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
 
 #include "qxl_drv.h"
 #include "qxl_object.h"
diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
index 97c3f1a95a32..5bebf1ea1c5d 100644
--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -20,6 +20,8 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <drm/drm_fourcc.h>
+
 #include "qxl_drv.h"
 #include "qxl_object.h"
 
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index d8f64886474b..b57a37543613 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -28,14 +28,18 @@
  *    Alon Levy <alevy@redhat.com>
  */
 
-#include <linux/module.h>
+#include "qxl_drv.h"
 #include <linux/console.h>
+#include <linux/module.h>
+#include <linux/pci.h>
 
-#include <drm/drmP.h>
 #include <drm/drm.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_file.h>
 #include <drm/drm_modeset_helper.h>
+#include <drm/drm_prime.h>
 #include <drm/drm_probe_helper.h>
-#include "qxl_drv.h"
+
 #include "qxl_object.h"
 
 static const struct pci_device_id pciidlist[] = {
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 2896bb6fdbf4..ae82e5fab09c 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -31,22 +31,21 @@
  */
 
 #include <linux/dma-fence.h>
-#include <linux/workqueue.h>
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
+#include <linux/workqueue.h>
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_ioctl.h>
 #include <drm/drm_gem.h>
-#include <drm/drmP.h>
+#include <drm/qxl_drm.h>
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
-/* just for ttm_validate_buffer */
 #include <drm/ttm/ttm_execbuf_util.h>
 #include <drm/ttm/ttm_module.h>
 #include <drm/ttm/ttm_placement.h>
-#include <drm/qxl_drm.h>
 
 #include "qxl_dev.h"
 
diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.c
index 89606c819d82..89e4f9a7249c 100644
--- a/drivers/gpu/drm/qxl/qxl_gem.c
+++ b/drivers/gpu/drm/qxl/qxl_gem.c
@@ -23,7 +23,6 @@
  *          Alon Levy
  */
 
-#include <drm/drmP.h>
 #include <drm/drm.h>
 
 #include "qxl_drv.h"
diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index d410e2925162..8117a45b3610 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -23,6 +23,9 @@
  *          Alon Levy
  */
 
+#include <linux/pci.h>
+#include <linux/uaccess.h>
+
 #include "qxl_drv.h"
 #include "qxl_object.h"
 
diff --git a/drivers/gpu/drm/qxl/qxl_irq.c b/drivers/gpu/drm/qxl/qxl_irq.c
index 3bb31add6350..8435af108632 100644
--- a/drivers/gpu/drm/qxl/qxl_irq.c
+++ b/drivers/gpu/drm/qxl/qxl_irq.c
@@ -23,6 +23,10 @@
  *          Alon Levy
  */
 
+#include <linux/pci.h>
+
+#include <drm/drm_irq.h>
+
 #include "qxl_drv.h"
 
 irqreturn_t qxl_irq_handler(int irq, void *arg)
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index bee61fa2c9bc..611cbe7aee69 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -23,11 +23,14 @@
  *          Alon Levy
  */
 
-#include "qxl_drv.h"
-#include "qxl_object.h"
+#include <linux/io-mapping.h>
+#include <linux/pci.h>
 
+#include <drm/drm_drv.h>
 #include <drm/drm_probe_helper.h>
-#include <linux/io-mapping.h>
+
+#include "qxl_drv.h"
+#include "qxl_object.h"
 
 int qxl_log_level;
 
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 49f9a9385393..b805bfa87b68 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -19,9 +19,13 @@
  * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
+
+#include <linux/delay.h>
+
+#include <trace/events/dma_fence.h>
+
 #include "qxl_drv.h"
 #include "qxl_object.h"
-#include <trace/events/dma_fence.h>
 
 /*
  * drawable cmd cache - allocate a bunch of VRAM pages, suballocate
diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 0234f8556ada..663e59fd1e8c 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -23,19 +23,21 @@
  *          Alon Levy
  */
 
+#include <linux/delay.h>
+
+#include <drm/drm.h>
+#include <drm/drm_file.h>
+#include <drm/drm_debugfs.h>
+#include <drm/qxl_drm.h>
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
-#include <drm/ttm/ttm_placement.h>
-#include <drm/ttm/ttm_page_alloc.h>
 #include <drm/ttm/ttm_module.h>
-#include <drm/drmP.h>
-#include <drm/drm.h>
-#include <drm/qxl_drm.h>
+#include <drm/ttm/ttm_page_alloc.h>
+#include <drm/ttm/ttm_placement.h>
+
 #include "qxl_drv.h"
 #include "qxl_object.h"
 
-#include <linux/delay.h>
-
 static struct qxl_device *qxl_get_qdev(struct ttm_bo_device *bdev)
 {
 	struct qxl_mman *mman;
-- 
2.20.1
