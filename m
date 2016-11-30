From: Liang Li <liang.z.li@intel.com>
Subject: [PATCH kernel v5 2/5] virtio-balloon: define new feature bit and head
	struct
Date: Wed, 30 Nov 2016 16:43:14 +0800
Message-ID: <1480495397-23225-3-git-send-email-liang.z.li__41669.3423329436$1480496318$gmane$org@intel.com>
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
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
Cc: virtio-dev@lists.oasis-open.org, mhocko@suse.com, Amit Shah <amit.shah@redhat.com>, mst@redhat.com, dave.hansen@intel.com, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, kirill.shutemov@linux.intel.com, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org, Liang Li <liang.z.li@intel.com>, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Add a new feature which supports sending the page information with
a bitmap. The current implementation uses PFNs array, which is not
very efficient. Using bitmap can improve the performance of
inflating/deflating significantly

The page bitmap header will used to tell the host some information
about the page bitmap. e.g. the page size, page bitmap length and
start pfn.

Signed-off-by: Liang Li <liang.z.li@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Amit Shah <amit.shah@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>
---
 include/uapi/linux/virtio_balloon.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 343d7dd..1be4b1f 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -34,6 +34,7 @@
 #define VIRTIO_BALLOON_F_MUST_TELL_HOST	0 /* Tell before reclaiming pages */
 #define VIRTIO_BALLOON_F_STATS_VQ	1 /* Memory Stats virtqueue */
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
+#define VIRTIO_BALLOON_F_PAGE_BITMAP	3 /* Send page info with bitmap */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
@@ -82,4 +83,22 @@ struct virtio_balloon_stat {
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
+/* Page bitmap header structure */
+struct virtio_balloon_bmap_hdr {
+	struct {
+		__le64 start_pfn : 52; /* start pfn for the bitmap */
+		__le64 page_shift : 6; /* page shift width, in bytes */
+		__le64 bmap_len : 6;  /* bitmap length, in bytes */
+	} head;
+	__le64 bmap[0];
+};
+
 #endif /* _LINUX_VIRTIO_BALLOON_H */
-- 
1.8.3.1
