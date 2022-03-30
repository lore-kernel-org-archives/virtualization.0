Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B234BC433F5
	for <virtualization@archiver.kernel.org>; Wed, 30 Mar 2022 06:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5055240C6E;
	Wed, 30 Mar 2022 06:56:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sRfnn_ObCMhc; Wed, 30 Mar 2022 06:56:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E0295409D6;
	Wed, 30 Mar 2022 06:56:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3F3FC002C;
	Wed, 30 Mar 2022 06:56:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE849C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:56:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 99C906105F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:56:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lSX9nC1qW2ho
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:56:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1A9760D4E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Mar 2022 06:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648623392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GEPBB5G5c+LQGsS56cllBXvgUxc5xBSY2dhcbaxd6h4=;
 b=TR4sgtA8BBQgCGSHa5CXSCBuNb4qPtWJSF+OtTNFVV6Lq98CWG/t1kcoVCTb3BGyzikM05
 o4LZ/pCYBNG1zKzagbxGR9HU+ehewr8GRrOF5lHxk7ovmVdQEceaMQvnhhY7ItMeDXTVp7
 yD7MVdZmiw/CNDbWrYZG7Aai/rK9wLI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-mj0-5Ca8OKebWD4lHuv3Fw-1; Wed, 30 Mar 2022 02:56:30 -0400
X-MC-Unique: mj0-5Ca8OKebWD4lHuv3Fw-1
Received: by mail-lj1-f198.google.com with SMTP id
 11-20020a2e154b000000b0024967cd6752so8323168ljv.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 23:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GEPBB5G5c+LQGsS56cllBXvgUxc5xBSY2dhcbaxd6h4=;
 b=E0oYK2JmM8VEMM7M4lsMD8zDlyEgMRNgqupSu4PNUbqaX+fB5KuQ4nt3HFGfNwA205
 PAr19DPV1f4/pJ0naLss0nxsX3H0BM8UUgHsK2fqwrm49ue/33xPpkoraKfxkuG+O31c
 JpNXF0kpvoMhf13tsmc3z68yfQ4Bv/JjcMHlkFHw5Vy2Tco3VyAyTj5scECt4TIbY3cl
 +DsOt+LBb4qro4q/s4QOqlxf8AMqqlcaPIjK7PaEPnCKzGkkFVGmhaWB4CnUo0ux7moH
 FiGmatCeWmB2KxupFkprO/xw5dBgH/ZrG0I179E9EdDEGzuODJS+8lbYZmaJZoodVpvh
 ytKg==
X-Gm-Message-State: AOAM531PSr7XqrjX7n2AdTLU+jS1hyfzBpK+OHUbcASW5fx2qNjDCmWo
 bdSS+vAQb837cCiq3KPjwHxaNg3iz2xxrFrJgFbwXETLqgO7RpQ/inEh4Bte0JhRyZdf7RXgKhy
 nG8jJnopINBT2o487vPfAaStASY19Ac/JtnnorM50nPkFWhlDPEywbUEyhw==
X-Received: by 2002:ac2:4477:0:b0:44a:55c6:155d with SMTP id
 y23-20020ac24477000000b0044a55c6155dmr5669577lfl.376.1648623389276; 
 Tue, 29 Mar 2022 23:56:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwW3W/Rw+4wINA0n2UEX3TUfxQkWNftf4UnzHfapIPk1fPf1HGsiUPU++i+qV4XswKgcPdxcBzr1+V7DjLaTOM=
X-Received: by 2002:ac2:4477:0:b0:44a:55c6:155d with SMTP id
 y23-20020ac24477000000b0044a55c6155dmr5669559lfl.376.1648623389074; Tue, 29
 Mar 2022 23:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
 <20220330023258-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220330023258-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 30 Mar 2022 14:56:17 +0800
Message-ID: <CACGkMEvESXv9PfMF9riPraX59j0BiLPfTgxuFVw1x0HWwjtYVQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] virtio: support advance DMA
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Wed, Mar 30, 2022 at 2:34 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Feb 24, 2022 at 07:03:53PM +0800, Xuan Zhuo wrote:
> > virtqueue_add() only supports virtual addresses, dma is completed in
> > virtqueue_add().
> >
> > In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> > it is necessary for us to support passing the DMA address to virtqueue_add().
>
> I picked up a couple of patches. Others are waiting for some acks
> (Jason?) and improved commit logs for documentation.

I will review them.

Thanks

>
> Thanks!
>
> > v2:
> >     1. rename predma -> premapped
> >     2. virtio net xdp tx use virtio dma api
> >
> > v1:
> >    1. All sgs requested at one time are required to be unified PREDMA, and several
> >       of them are not supported to be PREDMA
> >    2. virtio_dma_map() is removed from this patch set and will be submitted
> >       together with the next time AF_XDP supports virtio dma
> >    3. Added patch #2 #3 to remove the check for flags when performing unmap
> >       indirect desc
> >
> > Xuan Zhuo (9):
> >   virtio_ring: rename vring_unmap_state_packed() to
> >     vring_unmap_extra_packed()
> >   virtio_ring: remove flags check for unmap split indirect desc
> >   virtio_ring: remove flags check for unmap packed indirect desc
> >   virtio_ring: virtqueue_add() support premapped
> >   virtio_ring: split: virtqueue_add_split() support premapped
> >   virtio_ring: packed: virtqueue_add_packed() support premapped
> >   virtio_ring: add api virtio_dma_map() for advance dma
> >   virtio_ring: introduce virtqueue_add_outbuf_premapped()
> >   virtio_net: xdp xmit use virtio dma api
> >
> >  drivers/net/virtio_net.c     |  42 +++++-
> >  drivers/virtio/virtio_ring.c | 280 ++++++++++++++++++++++++++---------
> >  include/linux/virtio.h       |  12 ++
> >  3 files changed, 254 insertions(+), 80 deletions(-)
> >
> > --
> > 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
