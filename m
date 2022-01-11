Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507D3C433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 08:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9B5583DF6;
	Tue, 11 Jan 2022 08:26:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cqw6fo_EjePk; Tue, 11 Jan 2022 08:26:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5E3CE83774;
	Tue, 11 Jan 2022 08:26:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FAA8C002F;
	Tue, 11 Jan 2022 08:26:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DE0BC001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 08:26:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 31D088378C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 08:26:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3c7D0iZdhSwt
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 08:26:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E0B8583774
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 08:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641889559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+/OKaqtz8+Dw+v3YAaZTj/Ms8Bpz5hMwogNtImf50kg=;
 b=T1V+gXb68Q8TT0+8viKtUWumRmsmVqvCv6Ky1d7wCQrmafB7d+A5Zp5ZGdk+2l/ZK2cBmg
 9bEJy3AQJEt1ybdQ2if8rZC+c0K/4w5+kIoAyPXQd0q77dOzmo8SUUnTHMbjTDkMVNPX4e
 7rf4FIEgEz9017ODFJLyMPP4skyQi0s=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-kSF4ixb9MQyap8QSavsKjA-1; Tue, 11 Jan 2022 03:25:57 -0500
X-MC-Unique: kSF4ixb9MQyap8QSavsKjA-1
Received: by mail-lf1-f69.google.com with SMTP id
 d12-20020a196b0c000000b0042afa90ae9bso5975350lfa.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 00:25:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+/OKaqtz8+Dw+v3YAaZTj/Ms8Bpz5hMwogNtImf50kg=;
 b=d1ILyOlTKwKk6AxMI67UXNrBXOdGGyxY7lYWOwucxjmy9N5pELeD4B5oxcK05qIwxu
 q7u5aagYV9R0rFnapU9nh5+aE+tiPaHg5p1yU9ImmfnB9myrqH7jpXQTiyfug+RVUZqX
 Bu9hm+0TCSPSTtl61MWZ9VT+aoCF5Wl9kPcoD6rSHNjYKr8NrEOEUxYx9/by70o/l5Iw
 4hi+M056lVgHntoMztnqTbI1AkcM2YY6IJ2NkZYqcerbXuvhWCuC9u496obOJRJQVBqn
 VxVccqszqqeEdJnavd+kr7y1BUtXsFNBYXVBoGZyT+ttFEDItHIKM1Czb2RrnaPpSrZa
 aCBw==
X-Gm-Message-State: AOAM533IjJAdpv1fybhleP2d1dtM6kX+jbc9yhf61lI6RW9yrQy/1/2o
 Dm/9MKG3t84tHFfpe4z560PU541txovPrZDHv2Io3aFgNNDA7qGTuBfFwfjh8V4Vi1JaBw6EkMI
 wL9k2B2SKOotkuSN+FO6uxeGUidwtSnSxaboxWhjJhepN6nIDJ6BEB4pQWg==
X-Received: by 2002:a05:6512:230f:: with SMTP id
 o15mr2725484lfu.348.1641889556420; 
 Tue, 11 Jan 2022 00:25:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyy4BscG7xyJmhobBLOjHAFDsa2WIsrdpyMKSFamWmiNxSmrahBLJNqWzyTUTIxajIoZKtf/qjHkzMrfFjKE7A=
X-Received: by 2002:a05:6512:230f:: with SMTP id
 o15mr2725470lfu.348.1641889556228; 
 Tue, 11 Jan 2022 00:25:56 -0800 (PST)
MIME-Version: 1.0
References: <MW3PR11MB46029D413C9A6C32C0E5B347F7519@MW3PR11MB4602.namprd11.prod.outlook.com>
 <1641888372.6630723-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1641888372.6630723-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Jan 2022 16:25:44 +0800
