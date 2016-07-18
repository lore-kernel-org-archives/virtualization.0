From: Minfei Huang <mnfhuang@gmail.com>
Subject: [PATCH v2] virtio_blk: Fix a slient kernel panic
Date: Mon, 18 Jul 2016 22:01:29 +0800
Message-ID: <1468850489-40157-1-git-send-email-mnghuan__30527.4057122462$1468853155$gmane$org@gmail.com>
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
To: mst@redhat.com, cornelia.huck@de.ibm.com
Cc: Minfei Huang <minfei.hmf@alibaba-inc.com>, fanc.fnst@cn.fujitsu.com, linux-kernel@vger.kernel.org, Minfei Huang <mnghuan@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We do a lot of memory allocation in function init_vq, and don't handle
the allocation failure properly. Then this function will return 0,
although initialization fails due to lacking memory. At that moment,
kernel will panic in guest machine, if virtio is used to drive disk.

To fix this bug, we should take care of allocation failure, and return
correct value to let caller know what happen.

Tested-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Signed-off-by: Minfei Huang <minfei.hmf@alibaba-inc.com>
Signed-off-by: Minfei Huang <mnghuan@gmail.com>
---
v1:
- Refactor the patch to make code more readable
---
 drivers/block/virtio_blk.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 42758b5..d920512 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -381,9 +381,9 @@ static int init_vq(struct virtio_blk *vblk)
 {
 	int err = 0;
 	int i;
-	vq_callback_t **callbacks;
-	const char **names;
-	struct virtqueue **vqs;
+	vq_callback_t **callbacks = NULL;
+	const char **names = NULL;
+	struct virtqueue **vqs = NULL;
 	unsigned short num_vqs;
 	struct virtio_device *vdev = vblk->vdev;
 
@@ -394,22 +394,16 @@ static int init_vq(struct virtio_blk *vblk)
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
@@ -420,7 +414,7 @@ static int init_vq(struct virtio_blk *vblk)
 	/* Discover virtqueues and write information to configuration.  */
 	err = vdev->config->find_vqs(vdev, num_vqs, vqs, callbacks, names);
 	if (err)
-		goto err_find_vqs;
+		goto out;
 
 	for (i = 0; i < num_vqs; i++) {
 		spin_lock_init(&vblk->vqs[i].lock);
@@ -428,16 +422,12 @@ static int init_vq(struct virtio_blk *vblk)
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
