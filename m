From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio/ringtest: virtio_ring: fix up need_event math
Date: Fri, 27 Oct 2017 16:11:13 +0300
Message-ID: <1509109839-553-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

last kicked event index must be updated unconditionally:
even if we don't need to kick, we do not want to re-check
the same entry for events.

Reported-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/ringtest/virtio_ring_0_9.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/virtio/ringtest/virtio_ring_0_9.c b/tools/virtio/ringtest/virtio_ring_0_9.c
index bbc3043..5fd3fbc 100644
--- a/tools/virtio/ringtest/virtio_ring_0_9.c
+++ b/tools/virtio/ringtest/virtio_ring_0_9.c
@@ -225,16 +225,18 @@ bool enable_call()
 
 void kick_available(void)
 {
+	bool need;
+
 	/* Flush in previous flags write */
 	/* Barrier C (for pairing) */
 	smp_mb();
-	if (!vring_need_event(vring_avail_event(&ring),
-			      guest.avail_idx,
-			      guest.kicked_avail_idx))
-		return;
+	need = vring_need_event(vring_avail_event(&ring),
+				guest.avail_idx,
+				guest.kicked_avail_idx);
 
 	guest.kicked_avail_idx = guest.avail_idx;
-	kick();
+	if (need)
+		kick();
 }
 
 /* host side */
@@ -316,14 +318,16 @@ bool use_buf(unsigned *lenp, void **bufp)
 
 void call_used(void)
 {
+	bool need;
+
 	/* Flush in previous flags write */
 	/* Barrier D (for pairing) */
 	smp_mb();
-	if (!vring_need_event(vring_used_event(&ring),
-			      host.used_idx,
-			      host.called_used_idx))
-		return;
+	need = vring_need_event(vring_used_event(&ring),
+				host.used_idx,
+				host.called_used_idx);
 
 	host.called_used_idx = host.used_idx;
-	call();
+	if (need)
+		call();
 }
-- 
MST
