From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v7 22/46] virtio_blk: fix race at module removal
Date: Sun, 30 Nov 2014 17:11:06 +0200
Message-ID: <1417359787-10138-23-git-send-email-mst__42376.0059792132$1417360362$gmane$org@redhat.com>
References: <1417359787-10138-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1417359787-10138-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com, rusty@au1.ibm.com, virtualization@lists.linux-foundation.org, dahi@linux.vnet.ibm.com, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

If a device appears while module is being removed,
driver will get a callback after we've given up
on the major number.

In theory this means this major number can get reused
by something else, resulting in a conflict.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 055f3df..1f8b111 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -884,8 +884,8 @@ out_destroy_workqueue:
 
 static void __exit fini(void)
 {
-	unregister_blkdev(major, "virtblk");
 	unregister_virtio_driver(&virtio_blk);
+	unregister_blkdev(major, "virtblk");
 	destroy_workqueue(virtblk_wq);
 }
 module_init(init);
-- 
MST
