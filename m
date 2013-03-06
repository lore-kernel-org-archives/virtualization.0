From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/3] vringh: don't flag already listening.
Date: Wed, 06 Mar 2013 15:59:20 +1100
Message-ID: <87ppzdazti.fsf@rustcorp.com.au>
References: <1362491468-16681-1-git-send-email-sjur.brandeland@stericsson.com>
	<871ubtcezb.fsf@rustcorp.com.au> <87sj49azw1.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87sj49azw1.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sjur.brandeland@stericsson.com, Ohad Ben-Cohen <ohad@wizery.com>, mst@redhat.com
Cc: sjur@brendeland.net, Linus Walleij <linus.walleij@linaro.org>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This doesn't work for eventidx:

1) vringh_notify_enable_user() gets called because the ring is empty
   (vrh->last_avail_idx == vrh->vring.avail->idx).
2) It puts vrh->last_avail_idx into vring_avail_event().
3) It sets ->listening to true.
4) Meanwhile, the other side has done more work, updating vrh->vring.avail->idx.
5) It notices vrh->vring.avail->idx has changed, so returns true to
   make us do more work.

But since the value we wrote into vring_avail_event() is past, we
won't get notified.  This happens rarely: only once I'd optimized
add_buf could I trigger this in about 1 in 10 runs.

Since it's so rare, just remove the listening flag: it's fine to do
this twice anyway.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 8234f2b..d4413d9 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -476,12 +476,6 @@ static inline bool __vringh_notify_enable(struct vringh *vrh,
 {
 	u16 avail;
 
-	/* Already enabled? */
-	if (vrh->listening)
-		return false;
-
-	vrh->listening = true;
-
 	if (!vrh->event_indices) {
 		/* Old-school; update flags. */
 		if (putu16(&vrh->vring.used->flags, 0) != 0) {
@@ -515,11 +509,6 @@ static inline bool __vringh_notify_enable(struct vringh *vrh,
 static inline void __vringh_notify_disable(struct vringh *vrh,
 					   int (*putu16)(u16 *p, u16 val))
 {
-	/* Already disabled? */
-	if (!vrh->listening)
-		return;
-
-	vrh->listening = false;
 	if (!vrh->event_indices) {
 		/* Old-school; update flags. */
 		if (putu16(&vrh->vring.used->flags, VRING_USED_F_NO_NOTIFY)) {
@@ -593,7 +582,6 @@ int vringh_init_user(struct vringh *vrh, u32 features,
 
 	vrh->event_indices = (features & (1 << VIRTIO_RING_F_EVENT_IDX));
 	vrh->weak_barriers = weak_barriers;
-	vrh->listening = false;
 	vrh->completed = 0;
 	vrh->last_avail_idx = 0;
 	vrh->last_used_idx = 0;
@@ -853,7 +841,6 @@ int vringh_init_kern(struct vringh *vrh, u32 features,
 
 	vrh->event_indices = (features & (1 << VIRTIO_RING_F_EVENT_IDX));
 	vrh->weak_barriers = weak_barriers;
-	vrh->listening = false;
 	vrh->completed = 0;
 	vrh->last_avail_idx = 0;
 	vrh->last_used_idx = 0;
diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index ab41185..44b94cd 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -33,9 +33,6 @@ struct vringh {
 	/* Guest publishes used event idx (note: we always do). */
 	bool event_indices;
 
-	/* Have we told the other end we want to be notified? */
-	bool listening;
-
 	/* Can we get away with weak barriers? */
 	bool weak_barriers;
