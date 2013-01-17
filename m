From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 5/6] vringh: separate callback for notification.
Date: Thu, 17 Jan 2013 20:59:42 +1030
Message-ID: <1358418584-26345-5-git-send-email-rusty@rustcorp.com.au>
References: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This makes it possible to batch notifications, and the fewer barriers
helps performance:

Before: (./vringh_test --eventidx --parallel):
Using CPUS 0 and 3
Guest: notified 156428, pinged 156251
Host: notified 156251, pinged 78215
R=4.575 U=3.520 S=3.520
Using CPUS 0 and 3
Guest: notified 156617, pinged 156250
Host: notified 156250, pinged 78310
R=4.511 U=3.580 S=3.580
Using CPUS 0 and 3
Guest: notified 156357, pinged 156251
Host: notified 156251, pinged 78179
R=4.518 U=3.536 S=3.536

After:
Using CPUS 0 and 3
Guest: notified 156394, pinged 156251
Host: notified 156251, pinged 78197
R=4.282 U=3.456 S=3.456
Using CPUS 0 and 3
Guest: notified 156578, pinged 156251
Host: notified 156251, pinged 78289
R=4.248 U=3.436 S=3.436
Using CPUS 0 and 3
Guest: notified 156594, pinged 156251
Host: notified 156251, pinged 78297
R=4.329 U=3.416 S=3.416

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/vhost/vringh.c |   89 +++++++++++++++++++++++++++++++++---------------
 include/linux/vringh.h |   15 +++++---
 2 files changed, 72 insertions(+), 32 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index b28670f..ab10da8 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -290,13 +290,12 @@ static inline int __vringh_complete(struct vringh *vrh, u16 idx, u32 len,
 				    int (*putu16)(u16 *p, u16 val),
 				    int (*putused)(struct vring_used_elem *dst,
 						   const struct vring_used_elem
-						   *s),
-				    bool *notify)
+						   *s))
 {
 	struct vring_used_elem used;
 	struct vring_used *used_ring;
 	int err;
-	u16 used_idx, old, used_event;
+	u16 used_idx;
 
 	used.id = idx;
 	used.len = len;
@@ -309,7 +308,7 @@ static inline int __vringh_complete(struct vringh *vrh, u16 idx, u32 len,
 	}
 
 	used_ring = vrh->vring.used;
-	used_idx = vrh->last_used_idx;
+	used_idx = vrh->last_used_idx + vrh->completed;
 
 	err = putused(&used_ring->ring[used_idx % vrh->vring.num],
 		      &used);
@@ -323,19 +322,24 @@ static inline int __vringh_complete(struct vringh *vrh, u16 idx, u32 len,
 	/* Make sure buffer is written before we update index. */
 	virtio_wmb(vrh->weak_barriers);
 
-	old = vrh->last_used_idx;
-	vrh->last_used_idx++;
-
-	err = putu16(&vrh->vring.used->idx, vrh->last_used_idx);
+	err = putu16(&vrh->vring.used->idx, used_idx + 1);
 	if (err) {
 		vringh_bad("Failed to update used index at %p",
 			   &vrh->vring.used->idx);
 		return err;
 	}
 
-	/* If we already know we need to notify, skip re-checking */
-	if (*notify)
-		return 0;
+	vrh->completed++;
+	return 0;
+}
+
+
+static inline int __vringh_need_notify(struct vringh *vrh,
+				       int (*getu16)(u16 *val, const u16 *p))
+{
+	bool notify;
+	u16 used_event;
+	int err;
 
 	/* Flush out used index update. This is paired with the
 	 * barrier that the Guest executes when enabling
@@ -351,21 +355,28 @@ static inline int __vringh_complete(struct vringh *vrh, u16 idx, u32 len,
 				   &vrh->vring.avail->flags);
 			return err;
 		}
-		if (!(flags & VRING_AVAIL_F_NO_INTERRUPT))
-			*notify = true;
-		return 0;
+		return (!(flags & VRING_AVAIL_F_NO_INTERRUPT));
 	}
 
-	/* Modern: we know where other side is up to. */
+	/* Modern: we know when other side wants to know. */
 	err = getu16(&used_event, &vring_used_event(&vrh->vring));
 	if (err) {
 		vringh_bad("Failed to get used event idx at %p",
 			   &vring_used_event(&vrh->vring));
 		return err;
 	}
-	if (vring_need_event(used_event, vrh->last_used_idx, old))
-		*notify = true;
-	return 0;
+
+	/* Just in case we added so many that we wrap. */
+	if (unlikely(vrh->completed > 0xffff))
+		notify = true;
+	else
+		notify = vring_need_event(used_event,
+					  vrh->last_used_idx + vrh->completed,
+					  vrh->last_used_idx);
+
+	vrh->last_used_idx += vrh->completed;
+	vrh->completed = 0;
+	return notify;
 }
 
 static inline bool __vringh_notify_enable(struct vringh *vrh,
@@ -587,14 +598,14 @@ void vringh_abandon_user(struct vringh *vrh, unsigned int num)
  * @vrh: the vring.
  * @head: the head as filled in by vringh_getdesc_user.
  * @len: the length of data we have written.
- * @notify: set if we should notify the other side, otherwise left alone.
+ *
+ * You should check vringh_need_notify_user() after one or more calls
+ * to this function.
  */
-int vringh_complete_user(struct vringh *vrh, u16 head, u32 len,
-			 bool *notify)
+int vringh_complete_user(struct vringh *vrh, u16 head, u32 len)
 {
 	return __vringh_complete(vrh, head, len,
-				 getu16_user, putu16_user, putused_user,
-				 notify);
+				 getu16_user, putu16_user, putused_user);
 }
 
 /**
@@ -621,6 +632,17 @@ void vringh_notify_disable_user(struct vringh *vrh)
 	__vringh_notify_disable(vrh, putu16_user);
 }
 
+/**
+ * vringh_need_notify_user - must we tell the other side about used buffers?
+ * @vrh: the vring we've called vringh_complete_user() on.
+ *
+ * Returns -errno or 0 if we don't need to tell the other side, 1 if we do.
+ */
+int vringh_need_notify_user(struct vringh *vrh)
+{
+	return __vringh_need_notify(vrh, getu16_user);
+}
+
 /* Kernelspace access helpers. */
 static inline int getu16_kern(u16 *val, const u16 *p)
 {
@@ -783,14 +805,14 @@ void vringh_abandon_kern(struct vringh *vrh, unsigned int num)
  * @vrh: the vring.
  * @head: the head as filled in by vringh_getdesc_kern.
  * @len: the length of data we have written.
- * @notify: set if we should notify the other side, otherwise left alone.
+ *
+ * You should check vringh_need_notify_kern() after one or more calls
+ * to this function.
  */
-int vringh_complete_kern(struct vringh *vrh, u16 head, u32 len,
-			 bool *notify)
+int vringh_complete_kern(struct vringh *vrh, u16 head, u32 len)
 {
 	return __vringh_complete(vrh, head, len,
-				 getu16_kern, putu16_kern, putused_kern,
-				 notify);
+				 getu16_kern, putu16_kern, putused_kern);
 }
 
 /**
@@ -816,3 +838,14 @@ void vringh_notify_disable_kern(struct vringh *vrh)
 {
 	__vringh_notify_disable(vrh, putu16_kern);
 }
+
+/**
+ * vringh_need_notify_kern - must we tell the other side about used buffers?
+ * @vrh: the vring we've called vringh_complete_kern() on.
+ *
+ * Returns -errno or 0 if we don't need to tell the other side, 1 if we do.
+ */
+int vringh_need_notify_kern(struct vringh *vrh)
+{
+	return __vringh_need_notify(vrh, getu16_kern);
+}
diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 508b5e5..9df86e9 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -44,6 +44,9 @@ struct vringh {
 	/* Last index we used. */
 	u16 last_used_idx;
 
+	/* How many descriptors we've completed since last need_notify(). */
+	u32 completed;
+
 	/* The vring (note: it may contain user pointers!) */
 	struct vring vring;
 };
@@ -83,13 +86,15 @@ ssize_t vringh_iov_pull_user(struct vringh_iov *riov, void *dst, size_t len);
 ssize_t vringh_iov_push_user(struct vringh_iov *wiov,
 			     const void *src, size_t len);
 
-/* Mark a descriptor as used.  Sets notify if you should fire eventfd. */
-int vringh_complete_user(struct vringh *vrh, u16 head, u32 len,
-			 bool *notify);
+/* Mark a descriptor as used. */
+int vringh_complete_user(struct vringh *vrh, u16 head, u32 len);
 
 /* Pretend we've never seen descriptor (for easy error handling). */
 void vringh_abandon_user(struct vringh *vrh, unsigned int num);
 
+/* Do we need to fire the eventfd to notify the other side? */
+int vringh_need_notify_user(struct vringh *vrh);
+
 /* Helpers for kernelspace vrings. */
 int vringh_init_kern(struct vringh *vrh, u32 features,
 		     unsigned int num, bool weak_barriers,
@@ -107,9 +112,11 @@ ssize_t vringh_iov_pull_kern(struct vringh_iov *riov, void *dst, size_t len);
 ssize_t vringh_iov_push_user(struct vringh_iov *wiov,
 			     const void *src, size_t len);
 void vringh_abandon_kern(struct vringh *vrh, unsigned int num);
-int vringh_complete_kern(struct vringh *vrh, u16 head, u32 len, bool *notify);
+int vringh_complete_kern(struct vringh *vrh, u16 head, u32 len);
 
 bool vringh_notify_enable_kern(struct vringh *vrh);
 void vringh_notify_disable_kern(struct vringh *vrh);
 
+int vringh_need_notify_kern(struct vringh *vrh);
+
 #endif /* _LINUX_VRINGH_H */
-- 
1.7.10.4
