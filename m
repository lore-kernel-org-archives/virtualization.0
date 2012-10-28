From: Joe Perches <joe@perches.com>
Subject: [PATCH 14/16] virtio: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
Date: Sun, 28 Oct 2012 01:05:52 -0700
Message-ID: <a32fa314ea4f0318869f62d0942d3f1f936219d6.1351411048.git.joe@perches.com>
References: <cover.1351411047.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1351411047.git.joe@perches.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

dev_<level> calls take less code than dev_printk(KERN_<LEVEL>
and reducing object size is good.
Convert if (printk_ratelimit()) dev_printk to dev_<level>_ratelimited.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/virtio/virtio_balloon.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 0908e60..586395c 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -130,10 +130,9 @@ static void fill_balloon(struct virtio_balloon *vb, size_t num)
 		struct page *page = alloc_page(GFP_HIGHUSER | __GFP_NORETRY |
 					__GFP_NOMEMALLOC | __GFP_NOWARN);
 		if (!page) {
-			if (printk_ratelimit())
-				dev_printk(KERN_INFO, &vb->vdev->dev,
-					   "Out of puff! Can't get %zu pages\n",
-					   num);
+			dev_info_ratelimited(&vb->vdev->dev,
+					     "Out of puff! Can't get %zu pages\n",
+					     num);
 			/* Sleep for at least 1/5 of a second before retry. */
 			msleep(200);
 			break;
-- 
1.7.8.112.g3fd21
