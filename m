From: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: [PATCH v2] virtio-net: Introduce extended RSC feature
Date: Mon, 13 Jan 2020 10:17:36 +0200
Message-ID: <20200113081736.2340-1-yuri.benditovich@daynix.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: yan@daynix.com
List-Id: virtualization@lists.linuxfoundation.org

VIRTIO_NET_F_RSC_EXT feature bit indicates that the device
is able to provide extended RSC information. When the feature
is negotiatede and 'gso_type' field in received packet is not
GSO_NONE, the device reports number of coalesced packets in
'csum_start' field and number of duplicated acks in 'csum_offset'
field and sets VIRTIO_NET_HDR_F_RSC_INFO in 'flags' field.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/uapi/linux/virtio_net.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index a3715a3224c1..2bdd26f8a4ed 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,7 +56,7 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
-
+#define VIRTIO_NET_F_RSC_EXT	  61	/* Provides extended RSC info */
 #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
 					 * with the same MAC.
 					 */
@@ -104,6 +104,7 @@ struct virtio_net_config {
 struct virtio_net_hdr_v1 {
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM	1	/* Use csum_start, csum_offset */
 #define VIRTIO_NET_HDR_F_DATA_VALID	2	/* Csum is valid */
+#define VIRTIO_NET_HDR_F_RSC_INFO	4	/* rsc_ext data in csum_ fields */
 	__u8 flags;
 #define VIRTIO_NET_HDR_GSO_NONE		0	/* Not a GSO frame */
 #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
@@ -118,6 +119,13 @@ struct virtio_net_hdr_v1 {
 	__virtio16 num_buffers;	/* Number of merged rx buffers */
 };
 
+/*
+ * if VIRTIO_NET_F_RSC_EXT feature has been negotiated and
+ * VIRTIO_NET_HDR_F_RSC_INFO is set in RX packet
+ */
+#define virtio_net_rsc_ext_num_packets	csum_start
+#define virtio_net_rsc_ext_num_dupacks	csum_offset
+
 #ifndef VIRTIO_NET_NO_LEGACY
 /* This header comes first in the scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
-- 
2.17.1
