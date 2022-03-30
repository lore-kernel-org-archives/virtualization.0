Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6441DC433F5
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 10:59:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 068DB844E9;
	Wed, 30 Mar 2022 10:59:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bZILpluLeJxd; Wed, 30 Mar 2022 10:59:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 515CD84520;
	Wed, 30 Mar 2022 10:59:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 356B4C002C;
	Wed, 30 Mar 2022 10:59:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D228C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 10:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B2AE611CD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 10:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n4mcSee0UMlf
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 10:59:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 58E0F61076
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 10:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648637944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9RAN3K31yIanK0mkbf822eHFFyjPQazU54U6oFjxEo8=;
 b=goDuZ6llBGFtSWpRcf3UwWH/dd7SDWTvZUQ2GoO4TqmE3gA94/C0Sm8hRDj5F2iiiMZa3Y
 76FhSIUJQ42JkNmWvfXAwf9Z1xYmezW9m1yItMSa0DBq5uQw8qURmv2ywtaKEBU0vXkuUj
 J6l7F4DApWdpIMQ9CwN/qsS1/VSO0OU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-nDpYXENFNIm5mA6O98rHqA-1; Wed, 30 Mar 2022 06:59:02 -0400
X-MC-Unique: nDpYXENFNIm5mA6O98rHqA-1
Received: by mail-wm1-f69.google.com with SMTP id
 o19-20020a05600c379300b0038c7117460dso2423197wmr.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 03:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9RAN3K31yIanK0mkbf822eHFFyjPQazU54U6oFjxEo8=;
 b=cPtuipt2GfYFtFwO8hi+KzcnvVV42F0NqHKZzXZLYN18n+sUI4JMAD8EQJgo7Zu6bc
 4w5iVPi6B2DFtYu7bCFue7NUSKCwwTTPkVxsXz4V6kNBgm+YmZ12lVZgkpePdb+5NT89
 WI3xh7DGH9jhd68jdUcNLkR3YRdoHnVdvGqyi2eGNzoa9rAW2NXYT5Y46oKPs0oBw162
 3TxPJ7gc1vOpWSpGmlusKoPSC2Z4WrbPK0XZqMaOYancebLBHMyMMw+U2TLBzeeinnH0
 LVaHxagtaqQEUF+oNgyA3dAR0r9zXrO1pw4+l84yFgkpu6Emf6jvE1KeYGlk0q+8eFK0
 RZ1Q==
X-Gm-Message-State: AOAM531gtk4hwC/3KLy6qM0TlJBw6eTROPuRcTS1lTuA+YFxN+j8KsMn
 dMZvcljdOSG94dUaBnSGwXH5GG343teulCI7/DEVSHif5iWFQIF9DtO5Wg+47vap0ucjkcCEBxM
 4OCtXZWW5fM5pFP/cXGAEvNkB2oWXOP495SjmE7jQZQ==
X-Received: by 2002:a05:600c:3487:b0:38c:9a42:4d49 with SMTP id
 a7-20020a05600c348700b0038c9a424d49mr3900208wmq.29.1648637941466; 
 Wed, 30 Mar 2022 03:59:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKV0sSZa5jXgCtLILsMdNcYCvhipOKkQEFH6Okc5wsU1w1DYNitZVMOfLDz3s0DMSZYRktng==
X-Received: by 2002:a05:600c:3487:b0:38c:9a42:4d49 with SMTP id
 a7-20020a05600c348700b0038c9a424d49mr3900188wmq.29.1648637941203; 
 Wed, 30 Mar 2022 03:59:01 -0700 (PDT)
Received: from redhat.com ([2.52.9.207]) by smtp.gmail.com with ESMTPSA id
 x13-20020adfec0d000000b00203ff46f802sm24462014wrn.36.2022.03.30.03.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Mar 2022 03:59:00 -0700 (PDT)
Date: Wed, 30 Mar 2022 06:58:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 0/9] virtio: support advance DMA
Message-ID: <20220330065832-mutt-send-email-mst@kernel.org>
References: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
 <20220330023258-mutt-send-email-mst@kernel.org>
 <CACGkMEvESXv9PfMF9riPraX59j0BiLPfTgxuFVw1x0HWwjtYVQ@mail.gmail.com>
 <1648623508.9711535-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvE_wUNa=DgumVErTjp5gF4QRMDn6eP7UbDpSfSJSBy2Q@mail.gmail.com>
 <1648631012.1186295-1-xuanzhuo@linux.alibaba.com>
 <20220330065039-mutt-send-email-mst@kernel.org>
 <1648637513.2871974-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1648637513.2871974-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev <netdev@vger.kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
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

