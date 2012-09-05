From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] virtio-blk: fix NULL checking in virtblk_alloc_req()
Date: Wed, 5 Sep 2012 15:32:53 +0300
Message-ID: <20120905123252.GE6128@elgon.mountain>
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
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Smatch complains about the inconsistent NULL checking here.  Fix it to
return NULL on failure.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is only needed in linux-next.

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2edfb5c..457db0c 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -90,10 +90,11 @@ static inline struct virtblk_req *virtblk_alloc_req(struct virtio_blk *vblk,
 	struct virtblk_req *vbr;
 
 	vbr = mempool_alloc(vblk->pool, gfp_mask);
-	if (vbr && use_bio)
-		sg_init_table(vbr->sg, vblk->sg_elems);
+	if (!vbr)
+		return NULL;
 
-	vbr->vblk = vblk;
+	if (use_bio)
+		sg_init_table(vbr->sg, vblk->sg_elems);
 
 	return vbr;
 }
