Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5691C433EF
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 10:51:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82A5061076;
	Wed, 30 Mar 2022 10:51:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JI6Mgw3RJAqk; Wed, 30 Mar 2022 10:51:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 11BE261040;
	Wed, 30 Mar 2022 10:51:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E804DC002C;
	Wed, 30 Mar 2022 10:51:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93D7AC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 10:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B47C8478F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 10:51:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Eph8vdfMaDql
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 10:51:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2922184787
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 10:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648637470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wnMSItC8n0CDYr8QTJ4aTsqJAmXh/a7xPpLx6HfylVg=;
 b=V5fIOQcvia9YEkldjrLwYXr4++Iya2a6f6YG5yJseLFHE+arQrD/l7N1zrKy1Wpl4/zGbf
 iI5lBsVx9Yv5nHoUftIiH56/eDaxY+MQl5F8whVcG8BGuElefIJ/7i9NGnVAm1KCU5V1Hp
 3pIZJbkgDZeCpAFv2Trl+RZdwOM1xLw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-HuVhQ5JcMK6Yw16fj8dkzQ-1; Wed, 30 Mar 2022 06:51:09 -0400
X-MC-Unique: HuVhQ5JcMK6Yw16fj8dkzQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 m35-20020a05600c3b2300b0038c90ef2dceso941735wms.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 03:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wnMSItC8n0CDYr8QTJ4aTsqJAmXh/a7xPpLx6HfylVg=;
 b=KVXgEz5lWYHtjLFtef/wvt9OAJn7I0Qr29eY5KtiQQuS5YGejFj2wyJbZJEthPob1I
 idTItx2DqIZE7qYt2/aXQsMNY6wPS7wJVG93L8gsuF4JPahtjyjKakZZq+lnPnhwFHTv
 a0PgyMHiBpvY/UEWnQYTXnG+9o2wyMAtABevtnr32qfJdFcZ6AgiRMlXHz7F5PFsy5zh
 vL3H+VmUGn0OVRii9SrKces2eZJH5PmFzKa03cqdfqXDFVgaJWDrWKa3fjM5OnrLjy7C
 j7uYF8x0zx+fiUf7jeJOMnUDd711J4gqZx6e0xLKrsHl12w4gsiA+ix0EPCzrj9wPDg/
 WuYg==
X-Gm-Message-State: AOAM531e0+tayIbxBrewKJeWCo7VmDGRhae70xTo8w1uoFM1rzwbkhQa
 cCrgN1P56gCFV5RpLA2uoPjTLQUVojbL08WPiUEbwxJOXreY7JY/5O6yRPOdXnbwHWLGOljAHKb
 FatPkFFR2HfP9ADeJeeonzPDXwVKGdADxeSUjhPoWww==
X-Received: by 2002:a5d:66ca:0:b0:203:f9b1:dfc0 with SMTP id
 k10-20020a5d66ca000000b00203f9b1dfc0mr36046487wrw.146.1648637468404; 
 Wed, 30 Mar 2022 03:51:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBZEJlZUuM9T8weSZ6dyHvg5KLz9n08nG046N4t/DHrijmrL4VGxtkumOjoOLwAE/zUA3xxQ==
X-Received: by 2002:a5d:66ca:0:b0:203:f9b1:dfc0 with SMTP id
 k10-20020a5d66ca000000b00203f9b1dfc0mr36046468wrw.146.1648637468157; 
 Wed, 30 Mar 2022 03:51:08 -0700 (PDT)
Received: from redhat.com ([2.52.9.207]) by smtp.gmail.com with ESMTPSA id
 d20-20020a05600c34d400b0038caf684679sm6436194wmq.0.2022.03.30.03.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Mar 2022 03:51:07 -0700 (PDT)
