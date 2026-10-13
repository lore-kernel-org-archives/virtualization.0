Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFB43AF676
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877458; cv=none; b=rBow3LmSkrcTqNWe8tfskXoj0J2v4XaDEwjw0czr4AKjjrCq49v4I5nko9PkzpJz0qtKR3T9G/XB6OlMjJKSEVHkAA//E1O9ULeSv1q1PdDLxYxOTRigXO9MVlqmCBkJ4/iUCWjxtYFK7PLwVc7QwsjpG6Yd2OOxUtb6w5P1Bvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877458; c=relaxed/simple;
	bh=KvN/QcNS8piKOi51B3LV3O6AD3sAFyKc/lLL6Z8uFkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yjr+UU3+TST4+BHJn7PEMB9i8meu0T69GZB2Si8z4hceZGKIe8Wy2mQYdOg1GmU7sw/PZBizQex52aRboH0tUDgaJglEj8eiTiFRkACPIiCEqnNiNE76Lf2ZWJ2zMfZGiZGj4cMW4zB9r0S7jgz3XV2S61G1kcgD4wuW1BIlZ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rU8dcfyP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rU8dcfyP"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-398b3c37877so1230007a91.0
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 00:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791877452; x=1792482252; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0YTx699FPHN9wMS8sXv3SGw3lH9GDiMehKbjlJ0ij0g=;
        b=rU8dcfyPOkr0tbnuI3YqTDWyQgUhMdfAncNqYSAhj8c4Tuw8M9UckSWIdqGoOVY+2W
         rcuy0oQZJ/r5CRsT/u192NE2l24vOAlEzlwfQ9sCYFaYbNvvqODq7eeRjtBSK8y1s8pX
         veOcyC6i7ju4H5/Ok7YG5Ax5+2YhyZ3k80ZPKbfSo01XSj4JKkyo0HkhWMB3SW5fyt6a
         hoha8S8D17iJj2pfk6ITgJTsRDF8N0QXPujaR650q4jaoJxZc4dAKNyKb42066ScgXME
         b7llQiL/OqbC7L6hBQ4VoJtBIW448WYAZMhG7vO4+/2H37pBox1evc5RWqQH6a1b2/UV
         LZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791877452; x=1792482252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0YTx699FPHN9wMS8sXv3SGw3lH9GDiMehKbjlJ0ij0g=;
        b=dOzSR+c5UgnOEOtld+Ea/0SbsRR03Mp4XHtD7lmy2HEELrHqL/5ktluCTHHSeOfZ4Y
         t1wQtSlLZIpVFwl89Uj1KGF8UCwXeFse2GbfAtblcfS5BPeloiLWG7QgMzAoChk4NkUT
         UdBeUTc9ob5DfUFDhhRxYr7nmg0i5AqH2WKdGx6KA/ql0PFzxwtBQJwZ6xMg6klAdgw7
         hy64KNfcZbE1AKAKTmu3RBHX8dwW7mWT7ENoT9MimM0x4fesJlncjGh0SbNH0hYRz1bC
         t+lb0+q9b4+Sb7cFLPH3C43BQAa07aJnSotMw0QsyBEw+TfWz+7UnuPYEG/aDInOaCff
         8uvg==
X-Forwarded-Encrypted: i=1; AKwUvBwBSwPxKgIKp2XWQvNyz1Gdj74YEWO+J6wRp17c+QQAYs9htzhii9CaB5obeljEEa7xGAKNcpv5/K8gtKUOKQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJxDhQmjp0kYXcqufMZ/qb6FbjzQ8kwrL6zIdwg9Vb9l7F2k6GH
	HhICqY9wHfg4NexIGEzWLQG0Zp3MiTmcZIU0S+8I87ibKva7gNdvcx1a
