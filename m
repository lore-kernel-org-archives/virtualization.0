From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v4 16/16] virtio-net: enable virtio 1.0
Date: Thu, 27 Nov 2014 16:16:49 +0100
Message-ID: <1417101409-29482-17-git-send-email-cornelia.huck__25112.7092670233$1417101603$gmane$org@de.ibm.com>
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

virtio-net (non-vhost) now should have everything in place to support
virtio 1.0: let's enable the feature bit for it.

Note that VIRTIO_F_VERSION_1 is technically a transport feature; once
every device is ready for virtio 1.0, we can move setting this
feature bit out of the individual devices.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/net/virtio-net.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b31b3a4..9ceff02 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -453,6 +453,10 @@ static uint32_t virtio_net_get_features(VirtIODevice *vdev, unsigned int index,
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc = qemu_get_queue(n->nic);
 
+    if (index == 1 && !get_vhost_net(nc->peer)) {
+        features |= (1 << (VIRTIO_F_VERSION_1 - 32));
+    }
+
     if (index > 0) {
         return features;
     }
-- 
1.7.9.5
