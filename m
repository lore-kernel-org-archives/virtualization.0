From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio_mmio: expose header to userspace
Date: Thu, 12 Jan 2017 23:37:22 +0200
Message-ID: <1484257033-11032-1-git-send-email-mst__9434.06250230527$1484257065$gmane$org@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

It's handy for userspace emulators like QEMU.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_mmio.c           | 2 +-
 include/{ => uapi}/linux/virtio_mmio.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/{ => uapi}/linux/virtio_mmio.h (100%)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index d47a2fc..7a10aa2 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -69,7 +69,7 @@
 #include <linux/spinlock.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
-#include <linux/virtio_mmio.h>
+#include <uapi/linux/virtio_mmio.h>
 #include <linux/virtio_ring.h>
 
 
diff --git a/include/linux/virtio_mmio.h b/include/uapi/linux/virtio_mmio.h
similarity index 100%
rename from include/linux/virtio_mmio.h
rename to include/uapi/linux/virtio_mmio.h
-- 
MST