Message-ID: <CACGkMEv1p=tM-YNM0nKTDxQCOkaL-9xVji8K76fJxMwwwYHkJg@mail.gmail.com>
Subject: Re: RE: [PATCH 0/6] virtio: support advance DMA
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S.Tsirkin" <mst@redhat.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Tue, Jan 11, 2022 at 4:17 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Tue, 11 Jan 2022 08:04:05 +0000, Karlsson, Magnus <magnus.karlsson@intel.com> wrote:
> >
> >
> > > -----Original Message-----
> > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Sent: Tuesday, January 11, 2022 7:17 AM
> > > To: Jason Wang <jasowang@redhat.com>
> > > Cc: virtualization <virtualization@lists.linux-foundation.org>; Michael S.Tsirkin
> > > <mst@redhat.com>; Karlsson, Magnus <magnus.karlsson@intel.com>
> > > Subject: Re: [PATCH 0/6] virtio: support advance DMA
> > >
> > > On Tue, 11 Jan 2022 10:54:45 +0800, Jason Wang <jasowang@redhat.com>
> > > wrote:
> > > > On Mon, Jan 10, 2022 at 5:59 PM Michael S. Tsirkin <mst@redhat.com>
> > > wrote:
> > > > >
> > > > > On Fri, Jan 07, 2022 at 02:33:00PM +0800, Xuan Zhuo wrote:
> > > > > > virtqueue_add() only supports virtual addresses, dma is completed
> > > > > > in virtqueue_add().
> > > > > >
> > > > > > In some scenarios (such as the AF_XDP scenario), DMA is completed
> > > > > > in advance, so it is necessary for us to support passing the DMA address
> > > to virtqueue_add().
> > > > > >
> > > > > > This patch set stipulates that if sg->dma_address is not NULL, use
> > > > > > this address as the DMA address. And record this information in
> > > > > > extra->flags, which can be skipped when executing dma unmap.
> > > > > >
> > > > > >     extra->flags |= VRING_DESC_F_PREDMA;
> > > > > >
> > > > > > But the indirect desc does not have a corresponding extra, so the
> > > > > > second and third patches of this patch set are to allocate the
> > > > > > corresponding extra while allocating the indirect desc. Each desc
> > > > > > must have a corresponding extra because it is possible in an sgs
> > > > > > some are advance DMA, while others are virtual addresses. So we must
> > > allocate an extra for each indirect desc.
> > > > >
> > > > >
> > > > > I didn't realize AF_XDP didn't have space to stuff the header into.
> > > > > Jason, is that expected?
> > > >
> > > > I might be wrong but it looks to me AF_XDP allows to reserve
> > > > sufficient headroom via xdp_umem_reg_v1.
> > > >
> > >
> > > I understand that there is a headroom for receiving packages, which can be
> > > used to put virtio headers. But there is no headroom defined in the direction
> > > of sending packages. I hope Magnus Karlsson can help confirm whether
> > > there is any misunderstanding.
> >
> > You can specify the amount of headroom you want on Tx by adjusting the "addr" field in the descriptor of the Tx ring. If your chunk starts at address X in the umem and you want 128 bytes of headroom, just write your packet into X+128 and put that address into the Tx descriptor. Will this solve your problem? If not, what would you need from AF_XDP to make it work?
> >
> > On Rx, there is always 256 bytes worth of headroom as specified by XDP. If you need extra, you can set the headroom variable when you register the umem.
>
> The driver of virtio net, when passing the packet to the hardware, should add a
> virtnet hdr (12 bytes) in front of the packet. Both rx and tx should add such a
> header. AF_XDP has a space of 256 bytes in the rx process. We can reuse this
> space. The direction of AF_XDP tx has no such regulation.
>
> The method you mentioned requires user cooperation, which is not a good method
> for driver implementation.

This will result in a non-portable userspace program. I wonder why TX
has become a problem here actually, anyhow we can use a dedicated sg
for vnet hdr? And if we packed all vnet headers in an array it will
give less performance impact.

Thanks

>
> Thanks.
>
> >
> > > It would be best if we could not use indirect.
> > >
> > > Thanks.
> > >
> > > > > It would be best to fix that, performance is best if header is
> > > > > linear with the data ...
> > > >
> > > > This looks like a must otherwise we may meet trouble in zerocopy receive.
> > > >
> > > > Thanks
> > > >
> > > > > Or maybe we can reduce the use of indirect somewhat, at least while
> > > > > the ring is mostly empty?
> > > > >
> > > > > > Xuan Zhuo (6):
> > > > > >   virtio: rename vring_unmap_state_packed() to
> > > > > >     vring_unmap_extra_packed()
> > > > > >   virtio: split: alloc indirect desc with extra
> > > > > >   virtio: packed: alloc indirect desc with extra
> > > > > >   virtio: split: virtqueue_add_split() support dma address
> > > > > >   virtio: packed: virtqueue_add_packed() support dma address
> > > > > >   virtio: add api virtio_dma_map() for advance dma
> > > > > >
> > > > > >  drivers/virtio/virtio_ring.c | 387 ++++++++++++++++++++---------------
> > > > > >  include/linux/virtio.h       |   9 +
> > > > > >  2 files changed, 232 insertions(+), 164 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.31.0
> > > > >
> > > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
