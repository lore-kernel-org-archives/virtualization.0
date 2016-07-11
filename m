From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 1/1] balloon: check the number of available pages in leak
	balloon
Date: Mon, 11 Jul 2016 15:28:59 +0300
Message-ID: <1468240139-16873-1-git-send-email-den__45827.5989316919$1468242635$gmane$org@openvz.org>
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
To: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: den@openvz.org, Konstantin Neumoin <kneumoin@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Konstantin Neumoin <kneumoin@virtuozzo.com>

The balloon has a special mechanism that is subscribed to the oom
notification which leads to deflation for a fixed number of pages.
The number is always fixed even when the balloon is fully deflated.
But leak_balloon did not expect that the pages to deflate will be more
than taken, and raise a "BUG" in balloon_page_dequeue when page list
will be empty.

So, the simplest solution would be to check that the number of releases
pages is less or equal to the number taken pages.

Signed-off-by: Konstantin Neumoin <kneumoin@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 476c0e3..f6ea8f4 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -202,6 +202,8 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
 	num = min(num, ARRAY_SIZE(vb->pfns));
 
 	mutex_lock(&vb->balloon_lock);
+	/* We can't release more pages than taken */
+	num = min(num, (size_t)vb->num_pages);
 	for (vb->num_pfns = 0; vb->num_pfns < num;
 	     vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
 		page = balloon_page_dequeue(vb_dev_info);
-- 
2.1.4
