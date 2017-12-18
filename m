From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2] virtio/ringtest: fix up need_event math
Date: Mon, 18 Dec 2017 08:15:22 +0200
Message-ID: <1513577626-1220-1-git-send-email-mst__31078.0728738338$1513577667$gmane$org@redhat.com>
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

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Changes from v1:
	fix inverted logic in call_used

 tools/virtio/ringtest/ring.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/virtio/ringtest/ring.c b/tools/virtio/ringtest/ring.c
index 747c5dd..2b9859b 100644
--- a/tools/virtio/ringtest/ring.c
+++ b/tools/virtio/ringtest/ring.c
@@ -188,16 +188,18 @@ bool enable_call()
 
 void kick_available(void)
 {
+	bool need;
+
 	/* Flush in previous flags write */
 	/* Barrier C (for pairing) */
 	smp_mb();
-	if (!need_event(event->kick_index,
-			guest.avail_idx,
-			guest.kicked_avail_idx))
-		return;
+	need = need_event(event->kick_index,
+			   guest.avail_idx,
+			   guest.kicked_avail_idx);
 
 	guest.kicked_avail_idx = guest.avail_idx;
-	kick();
+	if (need)
+		kick();
 }
 
 /* host side */
@@ -253,14 +255,18 @@ bool use_buf(unsigned *lenp, void **bufp)
 
 void call_used(void)
 {
+	bool need;
+
 	/* Flush in previous flags write */
 	/* Barrier D (for pairing) */
 	smp_mb();
-	if (!need_event(event->call_index,
+
+	need = need_event(event->call_index,
 			host.used_idx,
-			host.called_used_idx))
-		return;
+			host.called_used_idx);
 
 	host.called_used_idx = host.used_idx;
-	call();
+
+	if (need)
+		call();
 }
-- 
MST
