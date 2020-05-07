From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 14/15] virtio-mem: Use -ETXTBSY as error code if the device
 is busy
Date: Thu,  7 May 2020 16:01:38 +0200
Message-ID: <20200507140139.17083-15-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Let's be able to distinguish if the device or if memory is busy.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index a719e1a04ac7..abd93b778a26 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -893,7 +893,7 @@ static int virtio_mem_send_plug_request(struct virtio_mem *vm, uint64_t addr,
 	case VIRTIO_MEM_RESP_NACK:
 		return -EAGAIN;
 	case VIRTIO_MEM_RESP_BUSY:
-		return -EBUSY;
+		return -ETXTBSY;
 	case VIRTIO_MEM_RESP_ERROR:
 		return -EINVAL;
 	default:
@@ -919,7 +919,7 @@ static int virtio_mem_send_unplug_request(struct virtio_mem *vm, uint64_t addr,
 		vm->plugged_size -= size;
 		return 0;
 	case VIRTIO_MEM_RESP_BUSY:
-		return -EBUSY;
+		return -ETXTBSY;
 	case VIRTIO_MEM_RESP_ERROR:
 		return -EINVAL;
 	default:
@@ -941,7 +941,7 @@ static int virtio_mem_send_unplug_all_request(struct virtio_mem *vm)
 		atomic_set(&vm->config_changed, 1);
 		return 0;
 	case VIRTIO_MEM_RESP_BUSY:
-		return -EBUSY;
+		return -ETXTBSY;
 	default:
 		return -ENOMEM;
 	}
@@ -1557,11 +1557,15 @@ static void virtio_mem_run_wq(struct work_struct *work)
 		 * or we have too many offline memory blocks.
 		 */
 		break;
-	case -EBUSY:
+	case -ETXTBSY:
 		/*
 		 * The hypervisor cannot process our request right now
-		 * (e.g., out of memory, migrating) or we cannot free up
-		 * any memory to unplug it (all plugged memory is busy).
+		 * (e.g., out of memory, migrating);
+		 */
+	case -EBUSY:
+		/*
+		 * We cannot free up any memory to unplug it (all plugged memory
+		 * is busy).
 		 */
 	case -ENOMEM:
 		/* Out of memory, try again later. */
-- 
2.25.3
