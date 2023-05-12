Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2F8C77B7F
	for <virtualization@archiver.kernel.org>; Fri, 12 May 2023 10:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63B6384948;
	Fri, 12 May 2023 10:47:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 63B6384948
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YzGbNeCt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id usKyGvPRNtiP; Fri, 12 May 2023 10:47:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 44AAE84942;
	Fri, 12 May 2023 10:47:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44AAE84942
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 224E5C0036;
	Fri, 12 May 2023 10:47:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31ED4C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 10:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A8C54168C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 10:47:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A8C54168C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YzGbNeCt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sd-KZ65_som7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 10:47:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 90BD840C15
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90BD840C15
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 10:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683888449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=riIz/mdmgBf7go86AOXjeLguHwLri3Q8p4giCirS1hc=;
 b=YzGbNeCtq6FyPeWGPvxpcWYn99YID/1N1Vts5wMVc11pGTcA4smXzYt58GNwT4psX4AbX+
 aVM/tyT+J1GH77z+swncR8hvFkGrWtsFoxGymEG4w6QeuwIMnE78OlEuVWJ8g4mHWDD//C
 PEvcaHb/nZjEbeJVNInyvNBxgU2a3AI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-4JazuyVGNrykYXqizeQbig-1; Fri, 12 May 2023 06:47:28 -0400
X-MC-Unique: 4JazuyVGNrykYXqizeQbig-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3063089cff4so5821226f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 03:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683888447; x=1686480447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riIz/mdmgBf7go86AOXjeLguHwLri3Q8p4giCirS1hc=;
 b=jKlr7TiLImE5rwlFA3bfNmklm5tRUAMO84LTYfQwQqhR6TZfHCjePBsC7wRZzp72hl
 Hww5M6+cGpFPXvuAo9/+tp3ljqFhR3nXyxkKhjZbwUbFkinnq4ZCJF5PcsusJPt24iIm
 UohXGoGxjn5AGNbapYDIGv1rC98A2pLS+hw5RiZ/2m7mDhxx/n9pIxd89dqzjy34/iFA
 o55hFl3+Gogp456xQuZ/ckfnMonQWwkda1ug5+CjtkaC0/jCPQR4rbg6PPB0+H9wbarU
 ErIstuiz0uaDHDNpJYws6AsZxqKCBrFCIUOv2aRY/StSpg/SZ0KKiYq9ftApTe5+iWH4
 I0dA==
X-Gm-Message-State: AC+VfDyYrsudPqZ49gnP+VTceTcQh67lAHZb2bl8pjL90/ijWadyIfY6
 unYhsmOE+UaujY3ZBYmu8+f6doziLhWKkH02BYfhiqvisj/1pl2+bwunWOTSrZPm5yR3ocKmj0u
 d0Sh5PHgjLDFQtwiAQWUp/1F/ndQUay9fCLdRzqoa6w==
X-Received: by 2002:a5d:658c:0:b0:306:4442:4c7a with SMTP id
 q12-20020a5d658c000000b0030644424c7amr16080539wru.33.1683888446950; 
 Fri, 12 May 2023 03:47:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TOwkWC4FjA/8zdmyTp7sSjjk70W8G4KNRP13UW0Djf/bttuf0wZZlrdcWBR28gPc/zM7jWA==
X-Received: by 2002:a5d:658c:0:b0:306:4442:4c7a with SMTP id
 q12-20020a5d658c000000b0030644424c7amr16080525wru.33.1683888446512; 
 Fri, 12 May 2023 03:47:26 -0700 (PDT)
Received: from redhat.com ([31.187.78.61]) by smtp.gmail.com with ESMTPSA id
 e15-20020a5d594f000000b0030771c6e443sm22873683wri.42.2023.05.12.03.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 May 2023 03:47:25 -0700 (PDT)
Date: Fri, 12 May 2023 06:47:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 2/2] tools/virtio: implement virtqueue in test
Message-ID: <20230512064628-mutt-send-email-mst@kernel.org>
References: <20230512094618.433707-1-pizhenwei@bytedance.com>
 <20230512094618.433707-3-pizhenwei@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230512094618.433707-3-pizhenwei@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Fri, May 12, 2023 at 05:46:18PM +0800, zhenwei pi wrote:
> virtqueue related functions has been removed from virtio_ring.c since
> commit("virtio: abstract virtqueue related methods"), rather than
> compiling with drivers/virtio/virtio.c, implement virtqueue functions
> here.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

Why? Costs us 400 LOC to maintain this, and will often be out of date.

