From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/3] virtio_balloon: Remove unnecessarily persistent state
Date: Thu, 12 Apr 2012 15:36:33 +1000
Message-ID: <1334208995-29985-2-git-send-email-david__3569.41660070351$1334209046$gmane$org@gibson.dropbear.id.au>
References: <1334208995-29985-1-git-send-email-david@gibson.dropbear.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1334208995-29985-1-git-send-email-david@gibson.dropbear.id.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, mst@redhat.com
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The main virtio_balloon state structure contains the fields num_pfns and
array 'pfns'.  Although they are stored here persistently, the lifetime of
useful data in there is never more than one function - they're essentially
used as though they were local variables.

For the pfns buffer, used to communicate a batch of pfns this is useful to
avoid either transient kmalloc()s or putting too much data on the stack.
For num_pfns, there is no reason it should not be a local, though.

This patch cleans things up by making num_pfns a local in the functions it
is used in.  The pfns array remains, but the comment is updated to clarify
that it contains no truly persistent data.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 drivers/virtio/virtio_balloon.c |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 05f0a80..6c07793 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -46,8 +46,8 @@ struct virtio_balloon
 	unsigned int num_pages;
 	struct list_head pages;
 
-	/* The array of pfns we tell the Host about. */
-	unsigned int num_pfns;
+	/* Temporary buffer of pfns to pass to the host */
+	/* Store this here to avoid a too-large local array */
 	u32 pfns[256];
 
 	/* Memory statistics */
@@ -79,11 +79,12 @@ static void balloon_ack(struct virtqueue *vq)
 		complete(&vb->acked);
 }
 
-static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
+static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq,
+		      unsigned int n)
 {
 	struct scatterlist sg;
 
-	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
+	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * n);
 
 	init_completion(&vb->acked);
 
@@ -98,10 +99,12 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 
 static void fill_balloon(struct virtio_balloon *vb, size_t num)
 {
+	unsigned int n;
+
 	/* We can only do one array worth at a time. */
 	num = min(num, ARRAY_SIZE(vb->pfns));
 
-	for (vb->num_pfns = 0; vb->num_pfns < num; vb->num_pfns++) {
+	for (n = 0; n < num; n++) {
 		struct page *page = alloc_page(GFP_HIGHUSER | __GFP_NORETRY |
 					__GFP_NOMEMALLOC | __GFP_NOWARN);
 		if (!page) {
@@ -113,17 +116,17 @@ static void fill_balloon(struct virtio_balloon *vb, size_t num)
 			msleep(200);
 			break;
 		}
-		vb->pfns[vb->num_pfns] = page_to_balloon_pfn(page);
+		vb->pfns[n] = page_to_balloon_pfn(page);
 		totalram_pages--;
 		vb->num_pages++;
 		list_add(&page->lru, &vb->pages);
 	}
 
 	/* Didn't get any?  Oh well. */
-	if (vb->num_pfns == 0)
+	if (n == 0)
 		return;
 
-	tell_host(vb, vb->inflate_vq);
+	tell_host(vb, vb->inflate_vq, n);
 }
 
 static void release_pages_by_pfn(const u32 pfns[], unsigned int num)
@@ -139,14 +142,15 @@ static void release_pages_by_pfn(const u32 pfns[], unsigned int num)
 static void leak_balloon(struct virtio_balloon *vb, size_t num)
 {
 	struct page *page;
+	unsigned int n;
 
 	/* We can only do one array worth at a time. */
 	num = min(num, ARRAY_SIZE(vb->pfns));
 
-	for (vb->num_pfns = 0; vb->num_pfns < num; vb->num_pfns++) {
+	for (n = 0; n < num; n++) {
 		page = list_first_entry(&vb->pages, struct page, lru);
 		list_del(&page->lru);
-		vb->pfns[vb->num_pfns] = page_to_balloon_pfn(page);
+		vb->pfns[n] = page_to_balloon_pfn(page);
 		vb->num_pages--;
 	}
 
@@ -155,8 +159,8 @@ static void leak_balloon(struct virtio_balloon *vb, size_t num)
 	 * virtio_has_feature(vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST);
 	 * is true, we *have* to do it in this order
 	 */
-	tell_host(vb, vb->deflate_vq);
-	release_pages_by_pfn(vb->pfns, vb->num_pfns);
+	tell_host(vb, vb->deflate_vq, n);
+	release_pages_by_pfn(vb->pfns, n);
 }
 
 static inline void update_stat(struct virtio_balloon *vb, int idx,
-- 
1.7.9.5
