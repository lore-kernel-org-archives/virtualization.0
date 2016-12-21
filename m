From: Liang Li <liang.z.li@intel.com>
Subject: [PATCH v6 kernel 2/5] virtio-balloon: define new feature bit and head
	struct
Date: Wed, 21 Dec 2016 14:52:25 +0800
Message-ID: <1482303148-22059-3-git-send-email-liang.z.li__45061.0274369412$1482303533$gmane$org@intel.com>
References: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1482303148-22059-1-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org
Cc: aarcange@redhat.com, virtio-dev@lists.oasis-open.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, amit.shah@redhat.com, pbonzini@redhat.com, Liang Li <liang.z.li@intel.com>, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Add a new feature which supports sending the page information
with range array. The current implementation uses PFNs array,
which is not very efficient. Using ranges can improve the
performance of inflating/deflating significantly.

Signed-off-by: Liang Li <liang.z.li@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Amit Shah <amit.shah@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
---
 include/uapi/linux/virtio_balloon.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 343d7dd..2f850bf 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -34,10 +34,14 @@
 #define VIRTIO_BALLOON_F_MUST_TELL_HOST	0 /* Tell before reclaiming pages */
 #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
+#define VIRTIO_BALLOON_F_PAGE_RANGE	3 /* Send page info with ranges */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
 
+/* Bits width for the length of the pfn range */
+#define VIRTIO_BALLOON_NR_PFN_BITS 12
+
 struct virtio_balloon_config {
 	/* Number of pages host wants Guest to give up. */
 	__u32 num_pages;
@@ -82,4 +86,12 @@ struct virtio_balloon_stat {
 	__virtio64 val;
 } __attribute__((packed));
 
+/* Response header structure */
+struct virtio_balloon_resp_hdr {
+	__le64 cmd : 8; /* Distinguish different requests type */
+	__le64 flag: 8; /* Mark status for a specific request type */
+	__le64 id : 16; /* Distinguish requests of a specific type */
+	__le64 data_len: 32; /* Length of the following data, in bytes */
+};
+
 #endif /* _LINUX_VIRTIO_BALLOON_H */
-- 
1.9.1
