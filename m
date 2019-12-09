From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] virtio: Work around frames incorrectly marked as gso
Date: Mon,  9 Dec 2019 10:48:24 +0000
Message-ID: <20191209104824.17059-1-anton.ivanov__1570.09332194633$1575890491$gmane$org@cambridgegreys.com>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, linux-um@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Some of the frames marked as GSO which arrive at
virtio_net_hdr_from_skb() have no GSO_TYPE, no
fragments (data_len = 0) and length significantly shorter
than the MTU (752 in my experiments).

This is observed on raw sockets reading off vEth interfaces
in all 4.x and 5.x kernels I tested.

These frames are reported as invalid while they are in fact
gso-less frames.

This patch marks the vnet header as no-GSO for them instead
of reporting it as invalid.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 include/linux/virtio_net.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 0d1fe9297ac6..d90d5cff1b9a 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -112,8 +112,12 @@ static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
 		else if (sinfo->gso_type & SKB_GSO_TCPV6)
 			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
-		else
-			return -EINVAL;
+		else {
+			if (skb->data_len == 0)
+				hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
+			else
+				return -EINVAL;
+		}
 		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
 			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
 	} else
-- 
2.20.1
