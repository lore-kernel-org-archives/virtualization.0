Return-Path: <SRS0=r7vL=NO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42DBC4338F
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 08:15:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BBC6138E
	for <virtualization@archiver.kernel.org>; Mon, 23 Aug 2021 08:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 75BBC6138E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D9DA40280;
	Mon, 23 Aug 2021 08:15:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6DEFxjGonHqb; Mon, 23 Aug 2021 08:14:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E7858401EF;
	Mon, 23 Aug 2021 08:14:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7E98C0010;
	Mon, 23 Aug 2021 08:14:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3ADBCC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 08:14:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 202A440144
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 08:14:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=axis.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wCT2BrAgGlco
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 08:14:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5FBAC400D2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Aug 2021 08:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1629706492;
 x=1661242492;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=32tMdW/MLxZqNlGhqw7Ozd6NQxd2ifBcs6cYnFP5KZA=;
 b=e1cBSkdNAU4KthPEUbd89e7gs3GMutalQiXZZJLy+in6z8vpV1ghbH7x
 sIIbzA3hvUPnMtNBqMnRYHJQpjzC3Xv/55W7jOLDtpeauEwH5Oga1bEnf
 e6wYRPuNoHF4nwvLyVwK885RWxUUSptmApaKFyKcGV7OBGUkXd42oDfZW
 akeCTcME/UOWB5QM8kodHU4mn1Dp6dukXr/YN4f7rUY5xMVcnOLIyfOqn
 9btbleMt9P1u+baYCqNaSF9pnTkTz8syBinZCYMwRiD6v0gdDm/hy8Qeg
 bEUCocLQdOPFmE7qr8u/jF2e5hzbrFkPaD64t+hb2DeMPsc1mqSp7wmHp Q==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH] vhost: add support for mandatory barriers
Date: Mon, 23 Aug 2021 10:14:37 +0200
Message-ID: <20210823081437.14274-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kernel@axis.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

vhost always uses SMP-conditional barriers, but these may not be
sufficient when vhost is used to communicate between heterogeneous
processors in an AMP configuration, especially since they're NOPs on
!SMP builds.

To solve this, use the virtio_*() barrier functions and ask them for
non-weak barriers if requested by userspace.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/vhost/vhost.c      | 23 ++++++++++++++---------
 drivers/vhost/vhost.h      |  2 ++
 include/uapi/linux/vhost.h |  2 ++
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index b9e853e6094d..f7172e1bc395 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -500,6 +500,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 		vq->indirect = NULL;
 		vq->heads = NULL;
 		vq->dev = dev;
+		vq->weak_barriers = true;
 		mutex_init(&vq->mutex);
 		vhost_vq_reset(dev, vq);
 		if (vq->handle_kick)
@@ -1801,6 +1802,10 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 		if (ctx)
 			eventfd_ctx_put(ctx);
 		break;
+	case VHOST_SET_STRONG_BARRIERS:
+		for (i = 0; i < d->nvqs; ++i)
+			d->vqs[i]->weak_barriers = false;
+		break;
 	default:
 		r = -ENOIOCTLCMD;
 		break;
@@ -1927,7 +1932,7 @@ int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
 	int i, r;
 
 	/* Make sure data written is seen before log. */
-	smp_wmb();
+	virtio_wmb(vq->weak_barriers);
 
 	if (vq->iotlb) {
 		for (i = 0; i < count; i++) {
@@ -1964,7 +1969,7 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
 		return -EFAULT;
 	if (unlikely(vq->log_used)) {
 		/* Make sure the flag is seen before log. */
-		smp_wmb();
+		virtio_wmb(vq->weak_barriers);
 		/* Log used flag write. */
 		used = &vq->used->flags;
 		log_used(vq, (used - (void __user *)vq->used),
@@ -1982,7 +1987,7 @@ static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
 	if (unlikely(vq->log_used)) {
 		void __user *used;
 		/* Make sure the event is seen before log. */
-		smp_wmb();
+		virtio_wmb(vq->weak_barriers);
 		/* Log avail event write */
 		used = vhost_avail_event(vq);
 		log_used(vq, (used - (void __user *)vq->used),
@@ -2228,7 +2233,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 		/* Only get avail ring entries after they have been
 		 * exposed by guest.
 		 */
-		smp_rmb();
+		virtio_rmb(vq->weak_barriers);
 	}
 
 	/* Grab the next descriptor number they're advertising, and increment
@@ -2367,7 +2372,7 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
 	}
 	if (unlikely(vq->log_used)) {
 		/* Make sure data is seen before log. */
-		smp_wmb();
+		virtio_wmb(vq->weak_barriers);
 		/* Log used ring entry write. */
 		log_used(vq, ((void __user *)used - (void __user *)vq->used),
 			 count * sizeof *used);
@@ -2402,14 +2407,14 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
 	r = __vhost_add_used_n(vq, heads, count);
 
 	/* Make sure buffer is written before we update index. */
-	smp_wmb();
+	virtio_wmb(vq->weak_barriers);
 	if (vhost_put_used_idx(vq)) {
 		vq_err(vq, "Failed to increment used idx");
 		return -EFAULT;
 	}
 	if (unlikely(vq->log_used)) {
 		/* Make sure used idx is seen before log. */
-		smp_wmb();
+		virtio_wmb(vq->weak_barriers);
 		/* Log used index update. */
 		log_used(vq, offsetof(struct vring_used, idx),
 			 sizeof vq->used->idx);
@@ -2428,7 +2433,7 @@ static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 	/* Flush out used index updates. This is paired
 	 * with the barrier that the Guest executes when enabling
 	 * interrupts. */
-	smp_mb();
+	virtio_mb(vq->weak_barriers);
 
 	if (vhost_has_feature(vq, VIRTIO_F_NOTIFY_ON_EMPTY) &&
 	    unlikely(vq->avail_idx == vq->last_avail_idx))
@@ -2530,7 +2535,7 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 	}
 	/* They could have slipped one in as we were doing that: make
 	 * sure it's written, then check again. */
-	smp_mb();
+	virtio_mb(vq->weak_barriers);
 	r = vhost_get_avail_idx(vq, &avail_idx);
 	if (r) {
 		vq_err(vq, "Failed to check avail idx at %p: %d\n",
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 638bb640d6b4..5bd20d0db457 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -108,6 +108,8 @@ struct vhost_virtqueue {
 	bool log_used;
 	u64 log_addr;
 
+	bool weak_barriers;
+
 	struct iovec iov[UIO_MAXIOV];
 	struct iovec iotlb_iov[64];
 	struct iovec *indirect;
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index c998860d7bbc..4b8656307f51 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -97,6 +97,8 @@
 #define VHOST_SET_BACKEND_FEATURES _IOW(VHOST_VIRTIO, 0x25, __u64)
 #define VHOST_GET_BACKEND_FEATURES _IOR(VHOST_VIRTIO, 0x26, __u64)
 
+#define VHOST_SET_STRONG_BARRIERS _IO(VHOST_VIRTIO, 0x27)
+
 /* VHOST_NET specific defines */
 
 /* Attach virtio net ring to a raw socket, or tap device.
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
