From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/6] virtio: ignore corrupted virtqueues rather than spinning.
Date: Wed, 23 Apr 2008 23:55:47 -0500
Message-ID: <200804241455.47462.rusty__33889.7756104872$1209013132$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


A corrupt virtqueue (caused by the other end screwing up) can have
strange results such as a driver spinning: just bail when we try to
get a buffer from a known-broken queue.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_ring.c |    5 +++++
 1 file changed, 5 insertions(+)

diff -r cbd83e592664 drivers/virtio/virtio_ring.c
--- a/drivers/virtio/virtio_ring.c	Fri Apr 04 22:42:47 2008 +1100
+++ b/drivers/virtio/virtio_ring.c	Sat Apr 05 21:12:42 2008 +1100
@@ -184,6 +184,11 @@ static void *vring_get_buf(struct virtqu
 
 	START_USE(vq);
 
+	if (unlikely(vq->broken)) {
+		END_USE(vq);
+		return NULL;
+	}
+
 	if (!more_used(vq)) {
 		pr_debug("No more buffers in queue\n");
 		END_USE(vq);
