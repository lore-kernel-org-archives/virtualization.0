From: Minfei Huang <mnghuan@gmail.com>
Subject: [PATCH] virtio: Return correct errno for function init_vq's failure
Date: Mon, 27 Jun 2016 10:09:18 +0800
Message-ID: <1466993358-12064-1-git-send-email-mnghuan__27731.0733370998$1467395519$gmane$org@gmail.com>
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

The error number -ENOENT or 0 will be returned, if we can not allocate
more memory in function init_vq. If host can support multiple virtual
queues, and we fails to allocate necessary memory structures for vq,
kernel may crash due to incorrect returning.

To fix it, kernel will return correct value in init_vq.

Signed-off-by: Minfei Huang <mnghuan@gmail.com>
Signed-off-by: Minfei Huang <minfei.hmf@alibaba-inc.com>
---
 drivers/block/virtio_blk.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 42758b5..40ecb2b 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -393,11 +393,10 @@ static int init_vq(struct virtio_blk *vblk)
 	if (err)
 		num_vqs = 1;
 
+	err = -ENOMEM;
 	vblk->vqs = kmalloc(sizeof(*vblk->vqs) * num_vqs, GFP_KERNEL);
-	if (!vblk->vqs) {
-		err = -ENOMEM;
+	if (!vblk->vqs)
 		goto out;
-	}
 
 	names = kmalloc(sizeof(*names) * num_vqs, GFP_KERNEL);
 	if (!names)
-- 
2.7.4 (Apple Git-66)
