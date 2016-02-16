From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 2/2] virtio_balloon: export 'available' memory to balloon
	statistics
Date: Tue, 16 Feb 2016 18:50:52 +0300
Message-ID: <1455637852-7323-3-git-send-email-den__27185.9506996863$1455639133$gmane$org@openvz.org>
References: <1455637852-7323-1-git-send-email-den@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1455637852-7323-1-git-send-email-den@openvz.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Igor Redko <redkoi@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "Denis V. Lunev" <den@openvz.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Igor Redko <redkoi@virtuozzo.com>

Add a new field, VIRTIO_BALLOON_S_AVAIL, to virtio_balloon memory
statistics protocol, corresponding to 'Available' in /proc/meminfo.

It indicates to the hypervisor how big the balloon can be inflated
without pushing the guest system to swap.

Signed-off-by: Igor Redko <redkoi@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/virtio/virtio_balloon.c     | 6 ++++++
 include/uapi/linux/virtio_balloon.h | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 0c3691f..f2b77de 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -30,6 +30,7 @@
 #include <linux/balloon_compaction.h>
 #include <linux/oom.h>
 #include <linux/wait.h>
+#include <linux/mm.h>
 
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
@@ -229,10 +230,13 @@ static void update_balloon_stats(struct virtio_balloon *vb)
 	unsigned long events[NR_VM_EVENT_ITEMS];
 	struct sysinfo i;
 	int idx = 0;
+	long available;
 
 	all_vm_events(events);
 	si_meminfo(&i);
 
+	available = si_mem_available();
+
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
 				pages_to_bytes(events[PSWPIN]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_OUT,
@@ -243,6 +247,8 @@ static void update_balloon_stats(struct virtio_balloon *vb)
 				pages_to_bytes(i.freeram));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MEMTOT,
 				pages_to_bytes(i.totalram));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_AVAIL,
+				pages_to_bytes(available));
 }
 
 /*
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index d7f1cbc..343d7dd 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -51,7 +51,8 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_MINFLT   3   /* Number of minor faults */
 #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory */
 #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
-#define VIRTIO_BALLOON_S_NR       6
+#define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
+#define VIRTIO_BALLOON_S_NR       7
 
 /*
  * Memory statistics structure.
-- 
2.5.0
