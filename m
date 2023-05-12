Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7ACC77B7C
	for <virtualization@archiver.kernel.org>; Fri, 12 May 2023 09:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 034038131A;
	Fri, 12 May 2023 09:48:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 034038131A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=JQveBGpE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YqK1zidRVyO9; Fri, 12 May 2023 09:48:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D8DCD81296;
	Fri, 12 May 2023 09:48:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D8DCD81296
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F550C0037;
	Fri, 12 May 2023 09:48:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9BFFC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 09:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C425480E88
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 09:48:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C425480E88
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KJGntqH0meC0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 09:48:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8D49180E73
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D49180E73
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 09:48:29 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1adc913094aso16717025ad.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 02:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1683884909; x=1686476909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZUzACJtM8EU/zh2WKOdjX0L3EMCOkcI0u64dtrBhQNY=;
 b=JQveBGpEfgUfb9tsDNpA9HKAo/wA3Y4oFTx1rnawZL8STgWwZNKGiO9s5/ZnjjLTZW
 Ed5Od5b4+sK7DGT08uUZ4i8l5ijEujPA7pzAAtvZHYThqxg0my7MMt4dRxXM8WfGGH56
 mBMT6GlsRKg6boEhPQAjkL2FD1gAujXdpfkLcfZU7+o7LdReCiHxNanUeZGnl1M5Q3K5
 7nn8xk8sPG515Q3aGjnRTI7+OMsMCxGNjGgHp6LBinBi7rnuMAJI29vygOpBfDzbdIlx
 9o9LNzmphO3zGcBEcFmXaB1hODwu81tHAGttyDoKO+x0TgzbviQXI981pNPlmFYsO3fV
 Mtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683884909; x=1686476909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZUzACJtM8EU/zh2WKOdjX0L3EMCOkcI0u64dtrBhQNY=;
 b=MtJTIiDm2UhmxdBKiouAuEnvfdARffOL4UkQ13f0v+lxcFjo9Ph13lFynfyfz2Moxx
 yuNig2GygYblx03VKHD7mzPfA0zsFxW+uP/24rCfqS0HmuawpdoZJtGCAnjeuVKGoYC0
 0R8vfD1dOFljuu+H7AINwY76kqrxKPLXnYYhpI6tCzqmd5GhogB3j3qi1ZX0OIEdLSyd
 Z2/JFQPvGG9GhupaYn806QVAF9MlxMhjcFJTFcae5FqzRQkveFq03HAihrI6U/wQL7LJ
 51FkPjHT2CVhLBb3d4HY8F114uXIgs3CQMaljhaVQZM+oGOnntkbLKw4GSr6RcWgx+PS
 y9ag==
X-Gm-Message-State: AC+VfDzzPP5YPk5ny1OED+aJ7L25XeLNiu31+f/in3vR/uiE1mG/vM5U
 zAFZ8thNQxPjMBzEgq9UcJEYfA==
X-Google-Smtp-Source: ACHHUZ7J9VGpwJZYdn6g9RyODk/7/l4Ty9OcYqjGULGoSvQ168cLwE5V+UrY4ET05OhID1uv8u/jmg==
X-Received: by 2002:a17:902:f802:b0:1ad:dd1a:640d with SMTP id
 ix2-20020a170902f80200b001addd1a640dmr2395966plb.65.1683884908874; 
 Fri, 12 May 2023 02:48:28 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.213.176.13])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a170902821100b001a6d4ffc760sm7452956pln.244.2023.05.12.02.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 May 2023 02:48:28 -0700 (PDT)
To: stefanha@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 2/2] tools/virtio: implement virtqueue in test
Date: Fri, 12 May 2023 17:46:18 +0800
Message-Id: <20230512094618.433707-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512094618.433707-1-pizhenwei@bytedance.com>
References: <20230512094618.433707-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 zhenwei pi <pizhenwei@bytedance.com>,
 virtualization@lists.linux-foundation.org
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
From: zhenwei pi via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: zhenwei pi <pizhenwei@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

virtqueue related functions has been removed from virtio_ring.c since
commit("virtio: abstract virtqueue related methods"), rather than
compiling with drivers/virtio/virtio.c, implement virtqueue functions
here.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 tools/virtio/Makefile       |   4 +-
 tools/virtio/linux/virtio.h |  30 +++
 tools/virtio/virtqueue.c    | 367 ++++++++++++++++++++++++++++++++++++
 3 files changed, 399 insertions(+), 2 deletions(-)
 create mode 100644 tools/virtio/virtqueue.c

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 7b7139d97d74..a98d409aae7c 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 all: test mod
 test: virtio_test vringh_test
