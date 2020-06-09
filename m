From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio_mem: fix printk format
Date: Tue, 9 Jun 2020 05:54:55 -0400
Message-ID: <20200609095453.865827-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Fixes: 676fa9ba893e ("virtio_mem: convert device block size into 64bit")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 7b1bece8a331..50c689f25045 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1717,8 +1717,8 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		 (unsigned long long)vm->device_block_size);
 	dev_info(&vm->vdev->dev, "memory block size: 0x%lx",
 		 memory_block_size_bytes());
-	dev_info(&vm->vdev->dev, "subblock size: 0x%x",
-		 vm->subblock_size);
+	dev_info(&vm->vdev->dev, "subblock size: 0x%llx",
+		 (unsigned long long)vm->subblock_size);
 	if (vm->nid != NUMA_NO_NODE)
 		dev_info(&vm->vdev->dev, "nid: %d", vm->nid);
 
-- 
MST
