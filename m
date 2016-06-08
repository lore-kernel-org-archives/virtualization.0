From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 2/6] virtio_net: introduce virtio_net_hdr_{from,to}_skb
Date: Wed,  8 Jun 2016 16:09:18 +0300
Message-ID: <1465391362-18437-3-git-send-email-rppt__41399.5224204429$1465391468$gmane$org@linux.vnet.ibm.com>
References: <1465391362-18437-1-git-send-email-rppt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1465391362-18437-1-git-send-email-rppt@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The code for conversion between virtio_net_hdr and skb GSO info is
duplicated at several places. Let's put it to a common place to allow
reuse.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 include/linux/virtio_net.h | 101 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 include/linux/virtio_net.h

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
new file mode 100644
index 0000000..1c912f8
--- /dev/null
+++ b/include/linux/virtio_net.h
@@ -0,0 +1,101 @@
+#ifndef _LINUX_VIRTIO_NET_H
+#define _LINUX_VIRTIO_NET_H
+
+#include <linux/if_vlan.h>
+#include <uapi/linux/virtio_net.h>
+
+static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
+					const struct virtio_net_hdr *hdr,
+					bool little_endian)
+{
+	unsigned short gso_type = 0;
+
+	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
+		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
+		case VIRTIO_NET_HDR_GSO_TCPV4:
+			gso_type = SKB_GSO_TCPV4;
+			break;
+		case VIRTIO_NET_HDR_GSO_TCPV6:
+			gso_type = SKB_GSO_TCPV6;
+			break;
+		case VIRTIO_NET_HDR_GSO_UDP:
+			gso_type = SKB_GSO_UDP;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if (hdr->gso_type & VIRTIO_NET_HDR_GSO_ECN)
+			gso_type |= SKB_GSO_TCP_ECN;
+
+		if (hdr->gso_size == 0)
+			return -EINVAL;
+	}
+
+	if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+		u16 start = __virtio16_to_cpu(little_endian, hdr->csum_start);
+		u16 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
+
+		if (!skb_partial_csum_set(skb, start, off))
+			return -EINVAL;
+	}
+
+	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
+		u16 gso_size = __virtio16_to_cpu(little_endian, hdr->gso_size);
+
+		skb_shinfo(skb)->gso_size = gso_size;
+		skb_shinfo(skb)->gso_type = gso_type;
+
+		/* Header must be checked, and gso_segs computed. */
+		skb_shinfo(skb)->gso_type |= SKB_GSO_DODGY;
+		skb_shinfo(skb)->gso_segs = 0;
+	}
+
+	return 0;
+}
+
+static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
+					  struct virtio_net_hdr *hdr,
+					  bool little_endian)
+{
+	memset(hdr, 0, sizeof(*hdr));
+
+	if (skb_is_gso(skb)) {
+		struct skb_shared_info *sinfo = skb_shinfo(skb);
+
+		/* This is a hint as to how much should be linear. */
+		hdr->hdr_len = __cpu_to_virtio16(little_endian,
+						 skb_headlen(skb));
+		hdr->gso_size = __cpu_to_virtio16(little_endian,
+						  sinfo->gso_size);
+		if (sinfo->gso_type & SKB_GSO_TCPV4)
+			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
+		else if (sinfo->gso_type & SKB_GSO_TCPV6)
+			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
+		else if (sinfo->gso_type & SKB_GSO_UDP)
+			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP;
+		else
+			return -EINVAL;
+		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
+			hdr->gso_type |= VIRTIO_NET_HDR_GSO_ECN;
+	} else
+		hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		hdr->flags = VIRTIO_NET_HDR_F_NEEDS_CSUM;
+		if (skb_vlan_tag_present(skb))
+			hdr->csum_start = __cpu_to_virtio16(little_endian,
+				skb_checksum_start_offset(skb) + VLAN_HLEN);
+		else
+			hdr->csum_start = __cpu_to_virtio16(little_endian,
+				skb_checksum_start_offset(skb));
+		hdr->csum_offset = __cpu_to_virtio16(little_endian,
+				skb->csum_offset);
+	} else if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
+		hdr->flags = VIRTIO_NET_HDR_F_DATA_VALID;
+	} /* else everything is zero */
+
+	return 0;
+}
+
+#endif /* _LINUX_VIRTIO_BYTEORDER */
-- 
1.9.1
