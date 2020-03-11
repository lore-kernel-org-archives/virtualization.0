From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 09/10] virtio-mem: Better retry handling
Date: Wed, 11 Mar 2020 18:14:21 +0100
Message-ID: <20200311171422.10484-10-david@redhat.com>
References: <20200311171422.10484-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200311171422.10484-1-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>, Oscar Salvador <osalvador@suse.de>, Igor Mammedov <imammedo@redhat.com>, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

Let's start with a retry interval of 5 seconds and double the time until
we reach 5 minutes, in case we keep getting errors. Reset the retry
interval in case we succeeded.

The two main reasons for having to retry are
- The hypervisor is busy and cannot process our request
- We cannot reach the desired requested_size (esp., not enough memory can
  get unplugged because we can't allocate any subblocks).

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
 drivers/virtio/virtio_mem.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index aa322e7732a4..48e96702d4ce 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -138,7 +138,9 @@ struct virtio_mem {
=20
 	/* Timer for retrying to plug/unplug memory. */
 	struct hrtimer retry_timer;
-#define VIRTIO_MEM_RETRY_TIMER_MS		30000
+	unsigned int retry_timer_ms;
+#define VIRTIO_MEM_RETRY_TIMER_MIN_MS		50000
+#define VIRTIO_MEM_RETRY_TIMER_MAX_MS		300000
=20
 	/* Memory notifier (online/offline events). */
 	struct notifier_block memory_notifier;
@@ -1548,6 +1550,7 @@ static void virtio_mem_run_wq(struct work_struct *w=
ork)
=20
 	switch (rc) {
 	case 0:
+		vm->retry_timer_ms =3D VIRTIO_MEM_RETRY_TIMER_MIN_MS;
 		break;
 	case -ENOSPC:
 		/*
@@ -1563,8 +1566,7 @@ static void virtio_mem_run_wq(struct work_struct *w=
ork)
 		 */
 	case -ENOMEM:
 		/* Out of memory, try again later. */
-		hrtimer_start(&vm->retry_timer,
-			      ms_to_ktime(VIRTIO_MEM_RETRY_TIMER_MS),
+		hrtimer_start(&vm->retry_timer, ms_to_ktime(vm->retry_timer_ms),
 			      HRTIMER_MODE_REL);
 		break;
 	case -EAGAIN:
@@ -1584,6 +1586,8 @@ static enum hrtimer_restart virtio_mem_timer_expire=
d(struct hrtimer *timer)
 					     retry_timer);
=20
 	virtio_mem_retry(vm);
+	vm->retry_timer_ms =3D min_t(unsigned int, vm->retry_timer_ms * 2,
+				   VIRTIO_MEM_RETRY_TIMER_MAX_MS);
 	return HRTIMER_NORESTART;
 }
=20
@@ -1750,6 +1754,7 @@ static int virtio_mem_probe(struct virtio_device *v=
dev)
 	spin_lock_init(&vm->removal_lock);
 	hrtimer_init(&vm->retry_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	vm->retry_timer.function =3D virtio_mem_timer_expired;
+	vm->retry_timer_ms =3D VIRTIO_MEM_RETRY_TIMER_MIN_MS;
=20
 	/* register the virtqueue */
 	rc =3D virtio_mem_init_vq(vm);
--=20
2.24.1
