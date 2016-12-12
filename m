From: Gustavo Padovan <gustavo@padovan.org>
Subject: [RFC 5/5] drm/virtio: bump driver version after explicit
	synchronization addition
Date: Mon, 12 Dec 2016 18:48:29 -0200
Message-ID: <1481575710-12535-5-git-send-email-gustavo__9776.82967572964$1481575770$gmane$org@padovan.org>
References: <1481575710-12535-1-git-send-email-gustavo@padovan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481575710-12535-1-git-send-email-gustavo@padovan.org>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, robdclark@gmail.com, Gustavo Padovan <gustavo.padovan@collabora.co.uk>
List-Id: virtualization@lists.linuxfoundation.org

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

To reflect the (backward compatible) changes in the uabi we are bumping
the driver's version.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 806c98b..b9ab010 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -45,8 +45,8 @@
 #define DRIVER_DATE "0"
 
 #define DRIVER_MAJOR 0
-#define DRIVER_MINOR 0
-#define DRIVER_PATCHLEVEL 1
+#define DRIVER_MINOR 1
+#define DRIVER_PATCHLEVEL 0
 
 /* virtgpu_drm_bus.c */
 int drm_virtio_init(struct drm_driver *driver, struct virtio_device *vdev);
-- 
2.5.5
