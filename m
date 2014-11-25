From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4 19/42] virtio_blk: fix race at module removal
Date: Tue, 25 Nov 2014 18:42:46 +0200
Message-ID: <1416933600-21398-20-git-send-email-mst__24305.2927581177$1416933858$gmane$org@redhat.com>
References: <1416933600-21398-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1416933600-21398-1-git-send-email-mst@redhat.com>
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
Cc: rusty@au1.ibm.com, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, David Miller <davem@davemloft.net>
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
