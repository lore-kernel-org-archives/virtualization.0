Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1EAC00528
	for <virtualization@archiver.kernel.org>; Tue,  1 Aug 2023 16:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0622404E9;
	Tue,  1 Aug 2023 16:18:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0622404E9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c/4sNp7X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HH-vZ7woHtf7; Tue,  1 Aug 2023 16:18:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 86A72402F8;
	Tue,  1 Aug 2023 16:17:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86A72402F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59EDAC0071;
	Tue,  1 Aug 2023 16:17:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF021C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 16:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8274840604
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 16:17:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8274840604
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=c/4sNp7X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xNN5pTIoBWD3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 16:17:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BD5940A1E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Aug 2023 16:17:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7BD5940A1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690906675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l5c5x2m4IYrem8PdNKSvmUfDJDtRMMxft9vUT5B0Fjk=;
 b=c/4sNp7XaCKMR2OwETuIHdCdtjnzmlVvFVWQlY9o7RIdCK5itzNaQVBe3Vl+hBmImmeME9
 fgSwkM/6OdR0P0RwAn4y2Z/JtaAAGjkwvReGL6U6aceaTqt55eY91NT4xOuBZ/fUwoXVJL
 tGDhxA4v6HoNch3QPHa5B5kIWj28i/Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-GAdcf6x8P5amwFIL0t1giw-1; Tue, 01 Aug 2023 12:17:53 -0400
X-MC-Unique: GAdcf6x8P5amwFIL0t1giw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fd2209bde4so31387445e9.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Aug 2023 09:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690906672; x=1691511472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5c5x2m4IYrem8PdNKSvmUfDJDtRMMxft9vUT5B0Fjk=;
 b=c2qMLWCgZblHt47glTZ1L5h18VzAVWoE8eikuWm/lpBK5BHVXarQrmqOefIycAdwQD
 gnbTIWmwMqaX6iGaHUucSxFJj/mB1yKXpqXMkBL+9Bn1e/eYBhUPFr2WF7oovQKmA3Qg
 /Vc2yx3NLY7r1T0Sk7WcVjTGIPIyODSyhSGEcTWjdJP5il67PrSIyrji+24g3TDiprEx
 InSAgsxD1k2WIiwh/mN9uRcgI+PCd4Di4Y4r7T4kS5iqJaXIoGdQEWXMTcxAKB3MWDDV
 KOPzkC1+biHGk8wfx84Si+GxeFzkgxBxYk1SiCydUI/CUKYwVYrUfAHD95tu+4Pu/1ZF
 Pwmw==
X-Gm-Message-State: ABy/qLa5gGuDuv6IZlYUvB/Q2O83lmoTGUzvmjrTBHiXKeRYbQTjmuc6
 7HiqhvjAVF0JrZrRl6yWHwfg61Pprsa985wIVVc5y2t32xOA/MexABcTeCL1ztNTsUSAuEmTM/P
 +RqJgHluNEph4ZB5hE9ye+UkahfxOpB44N6dCJ92mZw==
X-Received: by 2002:a1c:f719:0:b0:3fe:188c:b684 with SMTP id
 v25-20020a1cf719000000b003fe188cb684mr2874895wmh.7.1690906672680; 
 Tue, 01 Aug 2023 09:17:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHzGaEDuesnxEFzI0n611DuR5a4DRd8NJaxHoq6B/0W1UuZ3GQSQuSUE+vdJPZJwfyXDPDA7Q==
X-Received: by 2002:a1c:f719:0:b0:3fe:188c:b684 with SMTP id
 v25-20020a1cf719000000b003fe188cb684mr2874878wmh.7.1690906672372; 
 Tue, 01 Aug 2023 09:17:52 -0700 (PDT)
Received: from redhat.com ([2.52.21.81]) by smtp.gmail.com with ESMTPSA id
 l27-20020a05600c1d1b00b003fe1b3e0852sm4530904wms.0.2023.08.01.09.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 09:17:51 -0700 (PDT)
Date: Tue, 1 Aug 2023 12:17:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Message-ID: <20230801121543-mutt-send-email-mst@kernel.org>
References: <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
 <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
 <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Fri, Jul 28, 2023 at 02:02:33PM +0800, Xuan Zhuo wrote:
> On Tue, 25 Jul 2023 19:07:23 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > On Tue, 25 Jul 2023 03:34:34 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Tue, Jul 25, 2023 at 10:13:48AM +0800, Xuan Zhuo wrote:
> > > > On Mon, 24 Jul 2023 09:43:42 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> > > > > On Thu, Jul 20, 2023 at 01:21:07PM -0400, Michael S. Tsirkin wrote:
> > > > > > Well I think we can add wrappers like virtio_dma_sync and so on.
> > > > > > There are NOP for non-dma so passing the dma device is harmless.
> > > > >
> > > > > Yes, please.
> > > >
> > > >
> > > > I am not sure I got this fully.
> > > >
> > > > Are you mean this:
> > > > https://lore.kernel.org/all/20230214072704.126660-8-xuanzhuo@linux.alibaba.com/
> > > > https://lore.kernel.org/all/20230214072704.126660-9-xuanzhuo@linux.alibaba.com/
> > > >
> > > > Then the driver must do dma operation(map and sync) by these virtio_dma_* APIs.
> > > > No care the device is non-dma device or dma device.
> > >
> > > yes
> > >
> > > > Then the AF_XDP must use these virtio_dma_* APIs for virtio device.
> > >
> > > We'll worry about AF_XDP when the patch is posted.
> >
> > YES.
> >
> > We discussed it. They voted 'no'.
> >
> > http://lore.kernel.org/all/20230424082856.15c1e593@kernel.org
> 
> 
> Hi guys, this topic is stuck again. How should I proceed with this work?
> 
> Let me briefly summarize:
> 1. The problem with adding virtio_dma_{map, sync} api is that, for AF_XDP and
> the driver layer, we need to support these APIs. The current conclusion of
> AF_XDP is no.
> 
> 2. Set dma_set_mask_and_coherent, then we can use DMA API uniformly inside
> driver. This idea seems to be inconsistent with the framework design of DMA. The
> conclusion is no.
> 
> 3. We noticed that if the virtio device supports VIRTIO_F_ACCESS_PLATFORM, it
> uses DMA API. And this type of device is the future direction, so we only
> support DMA premapped for this type of virtio device. The problem with this
> solution is that virtqueue_dma_dev() only returns dev in some cases, because
> VIRTIO_F_ACCESS_PLATFORM is supported in such cases. Otherwise NULL is returned.
> This option is currently NO.
> 
> So I'm wondering what should I do, from a DMA point of view, is there any
> solution in case of using DMA API?
> 
> Thank you


I think it's ok at this point, Christoph just asked you
to add wrappers for map/unmap for use in virtio code.
Seems like a cosmetic change, shouldn't be hard.
Otherwise I haven't seen significant comments.


Christoph do I summarize what you are saying correctly?
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
