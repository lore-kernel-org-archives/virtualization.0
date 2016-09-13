From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 4/4] virtio_blk: Rename a jump label in virtblk_get_id()
Date: Tue, 13 Sep 2016 14:15:20 +0200
Message-ID: <a303f7a6-c675-5228-99bd-a03c9e9252e9__4838.51443646035$1473768940$gmane$org@users.sourceforge.net>
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
Date: Tue, 13 Sep 2016 13:50:56 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/block/virtio_blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 696f452..fef2bd0 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -247,10 +247,10 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 
 	err = blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
 	if (err)
-		goto out;
+		goto put_request;
 
 	err = blk_execute_rq(vblk->disk->queue, vblk->disk, req, false);
-out:
+ put_request:
 	blk_put_request(req);
 	return err;
 }
-- 
2.10.0
