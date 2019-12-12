From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC v4 10/13] virtio-mem: Better retry handling
Date: Thu, 12 Dec 2019 18:11:34 +0100
Message-ID: <20191212171137.13872-11-david__28628.7696728081$1576170820$gmane$org@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191212171137.13872-1-david@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, Pavel Tatashin <pasha.tatashin@soleen.com>, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Let's start with a retry interval of 30 seconds and double the time until
we reach 30 minutes, in case we keep getting errors. Reset the retry
interval in case we succeeded.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 807d4e393427..3a57434f92ed 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -137,7 +137,9 @@ struct virtio_mem {
 
 	/* Timer for retrying to plug/unplug memory. */
 	struct hrtimer retry_timer;
-#define VIRTIO_MEM_RETRY_TIMER_MS		30000
+	unsigned int retry_timer_ms;
+#define VIRTIO_MEM_RETRY_TIMER_MIN_MS		30000
+#define VIRTIO_MEM_RETRY_TIMER_MAX_MS		1800000
 
 	/* Memory notifier (online/offline events). */
 	struct notifier_block memory_notifier;
@@ -1537,6 +1539,7 @@ static void virtio_mem_run_wq(struct work_struct *work)
 
 	switch (rc) {
 	case 0:
+		vm->retry_timer_ms = VIRTIO_MEM_RETRY_TIMER_MIN_MS;
 		break;
 	case -ENOSPC:
 		/*
@@ -1552,8 +1555,7 @@ static void virtio_mem_run_wq(struct work_struct *work)
 		 */
 	case -ENOMEM:
 		/* Out of memory, try again later. */
-		hrtimer_start(&vm->retry_timer,
-			      ms_to_ktime(VIRTIO_MEM_RETRY_TIMER_MS),
+		hrtimer_start(&vm->retry_timer, ms_to_ktime(vm->retry_timer_ms),
 			      HRTIMER_MODE_REL);
 		break;
 	case -EAGAIN:
@@ -1573,6 +1575,9 @@ static enum hrtimer_restart virtio_mem_timer_expired(struct hrtimer *timer)
 					     retry_timer);
 
 	virtio_mem_retry(vm);
+	/* Racy (with reset in virtio_mem_run_wq), we ignore that for now. */
+	vm->retry_timer_ms = min_t(unsigned int, vm->retry_timer_ms * 2,
+				   VIRTIO_MEM_RETRY_TIMER_MAX_MS);
 	return HRTIMER_NORESTART;
 }
 
@@ -1746,6 +1751,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
 	spin_lock_init(&vm->removal_lock);
 	hrtimer_init(&vm->retry_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	vm->retry_timer.function = virtio_mem_timer_expired;
+	vm->retry_timer_ms = VIRTIO_MEM_RETRY_TIMER_MIN_MS;
 
 	/* register the virtqueue */
 	rc = virtio_mem_init_vq(vm);
-- 
2.23.0