X-Gm-Gg: AYBFou30NKek9tNToIN/FZY3qbXrtzCJto+R6pAPycgcRWCztv/qgbr7pQS0qnY6ExF
	/BXwdN+BuSI7ZduwF9B0e2LsTgKI9EuZLRIbSSb6zpjdkQ9/5xjoxwOZkd1MbLSc66eEn6a9yiQ
	ATjpEu8t+Kq+4I5MoeiJENYrS0WVowhAwEwmUTd0bMOtkkhmmkGsmezWWG/aFb4jGAonTG7J571
	lu5CcVW2nOwTB2pmoStuw5mi/1itM3TFJOrGF6CSYeIEWdFKhfJ/S6K4tvs28U0aZ10G4XrvOsS
	P0j/9Ixa0vzwNbA3tVDNf79jDhDn6sO8rqEDLvxiRSTkLCaIjwutg7t86w+B4DrQoIi6wcSdIlM
	7funKRTRIkTrnSmeLWpie0OwPpKD/67YEJO144iYJSEyugHIQGbqPf+WibR9EEIQCR6Hx0E37M7
	/s3XvmyG7jF+A8xjgFIvaEpTT1F57OeZRPAkuhF3pogX8xfLT2xj+Oc8A1/ECn+1/8mL7QAlGa8
	/W6mK8/V8XoFp+Y4mdDokZZ1yua/nf8sKtVZb2BKyKyEwQRzwv3DflxPs0eVY3gfvUZxjdufqvi
	S5HCbBhAcbkNFsGvwtLAmAQe+P0=
X-Received: by 2002:a17:90b:1b0d:b0:3ac:4e18:237c with SMTP id 98e67ed59e1d1-3ac4e182f22mr75362a91.0.1791877452217;
        Tue, 13 Oct 2026 00:44:12 -0700 (PDT)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm20552825a91.4.2026.10.13.00.44.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Oct 2026 00:44:11 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: Takashi Iwai <tiwai@suse.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Subject: [PATCH v2 5/5] ALSA: virtio: Keep control payloads alive through DMA completion
Date: Tue, 13 Oct 2026 16:43:50 +0900
Message-ID: <9fef5c610028744b71ef243edbcd5a020f14180d.1791877396.git.mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791877396.git.mynameisjune111@gmail.com>
References: <cover.1791877396.git.mynameisjune111@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Control requests can expose caller-owned payloads to the device after a
synchronous send times out. Allocate request and response headers and
payloads with the reference-counted message, and place each scatterlist
region on separate DMA cacheline boundaries.

Keep the queue reference until device completion or post-reset cleanup,
even when the caller times out or is interrupted. Consume the caller's
reference on every send path, and let response readers retain an extra
reference through copyout. Check payload sizes and allocation arithmetic
before building the scatterlists.

Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>
---
Changes in v2:
- Separate CPU metadata from DMA storage and align each DMA region
  using dma_get_cache_alignment(), with overflow-checked sizing.

 sound/virtio/virtio_ctl_msg.c | 273 ++++++++++++++++++++++++++--------
 sound/virtio/virtio_ctl_msg.h |  24 ++-
 sound/virtio/virtio_kctl.c    | 104 +++++++------
 sound/virtio/virtio_pcm_msg.c |   2 +-
 4 files changed, 283 insertions(+), 120 deletions(-)

diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
index 7114bea4033a..84e2fb2562e4 100644
--- a/sound/virtio/virtio_ctl_msg.c
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -3,7 +3,10 @@
  * virtio-snd: Virtio sound device
  * Copyright (C) 2021 OpenSynergy GmbH
  */
+#include <linux/dma-mapping.h>
+#include <linux/limits.h>
 #include <linux/moduleparam.h>
+#include <linux/overflow.h>
 #include <linux/virtio_config.h>
 
 #include "virtio_card.h"
