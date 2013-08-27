From: Thomas Huth <thuth@linux.vnet.ibm.com>
Subject: [PATCH] virtio-net: Set RXCSUM feature if GUEST_CSUM is available
Date: Tue, 27 Aug 2013 17:09:02 +0200
Message-ID: <1377616142-29590-1-git-send-email-thuth__13657.0874405608$1377616166$gmane$org@linux.vnet.ibm.com>
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
To: virtualization@lists.linux-foundation.org
Cc: netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

If the VIRTIO_NET_F_GUEST_CSUM virtio feature is available, the guest
does not have to calculate the checksums on all received packets. This
is pretty much the same feature as RX checksum offloading on real
network cards, so the virtio-net driver should report this by setting
the NETIF_F_RXCSUM flag. When the user now runs "ethtool -k", he or she
can see whether the virtio-net interface has to calculate RX checksums
or not.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f216002..defec2b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1538,6 +1538,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 			dev->features |= dev->hw_features & (NETIF_F_ALL_TSO|NETIF_F_UFO);
 		/* (!csum && gso) case will be fixed by register_netdev() */
 	}
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_CSUM))
+		dev->features |= NETIF_F_RXCSUM;
 
 	dev->vlan_features = dev->features;
 
-- 
1.8.1.4
