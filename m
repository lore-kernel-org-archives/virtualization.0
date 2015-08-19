From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 1/2] virtio_ballon: change stub of release_pages_by_pfn
Date: Thu, 20 Aug 2015 00:49:48 +0300
Message-ID: <1440020989-10824-2-git-send-email-den@openvz.org>
References: <1440020989-10824-1-git-send-email-den@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1440020989-10824-1-git-send-email-den@openvz.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: "Denis V. Lunev" <den@openvz.org>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

and rename it to release_pages_balloon. The function originally takes
arrays of pfns and now it takes pointer to struct virtio_ballon.
This change is necessary to conditionally call adjust_managed_page_count
in the next patch.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 82e80e0..8543c9a 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -166,13 +166,13 @@ static void fill_balloon(struct virtio_balloon *vb, size_t num)
 	mutex_unlock(&vb->balloon_lock);
 }
 
-static void release_pages_by_pfn(const u32 pfns[], unsigned int num)
+static void release_pages_balloon(struct virtio_balloon *vb)
 {
 	unsigned int i;
 
 	/* Find pfns pointing at start of each page, get pages and free them. */
-	for (i = 0; i < num; i += VIRTIO_BALLOON_PAGES_PER_PAGE) {
-		struct page *page = balloon_pfn_to_page(pfns[i]);
+	for (i = 0; i < vb->num_pfns; i += VIRTIO_BALLOON_PAGES_PER_PAGE) {
+		struct page *page = balloon_pfn_to_page(vb->pfns[i]);
 		adjust_managed_page_count(page, 1);
 		put_page(page); /* balloon reference */
 	}
@@ -206,7 +206,7 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
 	if (vb->num_pfns != 0)
 		tell_host(vb, vb->deflate_vq);
 	mutex_unlock(&vb->balloon_lock);
-	release_pages_by_pfn(vb->pfns, vb->num_pfns);
+	release_pages_balloon(vb);
 	return num_freed_pages;
 }
 
-- 
2.1.4
