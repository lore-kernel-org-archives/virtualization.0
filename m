From: Minfei Huang <mnghuan@gmail.com>
Subject: [PATCH RESEND] virtio_blk: Fix a slient kernel panic
Date: Tue,  9 Aug 2016 16:39:20 +0800
Message-ID: <1470731960-6868-1-git-send-email-mnghuan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: Minfei Huang <minfei.hmf@alibaba-inc.com>, linux-kernel@vger.kernel.org, Minfei Huang <mnghuan@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We do a lot of memory allocation in function init_vq, and don't handle
the allocation failure properly. Then this function will return 0,
although initialization fails due to lacking memory. At that moment,
kernel will panic in guest machine, if virtio is used to drive disk.

To fix this bug, we should take care of allocation failure, and return
correct value to let caller know what happen.

Tested-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Signed-off-by: Minfei Huang <mnghuan@gmail.com>
Signed-off-by: Minfei Huang <minfei.hmf@alibaba-inc.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/block/virtio_blk.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 1523e05..93b1aaa 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -391,22 +391,16 @@ static int init_vq(struct virtio_blk *vblk)
 		num_vqs = 1;
 
 	vblk->vqs = kmalloc(sizeof(*vblk->vqs) * num_vqs, GFP_KERNEL);
-	if (!vblk->vqs) {
-		err = -ENOMEM;
-		goto out;
-	}
+	if (!vblk->vqs)
+		return -ENOMEM;
 
 	names = kmalloc(sizeof(*names) * num_vqs, GFP_KERNEL);
-	if (!names)
-		goto err_names;
-
 	callbacks = kmalloc(sizeof(*callbacks) * num_vqs, GFP_KERNEL);
-	if (!callbacks)
-		goto err_callbacks;
-
 	vqs = kmalloc(sizeof(*vqs) * num_vqs, GFP_KERNEL);
-	if (!vqs)
-		goto err_vqs;
+	if (!names || !callbacks || !vqs) {
+		err = -ENOMEM;
+		goto out;
+	}
 
 	for (i = 0; i < num_vqs; i++) {
 		callbacks[i] = virtblk_done;
@@ -417,7 +411,7 @@ static int init_vq(struct virtio_blk *vblk)
 	/* Discover virtqueues and write information to configuration.  */
 	err = vdev->config->find_vqs(vdev, num_vqs, vqs, callbacks, names);
 	if (err)
-		goto err_find_vqs;
+		goto out;
 
 	for (i = 0; i < num_vqs; i++) {
 		spin_lock_init(&vblk->vqs[i].lock);
@@ -425,16 +419,12 @@ static int init_vq(struct virtio_blk *vblk)
 	}
 	vblk->num_vqs = num_vqs;
 
- err_find_vqs:
+out:
 	kfree(vqs);
- err_vqs:
 	kfree(callbacks);
- err_callbacks:
 	kfree(names);
- err_names:
 	if (err)
 		kfree(vblk->vqs);
- out:
 	return err;
 }
 
-- 
2.7.4 (Apple Git-66)
