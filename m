Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0717CC433FE
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 08:38:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80525417D3;
	Wed, 30 Mar 2022 08:38:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RgriGagIVj-M; Wed, 30 Mar 2022 08:38:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B0F49417BA;
	Wed, 30 Mar 2022 08:38:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FCE5C002C;
	Wed, 30 Mar 2022 08:38:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7142DC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 08:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5807440491
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 08:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Rm4ZpEG65QK
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 08:38:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 221BF4040D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 08:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648629512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bzS4bqzaOxuZfQIkqpt655mQSjWQT1LHlpgKAIFezfk=;
 b=I95rdoLFg4j5tZLHKQsTWXvthutVvS4b59GHR+ruZx1CfMzhiXoayGlMORhJKOV3z28lJr
 1G95JAwMNS1pnI9qUTGCa8So2E7bJDFkfgECjm+/tkCeA1evivb+BT9AovP+vKCd6UNAxx
 e8ffSoawc2Ebwz4YR2lAfuq5dcCDLBs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-8J5nMlcTNoWZQfEu399Ogw-1; Wed, 30 Mar 2022 04:38:31 -0400
X-MC-Unique: 8J5nMlcTNoWZQfEu399Ogw-1
Received: by mail-lj1-f198.google.com with SMTP id
 t10-20020a2e2d0a000000b002496423e4adso8457345ljt.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 01:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bzS4bqzaOxuZfQIkqpt655mQSjWQT1LHlpgKAIFezfk=;
 b=Gs9O6NoMedJRyS4PxBBL8oj8oIp3U77kswfqZ7tuT+QOkAtKOHi8AtEY2VpTFsSG7b
 lqNEc7bIeSPGQEiVdNcJKXP3Nd7NSIXUbU0dPieSyo+erSWt+7KtguFd5h/GIuBjOsaa
 Lj8hlUdxGMkQ4f49VrjMRdDk7M/D42aV+Qz/RbBYOUqeGnXJR8JIzxNmCNrnx6DHBB25
 b7DYIjQJSGpS1igins7ybSwVcmlfS7FI9POgU3XU9nmu8eDe7QpYBxlv76o/8/zlEVfJ
 W07OjP20TpdeAa9ulzMf/vj6WRwY+ildL90EtyBWIqUF0mdFyTbDGS0Z//paTiHvRaue
 JrzQ==
X-Gm-Message-State: AOAM531/B6fLK2jedXDWVfbWa5pSZF0jjTkMAi032inYMU/fB9irLk5q
 29zKjtEuUtceUpWi7XRwH/br7XYlTebgsd6Xk8jcCWzVYRzTV4VeUX3jaBXTFOEptpGf0bgFh8J
 rVaBcqg4ABrkvSA1CTNfPO6OOFU6yxA28OnwJsnXrlPpp5bam3c589WFk+Q==
X-Received: by 2002:a05:651c:b0c:b0:247:e4b7:d4a0 with SMTP id
 b12-20020a05651c0b0c00b00247e4b7d4a0mr5872393ljr.177.1648629509501; 
 Wed, 30 Mar 2022 01:38:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIPbYjEeHmjbGHJuP7G8/hPMIgwTlai10LTpW4LfE/TTf2L5sMsD52LohP2OT9kKgyXmx5YOKVinJp+YoaSOM=
X-Received: by 2002:a05:651c:b0c:b0:247:e4b7:d4a0 with SMTP id
 b12-20020a05651c0b0c00b00247e4b7d4a0mr5872383ljr.177.1648629509284; Wed, 30
 Mar 2022 01:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
 <20220330023258-mutt-send-email-mst@kernel.org>
 <CACGkMEvESXv9PfMF9riPraX59j0BiLPfTgxuFVw1x0HWwjtYVQ@mail.gmail.com>
 <1648623508.9711535-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1648623508.9711535-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 30 Mar 2022 16:38:18 +0800
Message-ID: <CACGkMEvE_wUNa=DgumVErTjp5gF4QRMDn6eP7UbDpSfSJSBy2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] virtio: support advance DMA
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, Mar 30, 2022 at 2:59 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Wed, 30 Mar 2022 14:56:17 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Wed, Mar 30, 2022 at 2:34 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Feb 24, 2022 at 07:03:53PM +0800, Xuan Zhuo wrote:
> > > > virtqueue_add() only supports virtual addresses, dma is completed in
> > > > virtqueue_add().
> > > >
> > > > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > > > it is necessary for us to support passing the DMA address to virtqueue_add().
> > >
> > > I picked up a couple of patches. Others are waiting for some acks
> > > (Jason?) and improved commit logs for documentation.
> >
> > I will review them.
>
> hi, the core code of premapped, I will merge it into 'virtio pci support
> VIRTIO_F_RING_RESET' because this function will be used when reusing the buffer
> after resize.

I still prefer not to do that.

We can make rest work for resize first and add pre mapping on top. It
will simplify the review.

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
> > >
> > > Thanks!
> > >
> > > > v2:
> > > >     1. rename predma -> premapped
> > > >     2. virtio net xdp tx use virtio dma api
> > > >
> > > > v1:
> > > >    1. All sgs requested at one time are required to be unified PREDMA, and several
> > > >       of them are not supported to be PREDMA
> > > >    2. virtio_dma_map() is removed from this patch set and will be submitted
> > > >       together with the next time AF_XDP supports virtio dma
> > > >    3. Added patch #2 #3 to remove the check for flags when performing unmap
> > > >       indirect desc
> > > >
> > > > Xuan Zhuo (9):
> > > >   virtio_ring: rename vring_unmap_state_packed() to
> > > >     vring_unmap_extra_packed()
> > > >   virtio_ring: remove flags check for unmap split indirect desc
> > > >   virtio_ring: remove flags check for unmap packed indirect desc
> > > >   virtio_ring: virtqueue_add() support premapped
> > > >   virtio_ring: split: virtqueue_add_split() support premapped
> > > >   virtio_ring: packed: virtqueue_add_packed() support premapped
> > > >   virtio_ring: add api virtio_dma_map() for advance dma
> > > >   virtio_ring: introduce virtqueue_add_outbuf_premapped()
> > > >   virtio_net: xdp xmit use virtio dma api
> > > >
> > > >  drivers/net/virtio_net.c     |  42 +++++-
> > > >  drivers/virtio/virtio_ring.c | 280 ++++++++++++++++++++++++++---------
> > > >  include/linux/virtio.h       |  12 ++
> > > >  3 files changed, 254 insertions(+), 80 deletions(-)
> > > >
> > > > --
> > > > 2.31.0
> > >
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