> ---
>  tools/virtio/Makefile       |   4 +-
>  tools/virtio/linux/virtio.h |  30 +++
>  tools/virtio/virtqueue.c    | 367 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 399 insertions(+), 2 deletions(-)
>  create mode 100644 tools/virtio/virtqueue.c
> 
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> index 7b7139d97d74..a98d409aae7c 100644
> --- a/tools/virtio/Makefile
> +++ b/tools/virtio/Makefile
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  all: test mod
>  test: virtio_test vringh_test
> -virtio_test: virtio_ring.o virtio_test.o
> -vringh_test: vringh_test.o vringh.o virtio_ring.o
> +virtio_test: virtio_ring.o virtio_test.o virtqueue.o
> +vringh_test: vringh_test.o vringh.o virtio_ring.o virtqueue.o
>  
>  CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register
>  CFLAGS += -pthread
> diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
> index 5d3440f474dd..cb27a1105552 100644
> --- a/tools/virtio/linux/virtio.h
> +++ b/tools/virtio/linux/virtio.h
> @@ -17,6 +17,35 @@ struct virtio_device {
>  	const struct virtio_config_ops *config;
>  };
>  
> +struct virtqueue;
> +
> +/**
> + * struct virtqueue_ops - abstract operations for a virtqueue.
> + *
> + * Descriptions of each field see the comments in virtio.c
> + */
> +struct virtqueue_ops {
> +	int (*add_sgs)(struct virtqueue *vq, struct scatterlist *sgs[],
> +		       unsigned int total_sg,
> +		       unsigned int out_sgs, unsigned int in_sgs,
> +		       void *data, void *ctx, gfp_t gfp);
> +	bool (*kick_prepare)(struct virtqueue *vq);
> +	bool (*notify)(struct virtqueue *vq);
> +	unsigned int (*enable_cb_prepare)(struct virtqueue *vq);
> +	bool (*enable_cb)(struct virtqueue *vq);
> +	bool (*enable_cb_delayed)(struct virtqueue *vq);
> +	void (*disable_cb)(struct virtqueue *vq);
> +	bool (*poll)(struct virtqueue *vq, unsigned int idx);
> +	void *(*get_buf_ctx)(struct virtqueue *vq, unsigned int *len, void **ctx);
> +	void *(*detach_unused_buf)(struct virtqueue *vq);
> +	unsigned int (*get_vring_size)(const struct virtqueue *vq);
> +	int (*resize)(struct virtqueue *vq, u32 num,
> +		      void (*recycle)(struct virtqueue *vq, void *buf));
> +	void (*__break)(struct virtqueue *vq);
> +	void (*__unbreak)(struct virtqueue *vq);
> +	bool (*is_broken)(const struct virtqueue *vq);
> +};
> +
>  struct virtqueue {
>  	struct list_head list;
>  	void (*callback)(struct virtqueue *vq);
> @@ -27,6 +56,7 @@ struct virtqueue {
>  	unsigned int num_max;
>  	void *priv;
>  	bool reset;
> +	struct virtqueue_ops *ops;
>  };
>  
>  /* Interfaces exported by virtio_ring. */
> diff --git a/tools/virtio/virtqueue.c b/tools/virtio/virtqueue.c
> new file mode 100644
> index 000000000000..1f86a414f628
> --- /dev/null
> +++ b/tools/virtio/virtqueue.c
> @@ -0,0 +1,367 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/export.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_ring.h>
> +
> +/**
> + * virtqueue_add_sgs - expose buffers to other end
> + * @vq: the struct virtqueue we're talking about.
> + * @sgs: array of terminated scatterlists.
> + * @out_sgs: the number of scatterlists readable by other side
> + * @in_sgs: the number of scatterlists which are writable (after readable ones)
> + * @data: the token identifying the buffer.
> + * @gfp: how to do memory allocations (if necessary).
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + */
> +int virtqueue_add_sgs(struct virtqueue *vq, struct scatterlist *sgs[],
> +		      unsigned int out_sgs, unsigned int in_sgs,
> +		      void *data, gfp_t gfp)
> +{
> +	unsigned int i, total_sg = 0;
> +
> +	/* Count them first. */
> +	for (i = 0; i < out_sgs + in_sgs; i++) {
> +		struct scatterlist *sg;
> +
> +		for (sg = sgs[i]; sg; sg = sg_next(sg))
> +			total_sg++;
> +	}
> +	return vq->ops->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs,
> +				data, NULL, gfp);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
> +
> +/**
> + * virtqueue_add_outbuf - expose output buffers to other end
> + * @vq: the struct virtqueue we're talking about.
> + * @sg: scatterlist (must be well-formed and terminated!)
> + * @num: the number of entries in @sg readable by other side
> + * @data: the token identifying the buffer.
> + * @gfp: how to do memory allocations (if necessary).
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + */
> +int virtqueue_add_outbuf(struct virtqueue *vq, struct scatterlist *sg,
> +			 unsigned int num, void *data, gfp_t gfp)
> +{
> +	return vq->ops->add_sgs(vq, &sg, num, 1, 0, data, NULL, gfp);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
> +
> +/**
> + * virtqueue_add_inbuf - expose input buffers to other end
> + * @vq: the struct virtqueue we're talking about.
> + * @sg: scatterlist (must be well-formed and terminated!)
> + * @num: the number of entries in @sg writable by other side
> + * @data: the token identifying the buffer.
> + * @gfp: how to do memory allocations (if necessary).
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + */
> +int virtqueue_add_inbuf(struct virtqueue *vq, struct scatterlist *sg,
> +			unsigned int num, void *data, gfp_t gfp)
> +{
> +	return vq->ops->add_sgs(vq, &sg, num, 0, 1, data, NULL, gfp);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
> +
> +/**
> + * virtqueue_add_inbuf_ctx - expose input buffers to other end
> + * @vq: the struct virtqueue we're talking about.
> + * @sg: scatterlist (must be well-formed and terminated!)
> + * @num: the number of entries in @sg writable by other side
> + * @data: the token identifying the buffer.
> + * @ctx: extra context for the token
> + * @gfp: how to do memory allocations (if necessary).
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + */
> +int virtqueue_add_inbuf_ctx(struct virtqueue *vq, struct scatterlist *sg,
> +			    unsigned int num, void *data, void *ctx, gfp_t gfp)
> +{
> +	return vq->ops->add_sgs(vq, &sg, num, 0, 1, data, ctx, gfp);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
> +
> +/**
> + * virtqueue_kick_prepare - first half of split virtqueue_kick call.
> + * @vq: the struct virtqueue
> + *
> + * Instead of virtqueue_kick(), you can do:
> + *	if (virtqueue_kick_prepare(vq))
> + *		virtqueue_notify(vq);
> + *
> + * This is sometimes useful because the virtqueue_kick_prepare() needs
> + * to be serialized, but the actual virtqueue_notify() call does not.
> + */
> +bool virtqueue_kick_prepare(struct virtqueue *vq)
> +{
> +	return vq->ops->kick_prepare(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
> +
> +/**
> + * virtqueue_notify - second half of split virtqueue_kick call.
> + * @vq: the struct virtqueue
> + *
> + * This does not need to be serialized.
> + *
> + * Returns false if host notify failed or queue is broken, otherwise true.
> + */
> +bool virtqueue_notify(struct virtqueue *vq)
> +{
> +	return vq->ops->notify(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_notify);
> +
> +/**
> + * virtqueue_kick - update after add_buf
> + * @vq: the struct virtqueue
> + *
> + * After one or more virtqueue_add_* calls, invoke this to kick
> + * the other side.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + *
> + * Returns false if kick failed, otherwise true.
> + */
> +bool virtqueue_kick(struct virtqueue *vq)
> +{
> +	if (virtqueue_kick_prepare(vq))
> +		return virtqueue_notify(vq);
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_kick);
> +
> +/**
> + * virtqueue_enable_cb_prepare - restart callbacks after disable_cb
> + * @vq: the struct virtqueue we're talking about.
> + *
> + * This re-enables callbacks; it returns current queue state
> + * in an opaque unsigned value. This value should be later tested by
> + * virtqueue_poll, to detect a possible race between the driver checking for
> + * more work, and enabling callbacks.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + */
> +unsigned int virtqueue_enable_cb_prepare(struct virtqueue *vq)
> +{
> +	return vq->ops->enable_cb_prepare(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
> +
> +/**
> + * virtqueue_enable_cb - restart callbacks after disable_cb.
> + * @vq: the struct virtqueue we're talking about.
> + *
> + * This re-enables callbacks; it returns "false" if there are pending
> + * buffers in the queue, to detect a possible race between the driver
> + * checking for more work, and enabling callbacks.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + */
> +bool virtqueue_enable_cb(struct virtqueue *vq)
> +{
> +	unsigned int val = vq->ops->enable_cb_prepare(vq);
> +
> +	return !vq->ops->poll(vq, val);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_enable_cb);
> +
> +/**
> + * virtqueue_enable_cb_delayed - restart callbacks after disable_cb.
> + * @vq: the struct virtqueue we're talking about.
> + *
> + * This re-enables callbacks but hints to the other side to delay
> + * interrupts until most of the available buffers have been processed;
> + * it returns "false" if there are many pending buffers in the queue,
> + * to detect a possible race between the driver checking for more work,
> + * and enabling callbacks.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + */
> +bool virtqueue_enable_cb_delayed(struct virtqueue *vq)
> +{
> +	return vq->ops->enable_cb_delayed(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
> +
> +/**
> + * virtqueue_disable_cb - disable callbacks
> + * @vq: the struct virtqueue we're talking about.
> + *
> + * Note that this is not necessarily synchronous, hence unreliable and only
> + * useful as an optimization.
> + *
> + * Unlike other operations, this need not be serialized.
> + */
> +void virtqueue_disable_cb(struct virtqueue *vq)
> +{
> +	vq->ops->disable_cb(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
> +
> +/**
> + * virtqueue_poll - query pending used buffers
> + * @vq: the struct virtqueue we're talking about.
> + * @last_used_idx: virtqueue state (from call to virtqueue_enable_cb_prepare).
> + *
> + * Returns "true" if there are pending used buffers in the queue.
> + *
> + * This does not need to be serialized.
> + */
> +bool virtqueue_poll(struct virtqueue *vq, unsigned int idx)
> +{
> +	return vq->ops->poll(vq, idx);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_poll);
> +
> +/**
> + * virtqueue_get_buf_ctx - get the next used buffer
> + * @vq: the struct virtqueue we're talking about.
> + * @len: the length written into the buffer
> + * @ctx: extra context for the token
> + *
> + * If the device wrote data into the buffer, @len will be set to the
> + * amount written.  This means you don't need to clear the buffer
> + * beforehand to ensure there's no data leakage in the case of short
> + * writes.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + *
> + * Returns NULL if there are no used buffers, or the "data" token
> + * handed to virtqueue_add_*().
> + */
> +void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
> +			    void **ctx)
> +{
> +	return vq->ops->get_buf_ctx(vq, len, ctx);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
> +
> +void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len)
> +{
> +	return vq->ops->get_buf_ctx(vq, len, NULL);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_get_buf);
> +
> +/**
> + * virtqueue_detach_unused_buf - detach first unused buffer
> + * @vq: the struct virtqueue we're talking about.
> + *
> + * Returns NULL or the "data" token handed to virtqueue_add_*().
> + * This is not valid on an active queue; it is useful for device
> + * shutdown or the reset queue.
> + */
> +void *virtqueue_detach_unused_buf(struct virtqueue *vq)
> +{
> +	return vq->ops->detach_unused_buf(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
> +
> +/**
> + * virtqueue_get_vring_size - return the size of the virtqueue's vring
> + * @vq: the struct virtqueue containing the vring of interest.
> + *
> + * Returns the size of the vring.  This is mainly used for boasting to
> + * userspace.  Unlike other operations, this need not be serialized.
> + */
> +unsigned int virtqueue_get_vring_size(const struct virtqueue *vq)
> +{
> +	return vq->ops->get_vring_size(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
> +
> +/**
> + * virtqueue_resize - resize the vring of vq
> + * @vq: the struct virtqueue we're talking about.
> + * @num: new ring num
> + * @recycle: callback for recycle the useless buffer
> + *
> + * When it is really necessary to create a new vring, it will set the current vq
> + * into the reset state. Then call the passed callback to recycle the buffer
> + * that is no longer used. Only after the new vring is successfully created, the
> + * old vring will be released.
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error.
> + * 0: success.
> + * -ENOMEM: Failed to allocate a new ring, fall back to the original ring size.
> + *  vq can still work normally
> + * -EBUSY: Failed to sync with device, vq may not work properly
> + * -ENOENT: Transport or device not supported
> + * -E2BIG/-EINVAL: num error
> + * -EPERM: Operation not permitted
> + *
> + */
> +int virtqueue_resize(struct virtqueue *vq, u32 num,
> +		     void (*recycle)(struct virtqueue *vq, void *buf))
> +{
> +	if (vq->ops->resize)
> +		return vq->ops->resize(vq, num, recycle);
> +
> +	return -ENOENT;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_resize);
> +
> +bool virtqueue_is_broken(const struct virtqueue *vq)
> +{
> +	return vq->ops->is_broken(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_is_broken);
> +
> +/*
> + * This should prevent the device from being used, allowing drivers to
> + * recover.  You may need to grab appropriate locks to flush.
> + */
> +void virtio_break_device(struct virtio_device *dev)
> +{
> +	struct virtqueue *vq;
> +
> +	spin_lock(&dev->vqs_list_lock);
> +	list_for_each_entry(vq, &dev->vqs, list) {
> +		vq->ops->__break(vq);
> +	}
> +	spin_unlock(&dev->vqs_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(virtio_break_device);
> +
> +/*
> + * This should allow the device to be used by the driver. You may
> + * need to grab appropriate locks to flush the write to
> + * vq->broken. This should only be used in some specific case e.g
> + * (probing and restoring). This function should only be called by the
> + * core, not directly by the driver.
> + */
> +void __virtio_unbreak_device(struct virtio_device *dev)
> +{
> +	struct virtqueue *vq;
> +
> +	spin_lock(&dev->vqs_list_lock);
> +	list_for_each_entry(vq, &dev->vqs, list) {
> +		vq->ops->__unbreak(vq);
> +	}
> +	spin_unlock(&dev->vqs_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
> +
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