On Wed, Mar 30, 2022 at 06:51:53PM +0800, Xuan Zhuo wrote:
> On Wed, 30 Mar 2022 06:51:03 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Mar 30, 2022 at 05:03:32PM +0800, Xuan Zhuo wrote:
> > > On Wed, 30 Mar 2022 16:38:18 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > On Wed, Mar 30, 2022 at 2:59 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > >
> > > > > On Wed, 30 Mar 2022 14:56:17 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > > On Wed, Mar 30, 2022 at 2:34 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Feb 24, 2022 at 07:03:53PM +0800, Xuan Zhuo wrote:
> > > > > > > > virtqueue_add() only supports virtual addresses, dma is completed in
> > > > > > > > virtqueue_add().
> > > > > > > >
> > > > > > > > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > > > > > > > it is necessary for us to support passing the DMA address to virtqueue_add().
> > > > > > >
> > > > > > > I picked up a couple of patches. Others are waiting for some acks
> > > > > > > (Jason?) and improved commit logs for documentation.
> > > > > >
> > > > > > I will review them.
> > > > >
> > > > > hi, the core code of premapped, I will merge it into 'virtio pci support
> > > > > VIRTIO_F_RING_RESET' because this function will be used when reusing the buffer
> > > > > after resize.
> > > >
> > > > I still prefer not to do that.
> > > >
> > > > We can make rest work for resize first and add pre mapping on top. It
> > > > will simplify the review.
> > >
> > > Yes, I am also worried about the review problem, the number of my local resize
> > > patch has reached 44 (including reuse bufs).
> > >
> > > hi, Michael, can we implement resize on top of v8 first? (drop unused bufs directly)
> > >
> > > Then we implement premmapd and reuse the bufs after resize.
> > >
> > > We need to get the address (DMA address) and len from the reset ring and submit
> > > it to the new vq through virtqueue_add(). So let virtqueue_add() support
> > > premapped first.
> > >
> > > Thanks.
> >
> > Not sure I understand.
> > So the plan is
> > - remap
> > - resize on top
> > ?
> 
> #1 resize with drop unused bufs directly
> #2 premapped and resize support reuse the unused bufs
> 
> This way "premaped" will have a user.
> 
> Between #1 and #2, I may submit some code with optimized formatting, because
> jason doesn't like my introduction of struct vring_split and struct vring_packed
> in #1 for passing parameters between extracted functions.
> 
> Thanks.

So let's start with 1. Direct drop for now is ok.


> 
> >
> >
> >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > >
> > > > > > > Thanks!
> > > > > > >
> > > > > > > > v2:
> > > > > > > >     1. rename predma -> premapped
> > > > > > > >     2. virtio net xdp tx use virtio dma api
> > > > > > > >
> > > > > > > > v1:
> > > > > > > >    1. All sgs requested at one time are required to be unified PREDMA, and several
> > > > > > > >       of them are not supported to be PREDMA
> > > > > > > >    2. virtio_dma_map() is removed from this patch set and will be submitted
> > > > > > > >       together with the next time AF_XDP supports virtio dma
> > > > > > > >    3. Added patch #2 #3 to remove the check for flags when performing unmap
> > > > > > > >       indirect desc
> > > > > > > >
> > > > > > > > Xuan Zhuo (9):
> > > > > > > >   virtio_ring: rename vring_unmap_state_packed() to
> > > > > > > >     vring_unmap_extra_packed()
> > > > > > > >   virtio_ring: remove flags check for unmap split indirect desc
> > > > > > > >   virtio_ring: remove flags check for unmap packed indirect desc
> > > > > > > >   virtio_ring: virtqueue_add() support premapped
> > > > > > > >   virtio_ring: split: virtqueue_add_split() support premapped
> > > > > > > >   virtio_ring: packed: virtqueue_add_packed() support premapped
> > > > > > > >   virtio_ring: add api virtio_dma_map() for advance dma
> > > > > > > >   virtio_ring: introduce virtqueue_add_outbuf_premapped()
> > > > > > > >   virtio_net: xdp xmit use virtio dma api
> > > > > > > >
> > > > > > > >  drivers/net/virtio_net.c     |  42 +++++-
> > > > > > > >  drivers/virtio/virtio_ring.c | 280 ++++++++++++++++++++++++++---------
> > > > > > > >  include/linux/virtio.h       |  12 ++
> > > > > > > >  3 files changed, 254 insertions(+), 80 deletions(-)
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.31.0
> > > > > > >
> > > > > >
> > > > >
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
