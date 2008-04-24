From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH] virtio-blk: fix remove oops
Date: Thu, 24 Apr 2008 15:49:53 -0300
Message-ID: <20080424184953.GA14820@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Anthony Liguori <aliguori@us.ibm.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Do not unregister the major at device remove, since there might be
another device instances around.

(qemu) pci_del 0 11
(qemu) ACPI: PCI interrupt for device 0000:00:0b.0 disabled
(qemu) pci_del 0 10
(qemu) ------------[ cut here ]------------
WARNING: at block/genhd.c:126 unregister_blkdev+0x74/0x9e()
ACPI: PCI interrupt for device 0000:00:0a.0 disabled

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>


diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0cfbe8c..6231097 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -289,7 +289,6 @@ out:
 static void virtblk_remove(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
-	int major = vblk->disk->major;
 
 	/* Nothing should be pending. */
 	BUG_ON(!list_empty(&vblk->reqs));
@@ -299,7 +298,6 @@ static void virtblk_remove(struct virtio_device *vdev)
 
 	blk_cleanup_queue(vblk->disk->queue);
 	put_disk(vblk->disk);
-	unregister_blkdev(major, "virtblk");
 	mempool_destroy(vblk->pool);
 	vdev->config->del_vq(vblk->vq);
 	kfree(vblk);
