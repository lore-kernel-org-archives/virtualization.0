From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v4 15/16] virtio-net: support longer header
Date: Thu, 27 Nov 2014 16:16:48 +0100
Message-ID: <1417101409-29482-16-git-send-email-cornelia.huck__10525.8173462518$1417101590$gmane$org@de.ibm.com>
References: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

virtio-1 devices always use num_buffers in the header, even if
mergeable rx buffers have not been negotiated.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/net/virtio-net.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index ad477bf..b31b3a4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -380,8 +380,13 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs)
 
     n->mergeable_rx_bufs = mergeable_rx_bufs;
 
-    n->guest_hdr_len = n->mergeable_rx_bufs ?
-        sizeof(struct virtio_net_hdr_mrg_rxbuf) : sizeof(struct virtio_net_hdr);
+    if (n->parent_obj.guest_features[1] >> (VIRTIO_F_VERSION_1 - 32) & 1) {
+        n->guest_hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+    } else {
+        n->guest_hdr_len = n->mergeable_rx_bufs ?
+            sizeof(struct virtio_net_hdr_mrg_rxbuf) :
+            sizeof(struct virtio_net_hdr);
+    }
 
     for (i = 0; i < n->max_queues; i++) {
         nc = qemu_get_subqueue(n->nic, i);
-- 
1.7.9.5
