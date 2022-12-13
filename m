Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA8CC4332F
	for <virtualization@archiver.kernel.org>; Tue, 13 Dec 2022 03:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0734081C6F;
	Tue, 13 Dec 2022 03:43:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0734081C6F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AgNBeskm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jLOnQ5EFd6iO; Tue, 13 Dec 2022 03:43:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9771B81C40;
	Tue, 13 Dec 2022 03:43:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9771B81C40
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54EF0C0033;
	Tue, 13 Dec 2022 03:43:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 954B3C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 03:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5BDC181C58
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 03:43:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5BDC181C58
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YkFqZrjnDebL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 03:43:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A19F81C40
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A19F81C40
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 03:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670903031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=256Ct247/EiVmrEdEn67dwnBON0/XMOLy97CHVgBe6k=;
 b=AgNBeskmDIvhJxIA3Al76zDIHnfxKeVpLpl4onhDFj9Cp39FuAB44dXDKYMU7t+YFL/HgC
 itCaz/J2KPO7psWGVZUaSsYWgp3xxUTVeGdC+5fbtIK9kmwT3uRc7ED95meav/1JOejrnf
 MMIxoRrLHK9cDl5NdLlkWy4Zx5/8Z1M=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-126-0nOSpGKIN3K1QcBmjoSllQ-1; Mon, 12 Dec 2022 22:43:47 -0500
X-MC-Unique: 0nOSpGKIN3K1QcBmjoSllQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 m12-20020a9d6acc000000b006707706d25dso7016104otq.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 19:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=256Ct247/EiVmrEdEn67dwnBON0/XMOLy97CHVgBe6k=;
 b=BdfVJLu7w5s+ggMyVef8x6urIrjDLoXDcvH6sJaGnQssDCGQBFWqds/n5ojzixzzRI
 bvBddukiEVG2azl5L94u5gQuc10VIk8yllBYkZTWQ2lb5pgqoxZ2ahMuwyql0UgW4z8Y
 fHjAK7SKEnk8fvFue3xO7SnJplvyvlChdojccPkIMBVkMkSlltEsWtfqU/tB+ZLYJA4h
 3frqUdE6sSwyIgDVFfDqHDskvgbjCaB6XRZhVR0LK8ItBAYWzYyzhjhiU5uQGHfagosw
 rO28hdZGYr66pZlAOgh1z0i7CuCbM9sEubAXr47biP1MC88ChxjxO2dDvz6EHBQHVyXw
 X//w==
X-Gm-Message-State: ANoB5pmtjg9xRX3726oKVxw6B3e/fvVFBlyeQDgp6lgGmZab3fYhnEjo
 oNJcR8f7/YOJVto1dw1dUdavOxm04NM9LFX+Z1edXyeu4gPgIlfKPk0UMBiZf4cDk60OqecJa6E
 RpX520TVxenCXZFXVzpwF86SOVCa+olDb/m1bsFy/dpiphJT9eMH4oaLbNA==
X-Received: by 2002:a05:6808:114c:b0:35e:7a42:7ab5 with SMTP id
 u12-20020a056808114c00b0035e7a427ab5mr78520oiu.280.1670903027163; 
 Mon, 12 Dec 2022 19:43:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4i4kic2ykAAWbr0s266j2XeYnzV4cUv9APvGz4jsQq5Lkz/4gL5C2yVDhzy6BQW2tEKIdWrVGMCJkUIbL2Bvk=
X-Received: by 2002:a05:6808:114c:b0:35e:7a42:7ab5 with SMTP id
 u12-20020a056808114c00b0035e7a427ab5mr78511oiu.280.1670903026927; Mon, 12 Dec
 2022 19:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20221212091029.54390-1-jasowang@redhat.com>
 <20221212042144-mutt-send-email-mst@kernel.org>
 <1670902391.9610498-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1670902391.9610498-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 Dec 2022 11:43:36 +0800
Message-ID: <CACGkMEu=1CcoNvvV9M+QrG5sLUBoPYkZ3DvUe+pLc1fSvgLuHA@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: correctly enable callback during
 start_xmit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Tue, Dec 13, 2022 at 11:38 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Mon, 12 Dec 2022 04:25:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Dec 12, 2022 at 05:10:29PM +0800, Jason Wang wrote:
> > > Commit a7766ef18b33("virtio_net: disable cb aggressively") enables
> > > virtqueue callback via the following statement:
> > >
> > >         do {
> > >            ......
> > >     } while (use_napi && kick &&
> > >                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > >
> > > This will cause a missing call to virtqueue_enable_cb_delayed() when
> > > kick is false. Fixing this by removing the checking of the kick from
> > > the condition to make sure callback is enabled correctly.
> > >
> > > Fixes: a7766ef18b33 ("virtio_net: disable cb aggressively")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > The patch is needed for -stable.
> >
> > stable rules don't allow for theoretical fixes. Was a problem observed?

Yes, running a pktgen sample script can lead to a tx timeout.

> >
> > > ---
> > >  drivers/net/virtio_net.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 86e52454b5b5..44d7daf0267b 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -1834,8 +1834,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> > >
> > >             free_old_xmit_skbs(sq, false);
> > >
> > > -   } while (use_napi && kick &&
> > > -          unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > > +   } while (use_napi &&
> > > +            unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> > >
> >
> > A bit more explanation pls.  kick simply means !netdev_xmit_more -
> > if it's false we know there will be another packet, then transmissing
> > that packet will invoke virtqueue_enable_cb_delayed. No?
>
> It's just that there may be a next packet, but in fact there may not be.
> For example, the vq is full, and the driver stops the queue.

Exactly, when the queue is about to be full we disable tx and wait for
the next tx interrupt to re-enable tx.

Thanks

>
> Thanks.
>
> >
> >
> >
> >
> >
> > >     /* timestamp packet in software */
> > >     skb_tx_timestamp(skb);
> > > --
> > > 2.25.1
> >
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
