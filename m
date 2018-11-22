From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net 1/2] virtio-net: disable guest csum during XDP set
Date: Thu, 22 Nov 2018 14:36:30 +0800
Message-ID: <20181122063631.14452-1-jasowang__26909.4234252863$1542868484$gmane$org@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com, davem@davemloft.net, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>, Pavel Popa <pashinho1990@gmail.com>, Jesper Dangaard Brouer <brouer@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We don't disable VIRTIO_NET_F_GUEST_CSUM if XDP was set. This means we
can receive partial csumed packets with metadata kept in the
vnet_hdr. This may have several side effects:

- It could be overridden by header adjustment, thus is might be not
  correct after XDP processing.
- There's no way to pass such metadata information through
  XDP_REDIRECT to another driver.
- XDP does not support checksum offload right now.

So simply disable guest csum if possible in this the case of XDP.

Fixes: 3f93522ffab2d ("virtio-net: switch off offloads on demand if possible on XDP set")
Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Pavel Popa <pashinho1990@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e2c041d76ac..9b5ace538824 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -70,7 +70,8 @@ static const unsigned long guest_offloads[] = {
 	VIRTIO_NET_F_GUEST_TSO4,
 	VIRTIO_NET_F_GUEST_TSO6,
 	VIRTIO_NET_F_GUEST_ECN,
-	VIRTIO_NET_F_GUEST_UFO
+	VIRTIO_NET_F_GUEST_UFO,
+	VIRTIO_NET_F_GUEST_CSUM
 };
 
 struct virtnet_stat_desc {
@@ -2334,9 +2335,6 @@ static int virtnet_clear_guest_offloads(struct virtnet_info *vi)
 	if (!vi->guest_offloads)
 		return 0;
 
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))
-		offloads = 1ULL << VIRTIO_NET_F_GUEST_CSUM;
-
 	return virtnet_set_guest_offloads(vi, offloads);
 }
 
@@ -2346,8 +2344,6 @@ static int virtnet_restore_guest_offloads(struct virtnet_info *vi)
 
 	if (!vi->guest_offloads)
 		return 0;
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM))
-		offloads |= 1ULL << VIRTIO_NET_F_GUEST_CSUM;
 
 	return virtnet_set_guest_offloads(vi, offloads);
 }
-- 
2.17.1
