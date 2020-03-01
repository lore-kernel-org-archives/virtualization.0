From: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: [PATCH v2 3/3] virtio-net: Introduce hash report feature
Date: Sun,  1 Mar 2020 13:07:33 +0200
Message-ID: <20200301110733.20197-4-yuri.benditovich@daynix.com>
References: <20200301110733.20197-1-yuri.benditovich@daynix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200301110733.20197-1-yuri.benditovich@daynix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: yan@daynix.com
List-Id: virtualization@lists.linuxfoundation.org

The feature VIRTIO_NET_F_HASH_REPORT extends the
layout of the packet and requests the device to
calculate hash on incoming packets and report it
in the packet header.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 include/uapi/linux/virtio_net.h | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 6b309fe23671..c9ca62dd77a4 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,7 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_HASH_REPORT  57	/* Supports hash report */
 #define VIRTIO_NET_F_RSS	  60	/* Supports RSS RX steering */
 #define VIRTIO_NET_F_RSC_EXT	  61	/* extended coalescing info */
 #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
@@ -144,6 +145,23 @@ struct virtio_net_hdr_v1 {
 	__virtio16 num_buffers;	/* Number of merged rx buffers */
 };
 
+struct virtio_net_hdr_v1_hash {
+	struct virtio_net_hdr_v1 hdr;
+	__le32 hash_value;
+#define VIRTIO_NET_HASH_REPORT_NONE            0
+#define VIRTIO_NET_HASH_REPORT_IPv4            1
+#define VIRTIO_NET_HASH_REPORT_TCPv4           2
+#define VIRTIO_NET_HASH_REPORT_UDPv4           3
+#define VIRTIO_NET_HASH_REPORT_IPv6            4
+#define VIRTIO_NET_HASH_REPORT_TCPv6           5
+#define VIRTIO_NET_HASH_REPORT_UDPv6           6
+#define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
+#define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
+#define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
+	__le16 hash_report;
+	__le16 padding;
+};
+
 #ifndef VIRTIO_NET_NO_LEGACY
 /* This header comes first in the scatter-gather list.
  * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must
@@ -292,6 +310,24 @@ struct virtio_net_rss_config {
 
  #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
 
+/*
+ * The command VIRTIO_NET_CTRL_MQ_HASH_CONFIG requests the device
+ * to include in the virtio header of the packet the value of the
+ * calculated hash and the report type of hash. It also provides
+ * parameters for hash calculation. The command requires feature
+ * VIRTIO_NET_F_HASH_REPORT to be negotiated to extend the
+ * layout of virtio header as defined in virtio_net_hdr_v1_hash.
+ */
+struct virtio_net_hash_config {
+	__le32 hash_types;
+	/* for compatibility with virtio_net_rss_config */
+	__le16 reserved[4];
+	__u8 hash_key_length;
+	__u8 hash_key_data[/* hash_key_length */];
+};
+
+ #define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2
+
 /*
  * Control network offloads
  *
-- 
2.17.1