@@ -11,7 +14,12 @@
 /**
  * struct virtio_snd_msg - Control message.
  * @sg_request: Scattergather list containing a device request (header).
+ * @sg_request_data: Scattergather list containing request data.
  * @sg_response: Scattergather list containing a device response (status).
+ * @sg_response_data: Scattergather list containing response data.
+ * @dma_buffer: Message-owned storage for all DMA-visible SG regions.
+ * @request_data_size: Size of the request data buffer.
+ * @response_data_size: Size of the response data buffer.
  * @list: Pending message list entry.
  * @notify: Request completed notification.
  * @ref_count: Reference count used to manage a message lifetime.
@@ -19,7 +27,12 @@
  */
 struct virtio_snd_msg {
 	struct scatterlist sg_request;
+	struct scatterlist sg_request_data;
 	struct scatterlist sg_response;
+	struct scatterlist sg_response_data;
+	void *dma_buffer;
+	size_t request_data_size;
+	size_t response_data_size;
 	struct list_head list;
 	struct completion notify;
 	refcount_t ref_count;
@@ -47,8 +60,10 @@ void virtsnd_ctl_msg_ref(struct virtio_snd_msg *msg)
  */
 void virtsnd_ctl_msg_unref(struct virtio_snd_msg *msg)
 {
-	if (refcount_dec_and_test(&msg->ref_count))
+	if (refcount_dec_and_test(&msg->ref_count)) {
+		kfree(msg->dma_buffer);
 		kfree(msg);
+	}
 }
 
 /**
@@ -73,10 +88,71 @@ void *virtsnd_ctl_msg_response(struct virtio_snd_msg *msg)
 	return sg_virt(&msg->sg_response);
 }
 
+/**
+ * virtsnd_ctl_msg_request_data() - Get the request data buffer.
+ * @msg: Control message.
+ *
+ * Context: Any context.
+ */
+void *virtsnd_ctl_msg_request_data(struct virtio_snd_msg *msg)
+{
+	return msg->request_data_size ? sg_virt(&msg->sg_request_data) : NULL;
+}
+
+/**
+ * virtsnd_ctl_msg_response_data() - Get the response data buffer.
+ * @msg: Control message.
+ *
+ * Context: Any context.
+ */
+void *virtsnd_ctl_msg_response_data(struct virtio_snd_msg *msg)
+{
+	return msg->response_data_size ? sg_virt(&msg->sg_response_data) : NULL;
+}
+
+/**
+ * virtsnd_ctl_msg_sg_init() - Place one DMA region on cacheline boundaries.
+ * @sg: Scattergather entry for the region.
+ * @cursor: Current location in the message-owned DMA buffer.
+ * @size: Region length.
+ * @alignment: DMA cacheline alignment.
+ *
+ * Context: Any context during message allocation.
+ * Return: 0 on success, -EOVERFLOW if the address cannot be represented.
+ */
+static int virtsnd_ctl_msg_sg_init(struct scatterlist *sg, u8 **cursor,
+				   size_t size, size_t alignment)
+{
+	uintptr_t address = (uintptr_t)*cursor;
+	uintptr_t end;
+	size_t padding;
+
+	padding = address % alignment;
+	if (padding &&
+	    check_add_overflow(address, (uintptr_t)(alignment - padding),
+			       &address))
+		return -EOVERFLOW;
+
+	if (check_add_overflow(address, (uintptr_t)size, &end))
+		return -EOVERFLOW;
+
+	padding = end % alignment;
+	if (padding &&
+	    check_add_overflow(end, (uintptr_t)(alignment - padding), &end))
+		return -EOVERFLOW;
+
+	sg_init_one(sg, (void *)address, (unsigned int)size);
+	*cursor = (u8 *)end;
+
+	return 0;
+}
+
 /**
  * virtsnd_ctl_msg_alloc() - Allocate and initialize a control message.
  * @request_size: Size of request header.
  * @response_size: Size of response header.
+ * @request_data_size: Size of request data buffer.
+ * @response_data_size: Size of response data buffer.
  * @gfp: Kernel flags for memory allocation.
  *
  * The message will be automatically freed when the ref_count value is 0.
@@ -85,20 +161,83 @@ void *virtsnd_ctl_msg_response(struct virtio_snd_msg *msg)
  * Return: Allocated message on success, NULL on failure.
  */
 struct virtio_snd_msg *virtsnd_ctl_msg_alloc(size_t request_size,
-					     size_t response_size, gfp_t gfp)
+					     size_t response_size,
+					     size_t request_data_size,
+					     size_t response_data_size,
+					     gfp_t gfp)
 {
 	struct virtio_snd_msg *msg;
+	struct scatterlist *sgs[4];
+	size_t sizes[4] = {
+		request_size,
+		response_size,
+		request_data_size,
+		response_data_size,
+	};
+	size_t alignment;
+	size_t dma_buffer_size;
+	size_t aligned_size;
+	size_t padding;
+	u8 *data;
+	unsigned int i;
+	int cache_alignment;
+	int rc;
 
-	if (!request_size || !response_size)
+	if (!request_size || !response_size || request_size > UINT_MAX ||
+	    response_size > UINT_MAX || request_data_size > UINT_MAX ||
+	    response_data_size > UINT_MAX)
 		return NULL;
+	cache_alignment = dma_get_cache_alignment();
+	if (cache_alignment <= 0)
+		return NULL;
+	alignment = cache_alignment;
+
+	/* Reserve prefix alignment slack before the first DMA region. */
+	dma_buffer_size = alignment;
+	for (i = 0; i < ARRAY_SIZE(sizes); ++i) {
+		if (!sizes[i])
+			continue;
+
+		padding = sizes[i] % alignment;
+		aligned_size = sizes[i];
+		if (padding &&
+		    check_add_overflow(aligned_size, alignment - padding,
+				       &aligned_size))
+			return NULL;
+
+		if (check_add_overflow(dma_buffer_size, aligned_size,
+				       &dma_buffer_size))
+			return NULL;
+	}
 
-	msg = kzalloc(sizeof(*msg) + request_size + response_size, gfp);
+	msg = kzalloc(sizeof(*msg), gfp);
 	if (!msg)
 		return NULL;
 
-	sg_init_one(&msg->sg_request, (u8 *)msg + sizeof(*msg), request_size);
-	sg_init_one(&msg->sg_response, (u8 *)msg + sizeof(*msg) + request_size,
-		    response_size);
+	msg->dma_buffer = kzalloc(dma_buffer_size, gfp);
+	if (!msg->dma_buffer) {
+		kfree(msg);
+		return NULL;
+	}
+	data = (u8 *)msg->dma_buffer + 1;
+	sgs[0] = &msg->sg_request;
+	sgs[1] = &msg->sg_response;
+	sgs[2] = &msg->sg_request_data;
+	sgs[3] = &msg->sg_response_data;
+	for (i = 0; i < ARRAY_SIZE(sizes); ++i) {
+		if (!sizes[i])
+			continue;
+
+		rc = virtsnd_ctl_msg_sg_init(sgs[i], &data, sizes[i], alignment);
+		if (rc) {
+			kfree(msg->dma_buffer);
+			kfree(msg);
+			return NULL;
+		}
+	}
+
+	msg->request_data_size = request_data_size;
+	msg->response_data_size = response_data_size;
 
 	INIT_LIST_HEAD(&msg->list);
 	init_completion(&msg->notify);
@@ -112,17 +251,15 @@ struct virtio_snd_msg *virtsnd_ctl_msg_alloc(size_t request_size,
  * virtsnd_ctl_msg_send() - Send a control message.
  * @snd: VirtIO sound device.
  * @msg: Control message.
- * @out_sgs: Additional sg-list to attach to the request header (may be NULL).
- * @in_sgs: Additional sg-list to attach to the response header (may be NULL).
  * @nowait: Flag indicating whether to wait for completion.
  *
  * Context: Any context. Takes and releases the control queue spinlock.
  *          May sleep if @nowait is false.
+ *          Consumes the caller's reference on every return path.
  * Return: 0 on success, -errno on failure.
  */
 int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
-			 struct scatterlist *out_sgs,
-			 struct scatterlist *in_sgs, bool nowait)
+			 bool nowait)
 {
 	struct virtio_device *vdev = snd->vdev;
 	struct virtio_snd_queue *queue = virtsnd_control_queue(snd);
@@ -133,6 +270,7 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 	unsigned int nins = 0;
 	struct scatterlist *psgs[4];
 	bool notify = false;
+	unsigned long flags;
 	int rc;
 
 	virtsnd_ctl_msg_ref(msg);
@@ -142,27 +280,27 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 	response->code = cpu_to_le32(VIRTIO_SND_S_IO_ERR);
 
 	psgs[nouts++] = &msg->sg_request;
-	if (out_sgs)
-		psgs[nouts++] = out_sgs;
+	if (msg->request_data_size)
+		psgs[nouts++] = &msg->sg_request_data;
 
 	psgs[nouts + nins++] = &msg->sg_response;
-	if (in_sgs)
-		psgs[nouts + nins++] = in_sgs;
-
-	scoped_guard(spinlock_irqsave, &queue->lock) {
-		if (snd->ctl_msgs_blocked)
-			rc = -ENODEV;
-		else
-			rc = virtqueue_add_sgs(queue->vqueue, psgs, nouts, nins,
-					       msg, GFP_ATOMIC);
-		if (!rc) {
-			notify = virtqueue_kick_prepare(queue->vqueue);
+	if (msg->response_data_size)
+		psgs[nouts + nins++] = &msg->sg_response_data;
 
-			list_add_tail(&msg->list, &snd->ctl_msgs);
-			if (notify)
-				virtqueue_notify(queue->vqueue);
-		}
+	spin_lock_irqsave(&queue->lock, flags);
+	if (snd->ctl_msgs_blocked)
+		rc = -ENODEV;
+	else
+		rc = virtqueue_add_sgs(queue->vqueue, psgs, nouts, nins, msg,
+				       GFP_ATOMIC);
+	if (!rc) {
+		notify = virtqueue_kick_prepare(queue->vqueue);
+
+		list_add_tail(&msg->list, &snd->ctl_msgs);
+		if (notify)
+			virtqueue_notify(queue->vqueue);
 	}
+	spin_unlock_irqrestore(&queue->lock, flags);
 
 	if (rc) {
 		dev_err(&vdev->dev, "failed to send control message (0x%08x)\n",
@@ -173,46 +311,36 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 		 * called, it is necessary to decrement the reference count.
 		 */
 		virtsnd_ctl_msg_unref(msg);
-
-		goto on_exit;
-	}
-
-	if (nowait)
-		goto on_exit;
-
-	rc = wait_for_completion_interruptible_timeout(&msg->notify, js);
-	if (rc <= 0) {
+	} else if (!nowait) {
+		rc = wait_for_completion_interruptible_timeout(&msg->notify, js);
 		if (!rc) {
 			dev_err(&vdev->dev,
 				"control message (0x%08x) timeout\n",
 				le32_to_cpu(request->code));
 			rc = -ETIMEDOUT;
+		} else if (rc > 0) {
+			if (READ_ONCE(msg->cancelled)) {
+				rc = -ENODEV;
+			} else {
+				switch (le32_to_cpu(response->code)) {
+				case VIRTIO_SND_S_OK:
+					rc = 0;
+					break;
+				case VIRTIO_SND_S_NOT_SUPP:
+					rc = -EOPNOTSUPP;
+					break;
+				case VIRTIO_SND_S_IO_ERR:
+					rc = -EIO;
+					break;
+				default:
+					rc = -EINVAL;
+					break;
+				}
+			}
 		}
-
-		goto on_exit;
-	}
-
-	if (READ_ONCE(msg->cancelled)) {
-		rc = -ENODEV;
-		goto on_exit;
-	}
-
-	switch (le32_to_cpu(response->code)) {
-	case VIRTIO_SND_S_OK:
-		rc = 0;
-		break;
-	case VIRTIO_SND_S_NOT_SUPP:
-		rc = -EOPNOTSUPP;
-		break;
-	case VIRTIO_SND_S_IO_ERR:
-		rc = -EIO;
-		break;
-	default:
-		rc = -EINVAL;
-		break;
 	}
 
-on_exit:
+	/* Drop the reference consumed by this send attempt. */
 	virtsnd_ctl_msg_unref(msg);
 
 	return rc;
@@ -308,10 +436,23 @@ int virtsnd_ctl_query_info(struct virtio_snd *snd, int command, int start_id,
 {
 	struct virtio_snd_msg *msg;
 	struct virtio_snd_query_info *query;
-	struct scatterlist sg;
+	size_t info_size;
+	int rc;
+
+	if (count < 0)
+		return -EINVAL;
+
+	if (size > UINT_MAX ||
+	    check_mul_overflow((size_t)count, size, &info_size) ||
+	    info_size > UINT_MAX)
+		return -EOVERFLOW;
+
+	if (info_size && !info)
+		return -EINVAL;
 
 	msg = virtsnd_ctl_msg_alloc(sizeof(*query),
-				    sizeof(struct virtio_snd_hdr), GFP_KERNEL);
+				    sizeof(struct virtio_snd_hdr), 0, info_size,
+				    GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
@@ -321,9 +462,13 @@ int virtsnd_ctl_query_info(struct virtio_snd *snd, int command, int start_id,
 	query->count = cpu_to_le32(count);
 	query->size = cpu_to_le32(size);
 
-	sg_init_one(&sg, info, count * size);
+	virtsnd_ctl_msg_ref(msg);
+	rc = virtsnd_ctl_msg_send(snd, msg, false);
+	if (!rc && info_size)
+		memcpy(info, virtsnd_ctl_msg_response_data(msg), info_size);
+	virtsnd_ctl_msg_unref(msg);
 
-	return virtsnd_ctl_msg_send(snd, msg, NULL, &sg, false);
+	return rc;
 }
 
 /**
diff --git a/sound/virtio/virtio_ctl_msg.h b/sound/virtio/virtio_ctl_msg.h
index d917435409d0..f867b9b9233d 100644
--- a/sound/virtio/virtio_ctl_msg.h
+++ b/sound/virtio/virtio_ctl_msg.h
@@ -21,20 +21,28 @@ void *virtsnd_ctl_msg_request(struct virtio_snd_msg *msg);
 void *virtsnd_ctl_msg_response(struct virtio_snd_msg *msg);
 
 struct virtio_snd_msg *virtsnd_ctl_msg_alloc(size_t request_size,
-					     size_t response_size, gfp_t gfp);
+					     size_t response_size,
+					     size_t request_data_size,
+					     size_t response_data_size,
+					     gfp_t gfp);
+
+void *virtsnd_ctl_msg_request_data(struct virtio_snd_msg *msg);
+
+void *virtsnd_ctl_msg_response_data(struct virtio_snd_msg *msg);
 
 int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
-			 struct scatterlist *out_sgs,
-			 struct scatterlist *in_sgs, bool nowait);
+			 bool nowait);
 
 /**
  * virtsnd_ctl_msg_send_sync() - Simplified sending of synchronous message.
  * @snd: VirtIO sound device.
  * @msg: Control message.
  *
- * After returning from this function, the message will be deleted. If message
- * content is still needed, the caller must additionally to
- * virtsnd_ctl_msg_ref/unref() it.
+ * This function consumes the caller's message reference on return. A message
+ * accepted by the control queue keeps its queue reference until completion or
+ * post-reset cleanup, including when this function returns on timeout or
+ * interruption. Callers that read the response after success must retain an
+ * additional reference through that access.
  *
  * The msg_timeout_ms module parameter defines the message completion timeout.
  * If the message is not completed within this time, the function will return an
@@ -49,7 +57,7 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg,
 static inline int virtsnd_ctl_msg_send_sync(struct virtio_snd *snd,
 					    struct virtio_snd_msg *msg)
 {
-	return virtsnd_ctl_msg_send(snd, msg, NULL, NULL, false);
+	return virtsnd_ctl_msg_send(snd, msg, false);
 }
 
 /**
@@ -63,7 +71,7 @@ static inline int virtsnd_ctl_msg_send_sync(struct virtio_snd *snd,
 static inline int virtsnd_ctl_msg_send_async(struct virtio_snd *snd,
 					     struct virtio_snd_msg *msg)
 {
-	return virtsnd_ctl_msg_send(snd, msg, NULL, NULL, true);
+	return virtsnd_ctl_msg_send(snd, msg, true);
 }
 
 void virtsnd_ctl_msg_cancel_all(struct virtio_snd *snd);
diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
index 45f7b6a5b308..4cf75dedbe9a 100644
--- a/sound/virtio/virtio_kctl.c
+++ b/sound/virtio/virtio_kctl.c
@@ -3,8 +3,10 @@
  * virtio-snd: Virtio sound device
  * Copyright (C) 2022 OpenSynergy GmbH
  */
-#include <sound/control.h>
+#include <linux/limits.h>
+#include <linux/overflow.h>
 #include <linux/virtio_config.h>
+#include <sound/control.h>
 
 #include "virtio_card.h"
 
@@ -161,10 +163,12 @@ static int virtsnd_kctl_get(struct snd_kcontrol *kcontrol,
 	unsigned int i;
 	int rc;
 
-	msg = virtsnd_ctl_msg_alloc(request_size, response_size, GFP_KERNEL);
+	msg = virtsnd_ctl_msg_alloc(request_size, response_size, 0, 0,
+				    GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
+	/* Response lifetime through ALSA value copyout. */
 	virtsnd_ctl_msg_ref(msg);
 
 	hdr = virtsnd_ctl_msg_request(msg);
@@ -233,7 +237,8 @@ static int virtsnd_kctl_put(struct snd_kcontrol *kcontrol,
 	size_t response_size = sizeof(struct virtio_snd_hdr);
 	unsigned int i;
 
-	msg = virtsnd_ctl_msg_alloc(request_size, response_size, GFP_KERNEL);
+	msg = virtsnd_ctl_msg_alloc(request_size, response_size, 0, 0,
+				    GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
@@ -288,23 +293,28 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
 	struct virtio_snd *snd = snd_kcontrol_chip(kcontrol);
 	struct virtio_snd_msg *msg;
 	struct virtio_snd_ctl_hdr *hdr;
-	unsigned int *tlv;
-	struct scatterlist sg;
+	size_t request_data_size = 0;
+	size_t response_data_size = 0;
 	int rc;
 
+	switch (op_flag) {
+	case SNDRV_CTL_TLV_OP_READ:
+		response_data_size = size;
+		break;
+	case SNDRV_CTL_TLV_OP_WRITE:
+	case SNDRV_CTL_TLV_OP_CMD:
+		request_data_size = size;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	msg = virtsnd_ctl_msg_alloc(sizeof(*hdr), sizeof(struct virtio_snd_hdr),
+				    request_data_size, response_data_size,
 				    GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
-	tlv = kzalloc(size, GFP_KERNEL);
-	if (!tlv) {
-		rc = -ENOMEM;
-		goto on_msg_unref;
-	}
-
-	sg_init_one(&sg, tlv, size);
-
 	hdr = virtsnd_ctl_msg_request(msg);
 	hdr->control_id = cpu_to_le32(kcontrol->private_value);
 
@@ -312,13 +322,16 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
 	case SNDRV_CTL_TLV_OP_READ:
 		hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_TLV_READ);
 
-		rc = virtsnd_ctl_msg_send(snd, msg, NULL, &sg, false);
-		if (!rc) {
-			if (copy_to_user(utlv, tlv, size))
-				rc = -EFAULT;
-		}
+		/* Response lifetime through user copyout. */
+		virtsnd_ctl_msg_ref(msg);
+		rc = virtsnd_ctl_msg_send(snd, msg, false);
+		if (!rc && size &&
+		    copy_to_user(utlv, virtsnd_ctl_msg_response_data(msg),
+				 size))
+			rc = -EFAULT;
+		virtsnd_ctl_msg_unref(msg);
 
-		break;
+		return rc;
 	case SNDRV_CTL_TLV_OP_WRITE:
 	case SNDRV_CTL_TLV_OP_CMD:
 		if (op_flag == SNDRV_CTL_TLV_OP_WRITE)
@@ -327,28 +340,16 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
 			hdr->hdr.code =
 				cpu_to_le32(VIRTIO_SND_R_CTL_TLV_COMMAND);
 
-		if (copy_from_user(tlv, utlv, size)) {
-			rc = -EFAULT;
-			goto on_msg_unref;
-		} else {
-			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
+		if (size && copy_from_user(virtsnd_ctl_msg_request_data(msg), utlv,
+					   size)) {
+			virtsnd_ctl_msg_unref(msg);
+			return -EFAULT;
 		}
 
-		break;
-	default:
-		rc = -EINVAL;
-		/* We never get here - we listed all values for op_flag */
-		WARN_ON(1);
-		goto on_msg_unref;
+		return virtsnd_ctl_msg_send(snd, msg, false);
 	}
-	kfree(tlv);
-	return rc;
-
-on_msg_unref:
-	virtsnd_ctl_msg_unref(msg);
-	kfree(tlv);
 
-	return rc;
+	return -EINVAL;
 }
 
 /**
@@ -369,27 +370,36 @@ static int virtsnd_kctl_get_enum_items(struct virtio_snd *snd, unsigned int cid)
 	struct virtio_snd_msg *msg;
 	struct virtio_snd_ctl_hdr *hdr;
 	unsigned int n = le32_to_cpu(kinfo->value.enumerated.items);
-	struct scatterlist sg;
+	size_t items_size;
+	int rc;
 
-	msg = virtsnd_ctl_msg_alloc(sizeof(*hdr),
-				    sizeof(struct virtio_snd_hdr), GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
+	if (check_mul_overflow((size_t)n, sizeof(*kctl->items), &items_size) ||
+	    items_size > UINT_MAX)
+		return -EOVERFLOW;
 
 	kctl->items = devm_kcalloc(&vdev->dev, n, sizeof(*kctl->items),
 				   GFP_KERNEL);
-	if (!kctl->items) {
-		virtsnd_ctl_msg_unref(msg);
+	if (!kctl->items)
 		return -ENOMEM;
-	}
 
-	sg_init_one(&sg, kctl->items, n * sizeof(*kctl->items));
+	msg = virtsnd_ctl_msg_alloc(sizeof(*hdr),
+				    sizeof(struct virtio_snd_hdr), 0, items_size,
+				    GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
 
 	hdr = virtsnd_ctl_msg_request(msg);
 	hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_ENUM_ITEMS);
 	hdr->control_id = cpu_to_le32(cid);
 
-	return virtsnd_ctl_msg_send(snd, msg, NULL, &sg, false);
+	/* Item-buffer lifetime through the control-list copyout. */
+	virtsnd_ctl_msg_ref(msg);
+	rc = virtsnd_ctl_msg_send(snd, msg, false);
+	if (!rc && items_size)
+		memcpy(kctl->items, virtsnd_ctl_msg_response_data(msg), items_size);
+	virtsnd_ctl_msg_unref(msg);
+
+	return rc;
 }
 
 /**
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
index b7f2334bb221..b54642a9521d 100644
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -671,7 +671,7 @@ virtsnd_pcm_ctl_msg_alloc(struct virtio_pcm_substream *vss,
 		break;
 	}
 
-	msg = virtsnd_ctl_msg_alloc(request_size, response_size, gfp);
+	msg = virtsnd_ctl_msg_alloc(request_size, response_size, 0, 0, gfp);
 	if (msg) {
 		struct virtio_snd_pcm_hdr *hdr = virtsnd_ctl_msg_request(msg);
 
-- 
2.54.0 (Apple Git-157)