Date: Wed, 30 Mar 2022 06:51:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v2 0/9] virtio: support advance DMA
Message-ID: <20220330065039-mutt-send-email-mst@kernel.org>
References: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
 <20220330023258-mutt-send-email-mst@kernel.org>
 <CACGkMEvESXv9PfMF9riPraX59j0BiLPfTgxuFVw1x0HWwjtYVQ@mail.gmail.com>
 <1648623508.9711535-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvE_wUNa=DgumVErTjp5gF4QRMDn6eP7UbDpSfSJSBy2Q@mail.gmail.com>
 <1648631012.1186295-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1648631012.1186295-1-xuanzhuo@linux.alibaba.com>
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

On Wed, Mar 30, 2022 at 05:03:32PM +0800, Xuan Zhuo wrote:
> On Wed, 30 Mar 2022 16:38:18 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > On Wed, Mar 30, 2022 at 2:59 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > On Wed, 30 Mar 2022 14:56:17 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > On Wed, Mar 30, 2022 at 2:34 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Thu, Feb 24, 2022 at 07:03:53PM +0800, Xuan Zhuo wrote:
> > > > > > virtqueue_add() only supports virtual addresses, dma is completed in
> > > > > > virtqueue_add().
> > > > > >
> > > > > > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > > > > > it is necessary for us to support passing the DMA address to virtqueue_add().
> > > > >
> > > > > I picked up a couple of patches. Others are waiting for some acks
> > > > > (Jason?) and improved commit logs for documentation.
> > > >
> > > > I will review them.
> > >
> > > hi, the core code of premapped, I will merge it into 'virtio pci support
> > > VIRTIO_F_RING_RESET' because this function will be used when reusing the buffer
> > > after resize.
> >
> > I still prefer not to do that.
> >
> > We can make rest work for resize first and add pre mapping on top. It
> > will simplify the review.
> 
> Yes, I am also worried about the review problem, the number of my local resize
> patch has reached 44 (including reuse bufs).
> 
> hi, Michael, can we implement resize on top of v8 first? (drop unused bufs directly)
> 
> Then we implement premmapd and reuse the bufs after resize.
> 
> We need to get the address (DMA address) and len from the reset ring and submit
> it to the new vq through virtqueue_add(). So let virtqueue_add() support
> premapped first.
> 
> Thanks.

Not sure I understand.
So the plan is
- remap
- resize on top
?



> 
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thanks!
> > > > >
> > > > > > v2:
> > > > > >     1. rename predma -> premapped
> > > > > >     2. virtio net xdp tx use virtio dma api
> > > > > >
> > > > > > v1:
> > > > > >    1. All sgs requested at one time are required to be unified PREDMA, and several
> > > > > >       of them are not supported to be PREDMA
> > > > > >    2. virtio_dma_map() is removed from this patch set and will be submitted
> > > > > >       together with the next time AF_XDP supports virtio dma
> > > > > >    3. Added patch #2 #3 to remove the check for flags when performing unmap
> > > > > >       indirect desc
> > > > > >
> > > > > > Xuan Zhuo (9):
> > > > > >   virtio_ring: rename vring_unmap_state_packed() to
> > > > > >     vring_unmap_extra_packed()
> > > > > >   virtio_ring: remove flags check for unmap split indirect desc
> > > > > >   virtio_ring: remove flags check for unmap packed indirect desc
> > > > > >   virtio_ring: virtqueue_add() support premapped
> > > > > >   virtio_ring: split: virtqueue_add_split() support premapped
> > > > > >   virtio_ring: packed: virtqueue_add_packed() support premapped
> > > > > >   virtio_ring: add api virtio_dma_map() for advance dma
> > > > > >   virtio_ring: introduce virtqueue_add_outbuf_premapped()
> > > > > >   virtio_net: xdp xmit use virtio dma api
> > > > > >
> > > > > >  drivers/net/virtio_net.c     |  42 +++++-
> > > > > >  drivers/virtio/virtio_ring.c | 280 ++++++++++++++++++++++++++---------
> > > > > >  include/linux/virtio.h       |  12 ++
> > > > > >  3 files changed, 254 insertions(+), 80 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.31.0
> > > > >
> > > >
> > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
