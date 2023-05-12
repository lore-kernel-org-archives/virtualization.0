Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EEEC77B75
	for <virtualization@archiver.kernel.org>; Fri, 12 May 2023 11:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 982DF429C3;
	Fri, 12 May 2023 11:35:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 982DF429C3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ouwuj4dP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2DiyZ295yXkY; Fri, 12 May 2023 11:35:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E288842990;
	Fri, 12 May 2023 11:35:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E288842990
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B98A4C0037;
	Fri, 12 May 2023 11:35:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6593C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 11:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E58D4029F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 11:35:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E58D4029F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ouwuj4dP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CVQdfasPFLWM
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 11:35:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38302401A4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38302401A4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 11:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683891346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j18moFQtAZJOXAEp0m2FgLJK8fZ33JwPBzg3lwc/CJE=;
 b=Ouwuj4dPVJAoYUJKgpvi9LFxKZuBwB9XihV7MTkUhqoe3vGfolKU9VKAVIQC+5PS2wEanx
 MhHHqZ5XHmNnN+S+DK69CacfW1R68VepzSaWzbkL3CDGdt+wK3BNlL5soaP2trFi56qxPB
 WwEGOpgEtT458FlhR6rBOUCoAG7/qVc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-m7kWfTToOGqDlBmt20zayg-1; Fri, 12 May 2023 07:35:43 -0400
X-MC-Unique: m7kWfTToOGqDlBmt20zayg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso17999705e9.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 04:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683891342; x=1686483342;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j18moFQtAZJOXAEp0m2FgLJK8fZ33JwPBzg3lwc/CJE=;
 b=ci4tNm7TS2lWEwpMISFg237bJHgdrE7rsq5Gfzw+SuDc8Mq3ctBefpjMGrN/UHTXRa
 Lz2ah0vvHZRzTO44asJfg/kV/K/nX+dceO8jhrQPoJk/zOTLnUQXcrMojnvEVcYj7Z8e
 ia9kiN1JfWusQgcgq514qAa1xBwoZdJA4FqkLCw2ltMtbEqggDsEo4zYyfYpRdHL9FwE
 kCY4HRvlvU1do7wtFj8R22nwQM5aBnalTVSxRb7s+XTQQyoRdyJSKYJuyb/iDue3vwSu
 k84OXG6X6auVb79gtFYnhcGpkJTuKhOAIN/77aOyVi5EbDH3Kjc+pZbYryYLSsSwKhrX
 MfAA==
X-Gm-Message-State: AC+VfDx5ym/ch0jGl34nVBh64Lxe4adUMW0xoIvRYdumse3rKFNwsIXV
 nYLUvNsEJBOppOUaYu+0fcqd+SlEWPyt3nM8tfeMxlByIRc2yQt1XmgCUCH9x5/or3JA0uEzF3f
 ktKx+CVzSVFn86DWZLndav8u207MRFWR7DqSUiEVOsg==
X-Received: by 2002:a05:600c:2049:b0:3f4:1a97:ab09 with SMTP id
 p9-20020a05600c204900b003f41a97ab09mr13430046wmg.25.1683891342404; 
 Fri, 12 May 2023 04:35:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6YB4LXWmzvSc+5lRdqj+LiZFKU35Efug5kWk4jSDBQmNqs3qd3YKp0Pv/Uo3j0j/ZndKbByw==
X-Received: by 2002:a05:600c:2049:b0:3f4:1a97:ab09 with SMTP id
 p9-20020a05600c204900b003f41a97ab09mr13430031wmg.25.1683891342071; 
 Fri, 12 May 2023 04:35:42 -0700 (PDT)
Received: from redhat.com ([31.187.78.61]) by smtp.gmail.com with ESMTPSA id
 j15-20020a05600c1c0f00b003f1738d0d13sm15639639wms.1.2023.05.12.04.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 May 2023 04:35:41 -0700 (PDT)
Date: Fri, 12 May 2023 07:35:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: Re: [PATCH 1/2] virtio: abstract virtqueue related methods
Message-ID: <20230512072819-mutt-send-email-mst@kernel.org>
References: <20230512094618.433707-1-pizhenwei@bytedance.com>
 <20230512094618.433707-2-pizhenwei@bytedance.com>
 <20230512064305-mutt-send-email-mst@kernel.org>
 <37a5e7dc-160d-51d2-7631-196ad9e21da7@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <37a5e7dc-160d-51d2-7631-196ad9e21da7@bytedance.com>
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

