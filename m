From: Amos Kong <akong@redhat.com>
Subject: [QEMU PATCH v5 3/3] virtio-net: rename ctrl rx commands
Date: Tue, 22 Jan 2013 23:44:46 +0800
Message-ID: <1358869486-22777-4-git-send-email-akong__11787.9995065325$1358869544$gmane$org@redhat.com>
References: <1358869486-22777-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358869486-22777-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, qemu-devel@nongnu.org, aliguori@us.ibm.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch makes rx commands consistent with specification.

Signed-off-by: Amos Kong <akong@redhat.com>
---
 hw/virtio-net.c |   14 +++++++-------
 hw/virtio-net.h |   14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/virtio-net.c b/hw/virtio-net.c
index acef5a5..ac4434e 100644
--- a/hw/virtio-net.c
+++ b/hw/virtio-net.c
@@ -326,17 +326,17 @@ static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
         return VIRTIO_NET_ERR;
     }
 
-    if (cmd == VIRTIO_NET_CTRL_RX_MODE_PROMISC) {
+    if (cmd == VIRTIO_NET_CTRL_RX_PROMISC) {
         n->promisc = on;
-    } else if (cmd == VIRTIO_NET_CTRL_RX_MODE_ALLMULTI) {
+    } else if (cmd == VIRTIO_NET_CTRL_RX_ALLMULTI) {
         n->allmulti = on;
-    } else if (cmd == VIRTIO_NET_CTRL_RX_MODE_ALLUNI) {
+    } else if (cmd == VIRTIO_NET_CTRL_RX_ALLUNI) {
         n->alluni = on;
-    } else if (cmd == VIRTIO_NET_CTRL_RX_MODE_NOMULTI) {
+    } else if (cmd == VIRTIO_NET_CTRL_RX_NOMULTI) {
         n->nomulti = on;
-    } else if (cmd == VIRTIO_NET_CTRL_RX_MODE_NOUNI) {
+    } else if (cmd == VIRTIO_NET_CTRL_RX_NOUNI) {
         n->nouni = on;
-    } else if (cmd == VIRTIO_NET_CTRL_RX_MODE_NOBCAST) {
+    } else if (cmd == VIRTIO_NET_CTRL_RX_NOBCAST) {
         n->nobcast = on;
     } else {
         return VIRTIO_NET_ERR;
@@ -473,7 +473,7 @@ static void virtio_net_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         iov_discard_front(&iov, &iov_cnt, sizeof(ctrl));
         if (s != sizeof(ctrl)) {
             status = VIRTIO_NET_ERR;
-        } else if (ctrl.class == VIRTIO_NET_CTRL_RX_MODE) {
+        } else if (ctrl.class == VIRTIO_NET_CTRL_RX) {
             status = virtio_net_handle_rx_mode(n, ctrl.cmd, iov, iov_cnt);
         } else if (ctrl.class == VIRTIO_NET_CTRL_MAC) {
             status = virtio_net_handle_mac(n, ctrl.cmd, iov, iov_cnt);
diff --git a/hw/virtio-net.h b/hw/virtio-net.h
index 1ec632f..c0bb284 100644
--- a/hw/virtio-net.h
+++ b/hw/virtio-net.h
@@ -99,13 +99,13 @@ typedef uint8_t virtio_net_ctrl_ack;
  * 0 and 1 are supported with the VIRTIO_NET_F_CTRL_RX feature.
  * Commands 2-5 are added with VIRTIO_NET_F_CTRL_RX_EXTRA.
  */
-#define VIRTIO_NET_CTRL_RX_MODE    0
- #define VIRTIO_NET_CTRL_RX_MODE_PROMISC      0
- #define VIRTIO_NET_CTRL_RX_MODE_ALLMULTI     1
- #define VIRTIO_NET_CTRL_RX_MODE_ALLUNI       2
- #define VIRTIO_NET_CTRL_RX_MODE_NOMULTI      3
- #define VIRTIO_NET_CTRL_RX_MODE_NOUNI        4
- #define VIRTIO_NET_CTRL_RX_MODE_NOBCAST      5
+#define VIRTIO_NET_CTRL_RX    0
+ #define VIRTIO_NET_CTRL_RX_PROMISC      0
+ #define VIRTIO_NET_CTRL_RX_ALLMULTI     1
+ #define VIRTIO_NET_CTRL_RX_ALLUNI       2
+ #define VIRTIO_NET_CTRL_RX_NOMULTI      3
+ #define VIRTIO_NET_CTRL_RX_NOUNI        4
+ #define VIRTIO_NET_CTRL_RX_NOBCAST      5
 
 /*
  * Control the MAC
-- 
1.7.1