-virtio_test: virtio_ring.o virtio_test.o
-vringh_test: vringh_test.o vringh.o virtio_ring.o
+virtio_test: virtio_ring.o virtio_test.o virtqueue.o
+vringh_test: vringh_test.o vringh.o virtio_ring.o virtqueue.o
 
 CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register
 CFLAGS += -pthread
diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index 5d3440f474dd..cb27a1105552 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -17,6 +17,35 @@ struct virtio_device {
 	const struct virtio_config_ops *config;
 };
 
+struct virtqueue;
+
+/**
+ * struct virtqueue_ops - abstract operations for a virtqueue.
+ *
+ * Descriptions of each field see the comments in virtio.c
+ */
+struct virtqueue_ops {
+	int (*add_sgs)(struct virtqueue *vq, struct scatterlist *sgs[],
+		       unsigned int total_sg,
+		       unsigned int out_sgs, unsigned int in_sgs,
+		       void *data, void *ctx, gfp_t gfp);
+	bool (*kick_prepare)(struct virtqueue *vq);
+	bool (*notify)(struct virtqueue *vq);
+	unsigned int (*enable_cb_prepare)(struct virtqueue *vq);
+	bool (*enable_cb)(struct virtqueue *vq);
+	bool (*enable_cb_delayed)(struct virtqueue *vq);
+	void (*disable_cb)(struct virtqueue *vq);
+	bool (*poll)(struct virtqueue *vq, unsigned int idx);
+	void *(*get_buf_ctx)(struct virtqueue *vq, unsigned int *len, void **ctx);
+	void *(*detach_unused_buf)(struct virtqueue *vq);
+	unsigned int (*get_vring_size)(const struct virtqueue *vq);
+	int (*resize)(struct virtqueue *vq, u32 num,
+		      void (*recycle)(struct virtqueue *vq, void *buf));
+	void (*__break)(struct virtqueue *vq);
+	void (*__unbreak)(struct virtqueue *vq);
+	bool (*is_broken)(const struct virtqueue *vq);
+};
+
 struct virtqueue {
 	struct list_head list;
 	void (*callback)(struct virtqueue *vq);
@@ -27,6 +56,7 @@ struct virtqueue {
 	unsigned int num_max;
 	void *priv;
 	bool reset;
+	struct virtqueue_ops *ops;
 };
 
 /* Interfaces exported by virtio_ring. */
diff --git a/tools/virtio/virtqueue.c b/tools/virtio/virtqueue.c
new file mode 100644
index 000000000000..1f86a414f628
--- /dev/null
+++ b/tools/virtio/virtqueue.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
+#include <linux/virtio.h>
+#include <linux/virtio_ring.h>
+
+/**
+ * virtqueue_add_sgs - expose buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sgs: array of terminated scatterlists.
+ * @out_sgs: the number of scatterlists readable by other side
+ * @in_sgs: the number of scatterlists which are writable (after readable ones)
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_sgs(struct virtqueue *vq, struct scatterlist *sgs[],
+		      unsigned int out_sgs, unsigned int in_sgs,
+		      void *data, gfp_t gfp)
+{
+	unsigned int i, total_sg = 0;
+
+	/* Count them first. */
+	for (i = 0; i < out_sgs + in_sgs; i++) {
+		struct scatterlist *sg;
+
+		for (sg = sgs[i]; sg; sg = sg_next(sg))
+			total_sg++;
+	}
+	return vq->ops->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs,
+				data, NULL, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
+
+/**
+ * virtqueue_add_outbuf - expose output buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg readable by other side
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_outbuf(struct virtqueue *vq, struct scatterlist *sg,
+			 unsigned int num, void *data, gfp_t gfp)
+{
+	return vq->ops->add_sgs(vq, &sg, num, 1, 0, data, NULL, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
+
+/**
+ * virtqueue_add_inbuf - expose input buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg writable by other side
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_inbuf(struct virtqueue *vq, struct scatterlist *sg,
+			unsigned int num, void *data, gfp_t gfp)
+{
+	return vq->ops->add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
+
+/**
+ * virtqueue_add_inbuf_ctx - expose input buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg writable by other side
+ * @data: the token identifying the buffer.
+ * @ctx: extra context for the token
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_inbuf_ctx(struct virtqueue *vq, struct scatterlist *sg,
+			    unsigned int num, void *data, void *ctx, gfp_t gfp)
+{
+	return vq->ops->add_sgs(vq, &sg, num, 0, 1, data, ctx, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
+
+/**
+ * virtqueue_kick_prepare - first half of split virtqueue_kick call.
+ * @vq: the struct virtqueue
+ *
+ * Instead of virtqueue_kick(), you can do:
+ *	if (virtqueue_kick_prepare(vq))
+ *		virtqueue_notify(vq);
+ *
+ * This is sometimes useful because the virtqueue_kick_prepare() needs
+ * to be serialized, but the actual virtqueue_notify() call does not.
+ */
+bool virtqueue_kick_prepare(struct virtqueue *vq)
+{
+	return vq->ops->kick_prepare(vq);
+}
+EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
+
+/**
+ * virtqueue_notify - second half of split virtqueue_kick call.
+ * @vq: the struct virtqueue
+ *
+ * This does not need to be serialized.
+ *
+ * Returns false if host notify failed or queue is broken, otherwise true.
+ */
+bool virtqueue_notify(struct virtqueue *vq)
+{
+	return vq->ops->notify(vq);
+}
+EXPORT_SYMBOL_GPL(virtqueue_notify);
+
+/**
+ * virtqueue_kick - update after add_buf
+ * @vq: the struct virtqueue
+ *
+ * After one or more virtqueue_add_* calls, invoke this to kick
+ * the other side.
+ *
+ * Caller must ensure we don't call this with other virtqueue
+ * operations at the same time (except where noted).
+ *
+ * Returns false if kick failed, otherwise true.
+ */
+bool virtqueue_kick(struct virtqueue *vq)
+{
+	if (virtqueue_kick_prepare(vq))
+		return virtqueue_notify(vq);
+	return true;
+}
+EXPORT_SYMBOL_GPL(virtqueue_kick);
+
+/**
+ * virtqueue_enable_cb_prepare - restart callbacks after disable_cb
+ * @vq: the struct virtqueue we're talking about.
+ *
+ * This re-enables callbacks; it returns current queue state
+ * in an opaque unsigned value. This value should be later tested by
+ * virtqueue_poll, to detect a possible race between the driver checking for
+ * more work, and enabling callbacks.
+ *
+ * Caller must ensure we don't call this with other virtqueue
+ * operations at the same time (except where noted).
+ */
+unsigned int virtqueue_enable_cb_prepare(struct virtqueue *vq)
+{
+	return vq->ops->enable_cb_prepare(vq);
+}
+EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
+
+/**
+ * virtqueue_enable_cb - restart callbacks after disable_cb.
+ * @vq: the struct virtqueue we're talking about.
+ *
+ * This re-enables callbacks; it returns "false" if there are pending
+ * buffers in the queue, to detect a possible race between the driver
+ * checking for more work, and enabling callbacks.
+ *
+ * Caller must ensure we don't call this with other virtqueue
+ * operations at the same time (except where noted).
+ */
+bool virtqueue_enable_cb(struct virtqueue *vq)
+{
+	unsigned int val = vq->ops->enable_cb_prepare(vq);
+
+	return !vq->ops->poll(vq, val);
+}
+EXPORT_SYMBOL_GPL(virtqueue_enable_cb);
+
+/**
+ * virtqueue_enable_cb_delayed - restart callbacks after disable_cb.
+ * @vq: the struct virtqueue we're talking about.
+ *
+ * This re-enables callbacks but hints to the other side to delay
+ * interrupts until most of the available buffers have been processed;
+ * it returns "false" if there are many pending buffers in the queue,
+ * to detect a possible race between the driver checking for more work,
+ * and enabling callbacks.
+ *
+ * Caller must ensure we don't call this with other virtqueue
+ * operations at the same time (except where noted).
+ */
+bool virtqueue_enable_cb_delayed(struct virtqueue *vq)
+{
+	return vq->ops->enable_cb_delayed(vq);
+}
+EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
+
+/**
+ * virtqueue_disable_cb - disable callbacks
+ * @vq: the struct virtqueue we're talking about.
+ *
+ * Note that this is not necessarily synchronous, hence unreliable and only
+ * useful as an optimization.
+ *
+ * Unlike other operations, this need not be serialized.
+ */
+void virtqueue_disable_cb(struct virtqueue *vq)
+{
+	vq->ops->disable_cb(vq);
+}
+EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
+
+/**
+ * virtqueue_poll - query pending used buffers
+ * @vq: the struct virtqueue we're talking about.
+ * @last_used_idx: virtqueue state (from call to virtqueue_enable_cb_prepare).
+ *
+ * Returns "true" if there are pending used buffers in the queue.
+ *
+ * This does not need to be serialized.
+ */
+bool virtqueue_poll(struct virtqueue *vq, unsigned int idx)
+{
+	return vq->ops->poll(vq, idx);
+}
+EXPORT_SYMBOL_GPL(virtqueue_poll);
+
+/**
+ * virtqueue_get_buf_ctx - get the next used buffer
+ * @vq: the struct virtqueue we're talking about.
+ * @len: the length written into the buffer
+ * @ctx: extra context for the token
+ *
+ * If the device wrote data into the buffer, @len will be set to the
+ * amount written.  This means you don't need to clear the buffer
+ * beforehand to ensure there's no data leakage in the case of short
+ * writes.
+ *
+ * Caller must ensure we don't call this with other virtqueue
+ * operations at the same time (except where noted).
+ *
+ * Returns NULL if there are no used buffers, or the "data" token
+ * handed to virtqueue_add_*().
+ */
+void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
+			    void **ctx)
+{
+	return vq->ops->get_buf_ctx(vq, len, ctx);
+}
+EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
+
+void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len)
+{
+	return vq->ops->get_buf_ctx(vq, len, NULL);
+}
+EXPORT_SYMBOL_GPL(virtqueue_get_buf);
+
+/**
+ * virtqueue_detach_unused_buf - detach first unused buffer
+ * @vq: the struct virtqueue we're talking about.
+ *
+ * Returns NULL or the "data" token handed to virtqueue_add_*().
+ * This is not valid on an active queue; it is useful for device
+ * shutdown or the reset queue.
+ */
+void *virtqueue_detach_unused_buf(struct virtqueue *vq)
+{
+	return vq->ops->detach_unused_buf(vq);
+}
+EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
+
+/**
+ * virtqueue_get_vring_size - return the size of the virtqueue's vring
+ * @vq: the struct virtqueue containing the vring of interest.
+ *
+ * Returns the size of the vring.  This is mainly used for boasting to
+ * userspace.  Unlike other operations, this need not be serialized.
+ */
+unsigned int virtqueue_get_vring_size(const struct virtqueue *vq)
+{
+	return vq->ops->get_vring_size(vq);
+}
+EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
+
+/**
+ * virtqueue_resize - resize the vring of vq
+ * @vq: the struct virtqueue we're talking about.
+ * @num: new ring num
+ * @recycle: callback for recycle the useless buffer
+ *
+ * When it is really necessary to create a new vring, it will set the current vq
+ * into the reset state. Then call the passed callback to recycle the buffer
+ * that is no longer used. Only after the new vring is successfully created, the
+ * old vring will be released.
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error.
+ * 0: success.
+ * -ENOMEM: Failed to allocate a new ring, fall back to the original ring size.
+ *  vq can still work normally
+ * -EBUSY: Failed to sync with device, vq may not work properly
+ * -ENOENT: Transport or device not supported
+ * -E2BIG/-EINVAL: num error
+ * -EPERM: Operation not permitted
+ *
+ */
+int virtqueue_resize(struct virtqueue *vq, u32 num,
+		     void (*recycle)(struct virtqueue *vq, void *buf))
+{
+	if (vq->ops->resize)
+		return vq->ops->resize(vq, num, recycle);
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(virtqueue_resize);
+
+bool virtqueue_is_broken(const struct virtqueue *vq)
+{
+	return vq->ops->is_broken(vq);
+}
+EXPORT_SYMBOL_GPL(virtqueue_is_broken);
+
+/*
+ * This should prevent the device from being used, allowing drivers to
+ * recover.  You may need to grab appropriate locks to flush.
+ */
+void virtio_break_device(struct virtio_device *dev)
+{
+	struct virtqueue *vq;
+
+	spin_lock(&dev->vqs_list_lock);
+	list_for_each_entry(vq, &dev->vqs, list) {
+		vq->ops->__break(vq);
+	}
+	spin_unlock(&dev->vqs_list_lock);
+}
+EXPORT_SYMBOL_GPL(virtio_break_device);
+
+/*
+ * This should allow the device to be used by the driver. You may
+ * need to grab appropriate locks to flush the write to
+ * vq->broken. This should only be used in some specific case e.g
+ * (probing and restoring). This function should only be called by the
+ * core, not directly by the driver.
+ */
+void __virtio_unbreak_device(struct virtio_device *dev)
+{
+	struct virtqueue *vq;
+
+	spin_lock(&dev->vqs_list_lock);
+	list_for_each_entry(vq, &dev->vqs, list) {
+		vq->ops->__unbreak(vq);
+	}
+	spin_unlock(&dev->vqs_list_lock);
+}
+EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
+
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
