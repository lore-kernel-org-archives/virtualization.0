From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 15/16] virtio_balloon: use simplified virtqueue accessors.
Date: Tue, 19 Feb 2013 18:26:33 +1030
Message-ID: <1361260594-601-16-git-send-email-rusty__19810.3898358115$1361261209$gmane$org@rustcorp.com.au>
References: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We never add buffers with input and output parts, so use the new accessors.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_balloon.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8dab163..bd3ae32 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -108,7 +108,7 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
 
 	/* We should always be able to add one buffer to an empty queue. */
-	if (virtqueue_add_buf(vq, &sg, 1, 0, vb, GFP_KERNEL) < 0)
+	if (virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL) < 0)
 		BUG();
 	virtqueue_kick(vq);
 
@@ -256,7 +256,7 @@ static void stats_handle_request(struct virtio_balloon *vb)
 	if (!virtqueue_get_buf(vq, &len))
 		return;
 	sg_init_one(&sg, vb->stats, sizeof(vb->stats));
-	if (virtqueue_add_buf(vq, &sg, 1, 0, vb, GFP_KERNEL) < 0)
+	if (virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL) < 0)
 		BUG();
 	virtqueue_kick(vq);
 }
@@ -341,7 +341,7 @@ static int init_vqs(struct virtio_balloon *vb)
 		 * use it to signal us later.
 		 */
 		sg_init_one(&sg, vb->stats, sizeof vb->stats);
-		if (virtqueue_add_buf(vb->stats_vq, &sg, 1, 0, vb, GFP_KERNEL)
+		if (virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb, GFP_KERNEL)
 		    < 0)
 			BUG();
 		virtqueue_kick(vb->stats_vq);
-- 
1.7.10.4