On Fri, May 12, 2023 at 07:09:40PM +0800, zhenwei pi wrote:
> On 5/12/23 18:46, Michael S. Tsirkin wrote:
> > On Fri, May 12, 2023 at 05:46:17PM +0800, zhenwei pi wrote:
> > > There is already a virtqueue abstract structure in virtio subsystem
> > > (see struct virtqueue in include/linux/virtio.h), however the vring
> > > based virtqueue is used only in the past years, the virtqueue related
> > > methods mix much with vring(just look like the codes, virtqueue_xxx
> > > functions are implemented in virtio_ring.c).
> > > 
> > > Abstract virtqueue related methods(see struct virtqueue_ops), and
> > > separate virtqueue_xxx symbols from vring. This allows a non-vring
> > > based transport in the future. With this change, the following symbols
> > > are exported from virtio.ko instead of virtio_ring.ko:
> > >    virtqueue_add_sgs
> > >    virtqueue_add_outbuf
> > >    virtqueue_add_inbuf
> > >    virtqueue_add_inbuf_ctx
> > >    virtqueue_kick_prepare
> > >    virtqueue_notify
> > >    virtqueue_kick
> > >    virtqueue_enable_cb_prepare
> > >    virtqueue_enable_cb
> > >    virtqueue_enable_cb_delayed
> > >    virtqueue_disable_cb
> > >    virtqueue_poll
> > >    virtqueue_get_buf_ctx
> > >    virtqueue_get_buf
> > >    virtqueue_detach_unused_buf
> > >    virtqueue_get_vring_size
> > >    virtqueue_resize
> > >    virtqueue_is_broken
> > >    virtio_break_device
> > >    __virtio_unbreak_device
> > > 
> > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> > > ---
> > >   drivers/virtio/virtio.c      | 362 +++++++++++++++++++++++++++++++++++
> > >   drivers/virtio/virtio_ring.c | 282 +++++----------------------
> > >   include/linux/virtio.h       |  29 +++
> > >   3 files changed, 443 insertions(+), 230 deletions(-)
> > > 
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index 3893dc29eb26..8d8715a10f26 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -553,6 +553,368 @@ int virtio_device_restore(struct virtio_device *dev)
> > >   EXPORT_SYMBOL_GPL(virtio_device_restore);
> > >   #endif
> > > +/**
> > > + * virtqueue_add_sgs - expose buffers to other end
> > > + * @vq: the struct virtqueue we're talking about.
> > > + * @sgs: array of terminated scatterlists.
> > > + * @out_sgs: the number of scatterlists readable by other side
> > > + * @in_sgs: the number of scatterlists which are writable (after readable ones)
> > > + * @data: the token identifying the buffer.
> > > + * @gfp: how to do memory allocations (if necessary).
> > > + *
> > > + * Caller must ensure we don't call this with other virtqueue operations
> > > + * at the same time (except where noted).
> > > + *
> > > + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> > > + */
> > > +int virtqueue_add_sgs(struct virtqueue *vq, struct scatterlist *sgs[],
> > > +		      unsigned int out_sgs, unsigned int in_sgs,
> > > +		      void *data, gfp_t gfp)
> > > +{
> > > +	unsigned int i, total_sg = 0;
> > > +
> > > +	/* Count them first. */
> > > +	for (i = 0; i < out_sgs + in_sgs; i++) {
> > > +		struct scatterlist *sg;
> > > +
> > > +		for (sg = sgs[i]; sg; sg = sg_next(sg))
> > > +			total_sg++;
> > > +	}
> > > +	return vq->ops->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs,
> > > +				data, NULL, gfp);
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
> > 
> > 
> > Hmm this kind of indirection on data path is going to be costly
> > performance-wise especially when retpolines are in place.
> > 
> > Any data on this?
> > 
> 
> Hi,
> 
> 1, What about moving these functions into virtio.h and declare them as
> static inline?

This will do nothing to remove indirection.

> 2, what about moving method fields into struct virtqueue?

This gets rid of one level of indirection but the big problem
is indirect function call due to retpolines, this remains.


> Then we have struct like:
> struct virtqueue {
> 	struct list_head list;
> 	...
> 	void *priv;
> 
> 	/* virtqueue specific operations */
>         int (*add_sgs)(struct virtqueue *vq, struct scatterlist *sgs[],
>                        unsigned int total_sg,
>                        unsigned int out_sgs, unsigned int in_sgs,
>                        void *data, void *ctx, gfp_t gfp);
> 	...
> }
> 
> and functions like:
> static inline int virtqueue_add_sgs(...)
> {
>         unsigned int i, total_sg = 0;
> 
>         /* Count them first. */
>         for (i = 0; i < out_sgs + in_sgs; i++) {
>                 struct scatterlist *sg;
> 
>                 for (sg = sgs[i]; sg; sg = sg_next(sg))
>                         total_sg++;
>         }
>         return vq->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs,
>                            data, NULL, gfp);
> }

Maybe a flag in vq: 
	bool abstract; /* use ops to add/get bufs and kick */
and then
	if (unlikely(vq->abstract))
		 return vq->ops->add_sgs(vq, sgs, total_sg, out_sgs, in_sgs,
				    	 data, NULL, gfp);

transport then just sets the ops if it wants abstract vqs,
and core then skips the vring.


> If [1] is acceptable, we can also reduce changes in patch 'tools/virtio:
> implement virtqueue in test'.

Yea that one shouldn't be there.

> -- 
> zhenwei pi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
