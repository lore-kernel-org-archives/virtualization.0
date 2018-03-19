From: Jonathan Helman <jonathan.helman@oracle.com>
Subject: [PATCH v2] virtio_balloon: export hugetlb page allocation counts
Date: Mon, 19 Mar 2018 15:14:14 -0700
Message-ID: <1521497654-24807-1-git-send-email-jonathan.helman__15092.150696046$1521497558$gmane$org@oracle.com>
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
To: mst@redhat.com, jasowang@redhat.com
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Export the number of successful and failed hugetlb page
allocations via the virtio balloon driver. These 2 counts
come directly from the vm_events HTLB_BUDDY_PGALLOC and
HTLB_BUDDY_PGALLOC_FAIL.

Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
---
 drivers/virtio/virtio_balloon.c     | 6 ++++++
 include/uapi/linux/virtio_balloon.h | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index dfe5684..6b237e3 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -272,6 +272,12 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 				pages_to_bytes(events[PSWPOUT]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
+#ifdef CONFIG_HUGETLB_PAGE
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
+		    events[HTLB_BUDDY_PGALLOC]);
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGFAIL,
+		    events[HTLB_BUDDY_PGALLOC_FAIL]);
+#endif
 #endif
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMFREE,
 				pages_to_bytes(i.freeram));
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 4e8b830..40297a3 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -53,7 +53,9 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
 #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
 #define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
-#define VIRTIO_BALLOON_S_NR       8
+#define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page allocations */
+#define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
+#define VIRTIO_BALLOON_S_NR       10
 
 /*
  * Memory statistics structure.
-- 
1.8.3.1
