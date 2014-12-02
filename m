From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v5 17/19] virtio-net: enable virtio 1.0
Date: Tue,  2 Dec 2014 14:00:25 +0100
Message-ID: <1417525227-14051-18-git-send-email-cornelia.huck__22706.3918639489$1417525427$gmane$org@de.ibm.com>
References: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
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
 hw/net/virtio-net.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7ee2bd6..b5dd356 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -473,6 +473,7 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features)
     }
 
     if (!get_vhost_net(nc->peer)) {
+        virtio_add_feature(&features, VIRTIO_F_VERSION_1);
         return features;
     }
     return vhost_net_get_features(get_vhost_net(nc->peer), features);
-- 
1.7.9.5
