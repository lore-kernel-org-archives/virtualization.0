From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/8] virtio_blk: add request_vqs/free_vqs calls
Date: Mon, 27 Apr 2009 15:32:13 +0300
Message-ID: <20090427123213.GA1166__47069.6709621281$1240855872$gmane$org@redhat.com>
References: <cover.1240832196.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1240832196.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Add request_vqs/free_vqs calls to virtio_blk.
These will be required for MSI support.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 5d34764..523eddc 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -224,10 +224,14 @@ static int virtblk_probe(struct virtio_device *vdev)
 	sg_init_table(vblk->sg, vblk->sg_elems);
 
 	/* We expect one virtqueue, for output. */
+	err = virtio_request_vqs(vdev, 1);
+	if (err)
+		goto out_free_vblk;
+
 	vblk->vq = vdev->config->find_vq(vdev, 0, blk_done);
 	if (IS_ERR(vblk->vq)) {
 		err = PTR_ERR(vblk->vq);
-		goto out_free_vblk;
+		goto out_free_vqs;
 	}
 
 	vblk->pool = mempool_create_kmalloc_pool(1,sizeof(struct virtblk_req));
@@ -324,6 +328,8 @@ out_mempool:
 	mempool_destroy(vblk->pool);
 out_free_vq:
 	vdev->config->del_vq(vblk->vq);
+out_free_vqs:
+	virtio_free_vqs(vdev);
 out_free_vblk:
 	kfree(vblk);
 out:
@@ -345,6 +351,7 @@ static void virtblk_remove(struct virtio_device *vdev)
 	put_disk(vblk->disk);
 	mempool_destroy(vblk->pool);
 	vdev->config->del_vq(vblk->vq);
+	virtio_free_vqs(vdev);
 	kfree(vblk);
 }
 
-- 
1.6.0.6
