From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] virtio_ring: Use kmalloc_array() in alloc_indirect()
Date: Thu, 26 Jan 2017 22:47:59 +0100
Message-ID: <a460744a-0fec-4a47-c98a-42b88ddada64__28514.9530893706$1485467668$gmane$org@users.sourceforge.net>
References: <61829748-a13d-42e4-8f6c-103ee5ca2c88@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <61829748-a13d-42e4-8f6c-103ee5ca2c88@users.sourceforge.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Jan 2017 22:30:45 +0100

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data structure by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/virtio/virtio_ring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 409aeaa49246..34b6b694298c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -247,8 +247,7 @@ static struct vring_desc *alloc_indirect(struct virtqueue *_vq,
 	 * virtqueue.
 	 */
 	gfp &= ~__GFP_HIGHMEM;
-
-	desc = kmalloc(total_sg * sizeof(struct vring_desc), gfp);
+	desc = kmalloc_array(total_sg, sizeof(*desc), gfp);
 	if (!desc)
 		return NULL;
 
-- 
2.11.0
