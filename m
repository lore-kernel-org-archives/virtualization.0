From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 2/2] virtio_balloon: do not change memory amount visible via
	/proc/meminfo
Date: Thu, 20 Aug 2015 00:49:49 +0300
Message-ID: <1440020989-10824-3-git-send-email-den@openvz.org>
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

Balloon device is frequently used as a mean of cooperative memory control
in between guest and host to manage memory overcommitment. This is the
typical case for any hosting workload when KVM guest is provided for
end-user.

Though there is a problem in this setup. The end-user and hosting provider
have signed SLA agreement in which some amount of memory is guaranted for
the guest. The good thing is that this memory will be given to the guest
when the guest will really need it (f.e. with OOM in guest and with
VIRTIO_BALLOON_F_DEFLATE_ON_OOM configuration flag set). The bad thing
is that end-user does not know this.

Balloon by default reduce the amount of memory exposed to the end-user
each time when the page is stolen from guest or returned back by using
adjust_managed_page_count and thus /proc/meminfo shows reduced amount
of memory.

Fortunately the solution is simple, we should just avoid to call
adjust_managed_page_count with VIRTIO_BALLOON_F_DEFLATE_ON_OOM set.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8543c9a..7efc329 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -157,7 +157,9 @@ static void fill_balloon(struct virtio_balloon *vb, size_t num)
 		}
 		set_page_pfns(vb->pfns + vb->num_pfns, page);
 		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
-		adjust_managed_page_count(page, -1);
+		if (!virtio_has_feature(vb->vdev,
+					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+			adjust_managed_page_count(page, -1);
 	}
 
 	/* Did we get any? */
@@ -173,7 +175,9 @@ static void release_pages_balloon(struct virtio_balloon *vb)
 	/* Find pfns pointing at start of each page, get pages and free them. */
 	for (i = 0; i < vb->num_pfns; i += VIRTIO_BALLOON_PAGES_PER_PAGE) {
 		struct page *page = balloon_pfn_to_page(vb->pfns[i]);
-		adjust_managed_page_count(page, 1);
+		if (!virtio_has_feature(vb->vdev,
+					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+			adjust_managed_page_count(page, 1);
 		put_page(page); /* balloon reference */
 	}
 }
-- 
2.1.4
