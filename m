From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/4] virtio_blk: Use kmalloc_array() in init_vq()
Date: Tue, 13 Sep 2016 14:12:01 +0200
Message-ID: <7a8dd874-3700-1445-2143-2a604cd043ab__12068.3601861403$1473768744$gmane$org@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
	<02054675-8395-ac81-6863-e3a5cbfc9032@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <02054675-8395-ac81-6863-e3a5cbfc9032@users.sourceforge.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 13 Sep 2016 11:32:22 +0200

Multiplications for the size determination of memory allocations
indicated that array data structures should be processed.
Thus use the corresponding function "kmalloc_array".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/virtio_blk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 93b1aaa..6553eb7 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -390,13 +390,13 @@ static int init_vq(struct virtio_blk *vblk)
 	if (err)
 		num_vqs = 1;
 
-	vblk->vqs = kmalloc(sizeof(*vblk->vqs) * num_vqs, GFP_KERNEL);
+	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
 	if (!vblk->vqs)
 		return -ENOMEM;
 
-	names = kmalloc(sizeof(*names) * num_vqs, GFP_KERNEL);
-	callbacks = kmalloc(sizeof(*callbacks) * num_vqs, GFP_KERNEL);
-	vqs = kmalloc(sizeof(*vqs) * num_vqs, GFP_KERNEL);
+	names = kmalloc_array(num_vqs, sizeof(*names), GFP_KERNEL);
+	callbacks = kmalloc_array(num_vqs, sizeof(*callbacks), GFP_KERNEL);
+	vqs = kmalloc_array(num_vqs, sizeof(*vqs), GFP_KERNEL);
 	if (!names || !callbacks || !vqs) {
 		err = -ENOMEM;
 		goto out;
-- 
2.10.0
